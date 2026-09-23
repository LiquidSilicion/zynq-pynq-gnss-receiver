#!/usr/bin/env python3
"""
Final Real GPS Data Acquisition Test (2-bit 4FS format)
"""
import numpy as np
import mmap
import struct
import os
import time

ADDR = {
    'carrier_nco_ctrl':       0x40000000,
    'carrier_nco_ctrl_r':     0x40010000,
    'complex_conj_1':         0x40020000,
    'complex_conj_2':         0x40030000,
    'complex_multiply':       0x40040000,
    'complex_scale':          0x40050000,
    'ddr_to_stream_0_ctrl':   0x40060000,
    'ddr_to_stream_0_ctrl_r': 0x40070000,
    'ddr_to_stream_1_ctrl':   0x40080000,
    'ddr_to_stream_1_ctrl_r': 0x40090000,
    'peak_detector':          0x400A0000,
}

DDR_SIGNAL_I = 0x1E000000
DDR_SIGNAL_Q = 0x1E010000
DDR_WIPED_I  = 0x1E020000
DDR_WIPED_Q  = 0x1E030000
DDR_PRN_REAL = 0x1E040000
DDR_PRN_IMAG = 0x1E050000

SAMPLE_RATE = 4.092e6
NUM_SAMPLES = 1024
PRN_ID = 1
START_OFFSET_SECONDS = 0.0

def unpack_2bit_iq(filename, num_samples, start_offset_seconds, sample_rate):
    bytes_per_sample = 0.5
    start_byte_offset = int(start_offset_seconds * sample_rate * bytes_per_sample)
    
    with open(filename, 'rb') as f:
        f.seek(start_byte_offset)
        bytes_to_read = int(num_samples * bytes_per_sample) + 100
        raw_bytes = f.read(bytes_to_read)
    
    data = np.frombuffer(raw_bytes, dtype=np.uint8)
    
    s0 = (data >> 0) & 0x03
    s1 = (data >> 2) & 0x03
    s2 = (data >> 4) & 0x03
    s3 = (data >> 6) & 0x03
    
    samples = np.empty(4 * len(data), dtype=np.int8)
    samples[0::4] = s0
    samples[1::4] = s1
    samples[2::4] = s2
    samples[3::4] = s3
    
    samples = samples[:2 * num_samples]
    i_samples = samples[0::2]
    q_samples = samples[1::2]
    
    def map_2bit(x):
        return np.where(x == 0, -3.0,
               np.where(x == 1, -1.0,
               np.where(x == 2,  1.0, 3.0)))
    
    i_float = map_2bit(i_samples) / 3.0
    q_float = map_2bit(q_samples) / 3.0
    
    return i_float[:num_samples], q_float[:num_samples]

class MemoryAccessor:
    def __init__(self):
        self.fd = os.open("/dev/mem", os.O_RDWR | os.O_SYNC)
        self.mappings = {}
    
    def _get_mapping(self, base_addr, size=64*1024):
        page_aligned = base_addr & ~0xFFF
        if page_aligned not in self.mappings:
            self.mappings[page_aligned] = mmap.mmap(
                self.fd, size, mmap.MAP_SHARED,
                mmap.PROT_READ | mmap.PROT_WRITE, offset=page_aligned
            )
        return self.mappings[page_aligned], base_addr - page_aligned
    
    def read32(self, addr):
        m, offset = self._get_mapping(addr)
        m.seek(offset)
        return struct.unpack('<I', m.read(4))[0]
    
    def write32(self, addr, value):
        m, offset = self._get_mapping(addr)
        m.seek(offset)
        m.write(struct.pack('<I', value & 0xFFFFFFFF))
    
    def write_float(self, addr, value):
        m, offset = self._get_mapping(addr)
        m.seek(offset)
        m.write(struct.pack('<f', value))
    
    def read_float(self, addr):
        m, offset = self._get_mapping(addr)
        m.seek(offset)
        return struct.unpack('<f', m.read(4))[0]
    
    def write_pointer64(self, base_addr, offset, pointer_value):
        low  = pointer_value & 0xFFFFFFFF
        high = (pointer_value >> 32) & 0xFFFFFFFF
        self.write32(base_addr + offset, low)
        self.write32(base_addr + offset + 4, high)
    
    def write_float_array(self, base_addr, array):
        page_aligned = base_addr & ~0xFFF
        if page_aligned not in self.mappings:
            self.mappings[page_aligned] = mmap.mmap(
                self.fd, 2*1024*1024, mmap.MAP_SHARED,
                mmap.PROT_READ | mmap.PROT_WRITE, offset=page_aligned
            )
        m = self.mappings[page_aligned]
        offset = base_addr - page_aligned
        m.seek(offset)
        for val in array:
            m.write(struct.pack('<f', val))
        os.sync()
    
    def close(self):
        for m in self.mappings.values():
            m.close()
        os.close(self.fd)

def generate_prn_code(prn_id, num_chips=1023):
    g2_taps = {1: [2, 6], 2: [3, 7], 3: [4, 8], 4: [5, 9], 5: [1, 9],
               6: [2, 10], 7: [1, 8], 8: [2, 9], 9: [3, 10], 10: [2, 3]}
    tap1, tap2 = g2_taps[prn_id]
    g1 = [1] * 10
    g2 = [1] * 10
    code = []
    for i in range(num_chips):
        output = g1[9] ^ g2[tap1-1] ^ g2[tap2-1]
        code.append(1.0 if output == 1 else -1.0)
        g1_fb = g1[9] ^ g1[2]
        g2_fb = g2[9] ^ g2[8] ^ g2[7] ^ g2[5] ^ g2[2] ^ g2[1]
        g1 = [g1_fb] + g1[:-1]
        g2 = [g2_fb] + g2[:-1]
    return code

