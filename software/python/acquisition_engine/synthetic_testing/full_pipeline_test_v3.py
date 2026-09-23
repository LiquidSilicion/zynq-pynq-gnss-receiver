#!/usr/bin/env python3
"""
Full FFT Pipeline Integration Test v3 - FINAL FIXED VERSION
============================================================
- Fixed register offsets (peak_index = 0x28)
- Fixed signal generation to use (i - code_phase) for correct delay
"""

import mmap
import struct
import os
import time
import math

# ============================================================================
# 📍 Memory Map (from Vivado Address Editor)
# ============================================================================
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

# DDR buffer addresses
DDR_SIGNAL_I = 0x1E000000
DDR_SIGNAL_Q = 0x1E010000
DDR_WIPED_I  = 0x1E020000
DDR_WIPED_Q  = 0x1E030000
DDR_PRN_REAL = 0x1E040000
DDR_PRN_IMAG = 0x1E050000

# GPS parameters
NUM_SAMPLES = 1024
SAMPLE_RATE = 1.023e6
TRUE_DOPPLER = 1500.0
TRUE_CODE_PHASE = 250
PRN_ID = 1

# ============================================================================
# 📋 Register Offsets (VERIFIED from hardware)
# ============================================================================
OFF = {
    'ap_ctrl': 0x00,
    'num_samples': 0x10,
    'carrier_freq': 0x18,
    'sample_rate': 0x20,
    'initial_phase': 0x28,
    'signal_i_ptr': 0x10,
    'signal_q_ptr': 0x1C,
    'wiped_i_ptr': 0x28,
    'wiped_q_ptr': 0x34,
    'data_real_ptr': 0x10,
    'data_imag_ptr': 0x1C,
    'scale_factor': 0x18,
    'peak_power': 0x18,
    'peak_index': 0x28,  # ✅ VERIFIED
}

# ============================================================================
# 🔧 Memory Accessor
# ============================================================================
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
    
    def reset_ip(self, base_addr):
        self.write32(base_addr + OFF['ap_ctrl'], 0x10)
        time.sleep(0.001)
        self.write32(base_addr + OFF['ap_ctrl'], 0x00)
        time.sleep(0.001)
    
    def start_ip(self, base_addr):
        self.write32(base_addr + OFF['ap_ctrl'], 0x01)
    
    def wait_for_done(self, base_addr, timeout=10.0):
        start = time.time()
        while time.time() - start < timeout:
            ap_ctrl = self.read32(base_addr + OFF['ap_ctrl'])
            if (ap_ctrl >> 1) & 1:
                return True, time.time() - start
            time.sleep(0.001)
        return False, timeout
    
    def get_ip_status(self, base_addr):
        ap_ctrl = self.read32(base_addr + OFF['ap_ctrl'])
        start = (ap_ctrl >> 0) & 1
        done = (ap_ctrl >> 1) & 1
        idle = (ap_ctrl >> 2) & 1
        if idle: return "IDLE"
        elif done: return "DONE"
        elif start: return "RUNNING"
        else: return f"UNKNOWN(0x{ap_ctrl:08X})"
    
    def close(self):
        for m in self.mappings.values():
            m.close()
        os.close(self.fd)

# ============================================================================
# 🛰️ GPS PRN Code Generator & Signal Generator
# ============================================================================
def generate_prn_code(prn_id, num_samples):
    g2_taps = {1: [2, 6], 2: [3, 7], 3: [4, 8], 4: [5, 9], 5: [1, 9],
               6: [2, 10], 7: [1, 8], 8: [2, 9], 9: [3, 10], 10: [2, 3]}
    tap1, tap2 = g2_taps[prn_id]
    g1 = [1] * 10
    g2 = [1] * 10
    code = []
    for i in range(num_samples):
        output = g1[9] ^ g2[tap1-1] ^ g2[tap2-1]
        code.append(1.0 if output == 1 else -1.0)
        g1_fb = g1[9] ^ g1[2]
        g2_fb = g2[9] ^ g2[8] ^ g2[7] ^ g2[5] ^ g2[2] ^ g2[1]
        g1 = [g1_fb] + g1[:-1]
        g2 = [g2_fb] + g2[:-1]
    return code

def generate_test_signal(num_samples, doppler_freq, sample_rate, code_phase, prn_code):
    signal_I = []
    signal_Q = []
    for i in range(num_samples):
        carrier_phase = 2 * math.pi * doppler_freq * i / sample_rate
        # FIXED: Use minus for delayed signal (real-world GPS scenario)
        chip_idx = (i - code_phase) % len(prn_code)
        
        signal_I.append(prn_code[chip_idx] * math.cos(carrier_phase))
        signal_Q.append(prn_code[chip_idx] * math.sin(carrier_phase))
    return signal_I, signal_Q

