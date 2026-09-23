#!/usr/bin/env python3
"""
Test if FFT is working by checking if output changes with different inputs
"""
import sys
sys.path.insert(0, '/root')
from full_pipeline_test_v3 import *

def test_different_inputs():
    print("="*70)
    print("🧪 Testing FFT with Different Input Patterns")
    print("="*70)
    
    mem = MemoryAccessor()
    try:
        test_cases = [
            ("All zeros", [0.0] * NUM_SAMPLES, [0.0] * NUM_SAMPLES),
            ("All ones", [1.0] * NUM_SAMPLES, [0.0] * NUM_SAMPLES),
            ("Impulse at 0", [1.0] + [0.0] * (NUM_SAMPLES - 1), [0.0] * NUM_SAMPLES),
            ("Impulse at 512", [0.0] * 512 + [1.0] + [0.0] * 511, [0.0] * NUM_SAMPLES),
        ]
        
        for name, signal_I, signal_Q in test_cases:
            for ip_name, addr in ADDR.items():
                if 'ctrl_r' not in ip_name:
                    mem.reset_ip(addr)
            
            mem.write_float_array(DDR_SIGNAL_I, signal_I)
            mem.write_float_array(DDR_SIGNAL_Q, signal_Q)
            
            prn_code = generate_prn_code(PRN_ID, NUM_SAMPLES)
            mem.write_float_array(DDR_PRN_REAL, prn_code)
            mem.write_float_array(DDR_PRN_IMAG, [0.0] * NUM_SAMPLES)
            
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
            
            mem.start_ip(ADDR['peak_detector'])
            mem.start_ip(ADDR['complex_scale'])
            mem.start_ip(ADDR['complex_conj_2'])
            mem.start_ip(ADDR['complex_conj_1'])
            mem.start_ip(ADDR['complex_multiply'])
            mem.start_ip(ADDR['ddr_to_stream_1_ctrl'])
            mem.start_ip(ADDR['ddr_to_stream_0_ctrl'])
            mem.start_ip(ADDR['carrier_nco_ctrl'])
            
            mem.wait_for_done(ADDR['carrier_nco_ctrl'], timeout=5.0)
            mem.wait_for_done(ADDR['peak_detector'], timeout=10.0)
            
            peak_power = mem.read_float(ADDR['peak_detector'] + 0x18)
            peak_index = mem.read32(ADDR['peak_detector'] + 0x28)
            
            print(f"\n{name}:")
            print(f"   Peak Power: {peak_power:.2f}")
            print(f"   Peak Index: {peak_index}")
        
        print("\n" + "="*70)
        print("📊 Analysis:")
        print("="*70)
        print("If peak power is the SAME for all test cases, the FFT is not working.")
        print("If peak power varies, the FFT is working but correlation logic has issues.")
        
    finally:
        mem.close()

if __name__ == "__main__":
    test_different_inputs()