def run_acquisition(mem, signal_I, signal_Q, prn_padded, doppler_freq):
    mem.write_float_array(DDR_SIGNAL_I, signal_I)
    mem.write_float_array(DDR_SIGNAL_Q, signal_Q)
    mem.write_float_array(DDR_PRN_REAL, prn_padded)
    mem.write_float_array(DDR_PRN_IMAG, [0.0] * NUM_SAMPLES)
    
    mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], 0x10, DDR_SIGNAL_I)
    mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], 0x1C, DDR_SIGNAL_Q)
    mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], 0x28, DDR_WIPED_I)
    mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], 0x34, DDR_WIPED_Q)
    mem.write32(ADDR['carrier_nco_ctrl'] + 0x10, NUM_SAMPLES)
    mem.write_float(ADDR['carrier_nco_ctrl'] + 0x18, doppler_freq)
    mem.write_float(ADDR['carrier_nco_ctrl'] + 0x20, SAMPLE_RATE)
    mem.write_float(ADDR['carrier_nco_ctrl'] + 0x28, 0.0)
    
    mem.write_pointer64(ADDR['ddr_to_stream_0_ctrl_r'], 0x10, DDR_WIPED_I)
    mem.write_pointer64(ADDR['ddr_to_stream_0_ctrl_r'], 0x1C, DDR_WIPED_Q)
    mem.write32(ADDR['ddr_to_stream_0_ctrl'] + 0x10, NUM_SAMPLES)
    
    mem.write_pointer64(ADDR['ddr_to_stream_1_ctrl_r'], 0x10, DDR_PRN_REAL)
    mem.write_pointer64(ADDR['ddr_to_stream_1_ctrl_r'], 0x1C, DDR_PRN_IMAG)
    mem.write32(ADDR['ddr_to_stream_1_ctrl'] + 0x10, NUM_SAMPLES)
    
    mem.write32(ADDR['complex_multiply'] + 0x10, NUM_SAMPLES)
    mem.write32(ADDR['complex_conj_1'] + 0x10, NUM_SAMPLES)
    mem.write32(ADDR['complex_conj_2'] + 0x10, NUM_SAMPLES)
    mem.write32(ADDR['complex_scale'] + 0x10, NUM_SAMPLES)
    mem.write_float(ADDR['complex_scale'] + 0x18, 1.0 / 1024.0)
    mem.write32(ADDR['peak_detector'] + 0x10, NUM_SAMPLES)
    
    for addr in [ADDR['carrier_nco_ctrl'], ADDR['ddr_to_stream_0_ctrl'],
                 ADDR['ddr_to_stream_1_ctrl'], ADDR['complex_multiply'],
                 ADDR['complex_conj_1'], ADDR['complex_conj_2'],
                 ADDR['complex_scale'], ADDR['peak_detector']]:
        mem.write32(addr + 0x00, 0x10)
        time.sleep(0.001)
        mem.write32(addr + 0x00, 0x00)
        time.sleep(0.001)
        mem.write32(addr + 0x00, 0x01)
    
    start = time.time()
    while time.time() - start < 10.0:
        if (mem.read32(ADDR['peak_detector'] + 0x00) >> 1) & 1:
            break
        time.sleep(0.001)
    
    return mem.read_float(ADDR['peak_detector'] + 0x18), mem.read32(ADDR['peak_detector'] + 0x28)

def main():
    print("="*70)
    print("🛰️  FINAL REAL DATA ACQUISITION TEST")
    print("="*70)
    
    filename = "/root/test_chunk.bin"
    if not os.path.exists(filename):
        print(f"❌ Error: {filename} not found.")
        return
        
    print(f"\n📂 Loading data from {filename}...")
    signal_I, signal_Q = unpack_2bit_iq(filename, NUM_SAMPLES, START_OFFSET_SECONDS, SAMPLE_RATE)
    print(f"   Loaded {len(signal_I)} samples.")
    
    mem = MemoryAccessor()
    try:
        prn_code = generate_prn_code(PRN_ID, 1023)
        prn_padded = np.array(prn_code + [prn_code[0]], dtype=np.float32)
        
        print("\n🔍 Searching Doppler bins: -2000 Hz, 0 Hz, +2000 Hz")
        best_power = -1
        best_doppler = 0
        best_index = 0
        
        for doppler in [-2000.0, 0.0, 2000.0]:
            power, index = run_acquisition(mem, signal_I, signal_Q, prn_padded, doppler)
            print(f"   Doppler {doppler:6.0f} Hz: Power = {power:8.2f}, Index = {index:4d}")
            if power > best_power:
                best_power = power
                best_doppler = doppler
                best_index = index
                
        print("\n" + "="*70)
        print("🏆 BEST RESULT:")
        print(f"   Doppler:    {best_doppler:.0f} Hz")
        print(f"   Code Phase: {best_index} chips")
        print(f"   Peak Power: {best_power:.2f}")
        print("="*70)
        
        if best_power > 50.0:
            print("✅ SUCCESS: Valid correlation peak detected in real data!")
        else:
            print("⚠️  Peak is low. The satellite might not be in this specific 1ms chunk.")
            
    finally:
        mem.close()

if __name__ == "__main__":
    main()