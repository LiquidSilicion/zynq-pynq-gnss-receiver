#!/usr/bin/env python3
"""
Test FFT with simple sine wave to verify FFT is working
"""
import sys
sys.path.insert(0, '/root')
from full_pipeline_test_v3 import *

def test_fft_with_sine():
    print("="*70)
    print("🧪 Testing FFT with Simple Sine Wave")
    print("="*70)
    
    mem = MemoryAccessor()
    try:
        # Reset all IPs
        for name, addr in ADDR.items():
            if 'ctrl_r' not in name:
                mem.reset_ip(addr)
        
        # Generate a simple sine wave at 100 Hz
        print("\n📊 Generating sine wave at 100 Hz...")
        signal_I = []
        signal_Q = []
        freq = 100.0
        for i in range(NUM_SAMPLES):
            phase = 2 * math.pi * freq * i / SAMPLE_RATE
            signal_I.append(math.cos(phase))
            signal_Q.append(math.sin(phase))
        
        prn_code = generate_prn_code(PRN_ID, NUM_SAMPLES)
        prn_real = prn_code
        prn_imag = [0.0] * NUM_SAMPLES
        
        print("💾 Writing to DDR...")
        mem.write_float_array(DDR_SIGNAL_I, signal_I)
        mem.write_float_array(DDR_SIGNAL_Q, signal_Q)
        mem.write_float_array(DDR_PRN_REAL, prn_real)
        mem.write_float_array(DDR_PRN_IMAG, prn_imag)
        
        print("⚙️  Configuring IPs...")
        mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], OFF['signal_i_ptr'], DDR_SIGNAL_I)
        mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], OFF['signal_q_ptr'], DDR_SIGNAL_Q)
        mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], OFF['wiped_i_ptr'], DDR_WIPED_I)
        mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], OFF['wiped_q_ptr'], DDR_WIPED_Q)
        mem.write32(ADDR['carrier_nco_ctrl'] + OFF['num_samples'], NUM_SAMPLES)
        mem.write_float(ADDR['carrier_nco_ctrl'] + OFF['carrier_freq'], 0.0)
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
        
        print("🚀 Starting pipeline...")
        mem.start_ip(ADDR['peak_detector'])
        mem.start_ip(ADDR['complex_scale'])
        mem.start_ip(ADDR['complex_conj_2'])
        mem.start_ip(ADDR['complex_conj_1'])
        mem.start_ip(ADDR['complex_multiply'])
        mem.start_ip(ADDR['ddr_to_stream_1_ctrl'])
        mem.start_ip(ADDR['ddr_to_stream_0_ctrl'])
        mem.start_ip(ADDR['carrier_nco_ctrl'])
        
        print("⏳ Waiting for completion...")
        mem.wait_for_done(ADDR['carrier_nco_ctrl'], timeout=5.0)
        mem.wait_for_done(ADDR['peak_detector'], timeout=10.0)
        
        peak_power = mem.read_float(ADDR['peak_detector'] + 0x18)
        peak_index = mem.read32(ADDR['peak_detector'] + 0x28)
        
        print(f"\n📖 Results:")
        print(f"   Peak Power: {peak_power:.2f}")
        print(f"   Peak Index: {peak_index}")
        print(f"   Expected: ~100 (sine wave frequency)")
        
        if abs(peak_index - 100) < 10:
            print(f"   ✅ FFT appears to be working!")
        else:
            print(f"   ❌ FFT output is not at expected location")
        
    finally:
        mem.close()

if __name__ == "__main__":
    test_fft_with_sine()