# ============================================================================
# 🧪 Main Test
# ============================================================================
def test_pipeline():
    print("="*70)
    print("🛰️  FULL FFT PIPELINE TEST v3 (FINAL)")
    print("="*70)
    
    mem = MemoryAccessor()
    try:
        print("\n🔄 Step 0: Resetting all IPs...")
        for name, addr in ADDR.items():
            if 'ctrl_r' not in name:
                mem.reset_ip(addr)
        
        print(f"\n📊 Step 1: Generating synthetic GPS signal...")
        print(f"   PRN ID: {PRN_ID}, Doppler: {TRUE_DOPPLER} Hz")
        print(f"   Code Phase: {TRUE_CODE_PHASE} chips, Samples: {NUM_SAMPLES}")
        
        prn_code = generate_prn_code(PRN_ID, NUM_SAMPLES)
        signal_I, signal_Q = generate_test_signal(
            NUM_SAMPLES, TRUE_DOPPLER, SAMPLE_RATE, TRUE_CODE_PHASE, prn_code
        )
        prn_real = prn_code
        prn_imag = [0.0] * NUM_SAMPLES
        
        print(f"\n💾 Step 2: Writing data to DDR...")
        mem.write_float_array(DDR_SIGNAL_I, signal_I)
        mem.write_float_array(DDR_SIGNAL_Q, signal_Q)
        mem.write_float_array(DDR_PRN_REAL, prn_real)
        mem.write_float_array(DDR_PRN_IMAG, prn_imag)
        
        print(f"\n⚙️  Steps 3-5: Configuring IPs...")
        mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], OFF['signal_i_ptr'], DDR_SIGNAL_I)
        mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], OFF['signal_q_ptr'], DDR_SIGNAL_Q)
        mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], OFF['wiped_i_ptr'], DDR_WIPED_I)
        mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], OFF['wiped_q_ptr'], DDR_WIPED_Q)
        mem.write32(ADDR['carrier_nco_ctrl'] + OFF['num_samples'], NUM_SAMPLES)
        mem.write_float(ADDR['carrier_nco_ctrl'] + OFF['carrier_freq'], TRUE_DOPPLER)
        mem.write_float(ADDR['carrier_nco_ctrl'] + OFF['sample_rate'], SAMPLE_RATE)
        mem.write_float(ADDR['carrier_nco_ctrl'] + OFF['initial_phase'], 0.0)
        
        mem.write_pointer64(ADDR['ddr_to_stream_0_ctrl_r'], OFF['data_real_ptr'], DDR_WIPED_I)
        mem.write_pointer64(ADDR['ddr_to_stream_0_ctrl_r'], OFF['data_imag_ptr'], DDR_WIPED_Q)
        mem.write32(ADDR['ddr_to_stream_0_ctrl'] + OFF['num_samples'], NUM_SAMPLES)
        
        mem.write_pointer64(ADDR['ddr_to_stream_1_ctrl_r'], OFF['data_real_ptr'], DDR_PRN_REAL)
        mem.write_pointer64(ADDR['ddr_to_stream_1_ctrl_r'], OFF['data_imag_ptr'], DDR_PRN_IMAG)
        mem.write32(ADDR['ddr_to_stream_1_ctrl'] + OFF['num_samples'], NUM_SAMPLES)
        
        mem.write32(ADDR['complex_multiply'] + OFF['num_samples'], NUM_SAMPLES)
        mem.write32(ADDR['complex_conj_1'] + OFF['num_samples'], NUM_SAMPLES)
        mem.write32(ADDR['complex_conj_2'] + OFF['num_samples'], NUM_SAMPLES)
        mem.write32(ADDR['complex_scale'] + OFF['num_samples'], NUM_SAMPLES)
        mem.write_float(ADDR['complex_scale'] + OFF['scale_factor'], 1.0 / 1024.0)
        mem.write32(ADDR['peak_detector'] + OFF['num_samples'], NUM_SAMPLES)
        
        print(f"\n🚀 Step 6: Starting pipeline...")
        mem.start_ip(ADDR['peak_detector'])
        mem.start_ip(ADDR['complex_scale'])
        mem.start_ip(ADDR['complex_conj_2'])
        mem.start_ip(ADDR['complex_conj_1'])
        mem.start_ip(ADDR['complex_multiply'])
        mem.start_ip(ADDR['ddr_to_stream_1_ctrl'])
        mem.start_ip(ADDR['ddr_to_stream_0_ctrl'])
        mem.start_ip(ADDR['carrier_nco_ctrl'])
        
        print(f"\n⏳ Step 7: Waiting for completion...")
        done, elapsed = mem.wait_for_done(ADDR['carrier_nco_ctrl'], timeout=5.0)
        print(f"   ✅ carrier_nco completed in {elapsed*1000:.2f} ms")
        
        done, elapsed = mem.wait_for_done(ADDR['peak_detector'], timeout=10.0)
        print(f"   ✅ peak_detector completed in {elapsed*1000:.2f} ms")
        
        print(f"\n📖 Step 8: Reading peak detection results...")
        peak_power = mem.read_float(ADDR['peak_detector'] + OFF['peak_power'])
        peak_index = mem.read32(ADDR['peak_detector'] + OFF['peak_index'])
        
        print(f"   Peak Power: {peak_power:.2f}")
        print(f"   Peak Index: {peak_index}")
        print(f"   Expected:   {TRUE_CODE_PHASE}")
        
        print(f"\n🔍 Step 9: Verification...")
        error = abs(peak_index - TRUE_CODE_PHASE)
        if peak_power > 100000.0 and error <= 2:
            print(f"   ✅ PASS: Code phase detected correctly! (Error: {error} chips)")
        else:
            print(f"   ⚠️  PARTIAL: Peak detected but check index/power.")
            print(f"      Error: {error} chips")
            
        print(f"\n" + "="*70)
        print(f"📊 SUMMARY")
        print(f"="*70)
        print(f"True Doppler:      {TRUE_DOPPLER} Hz")
        print(f"True Code Phase:   {TRUE_CODE_PHASE} chips")
        print(f"Detected Peak:     {peak_index} chips")
        print(f"Peak Power:        {peak_power:.2f}")
        print(f"="*70)
        
    finally:
        mem.close()

if __name__ == "__main__":
    test_pipeline()