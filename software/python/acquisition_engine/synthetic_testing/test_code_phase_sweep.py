#!/usr/bin/env python3
"""
Test if peak location changes correctly with different code phases
"""
import sys
import time
sys.path.insert(0, '/root')
from full_pipeline_test_v3 import *

def test_with_code_phase(code_phase):
    print(f"\n{'='*70}")
    print(f"🧪 Testing with Code Phase = {code_phase}")
    print(f"{'='*70}")
    
    mem = MemoryAccessor()
    try:
        # Reset all IPs
        for name, addr in ADDR.items():
            if 'ctrl_r' not in name:
                mem.reset_ip(addr)
        
        # Generate test data with specified code phase
        prn_code = generate_prn_code(PRN_ID, NUM_SAMPLES)
        signal_I, signal_Q = generate_test_signal(
            NUM_SAMPLES, TRUE_DOPPLER, SAMPLE_RATE, code_phase, prn_code
        )
        prn_real = prn_code
        prn_imag = [0.0] * NUM_SAMPLES
        
        # Write to DDR
        mem.write_float_array(DDR_SIGNAL_I, signal_I)
        mem.write_float_array(DDR_SIGNAL_Q, signal_Q)
        mem.write_float_array(DDR_PRN_REAL, prn_real)
        mem.write_float_array(DDR_PRN_IMAG, prn_imag)
        
        # Configure all IPs
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
        
        # Start pipeline
        mem.start_ip(ADDR['peak_detector'])
        mem.start_ip(ADDR['complex_scale'])
        mem.start_ip(ADDR['complex_conj_2'])
        mem.start_ip(ADDR['complex_conj_1'])
        mem.start_ip(ADDR['complex_multiply'])
        mem.start_ip(ADDR['ddr_to_stream_1_ctrl'])
        mem.start_ip(ADDR['ddr_to_stream_0_ctrl'])
        mem.start_ip(ADDR['carrier_nco_ctrl'])
        
        # Wait for completion
        mem.wait_for_done(ADDR['carrier_nco_ctrl'], timeout=5.0)
        mem.wait_for_done(ADDR['peak_detector'], timeout=10.0)
        
        # Small delay to ensure registers are fully updated
        time.sleep(0.01)
        
        # Read results
        peak_power = mem.read_float(ADDR['peak_detector'] + 0x18)
        peak_index = mem.read32(ADDR['peak_detector'] + 0x28)
        
        print(f"   Code Phase Input: {code_phase}")
        print(f"   Peak Power: {peak_power:.2f}")
        print(f"   Peak Index: {peak_index}")
        
        return {
            'code_phase': code_phase,
            'peak_power': peak_power,
            'peak_index': peak_index
        }
        
    finally:
        mem.close()

if __name__ == "__main__":
    print("="*70)
    print("🛰️  CODE PHASE SWEEP TEST")
    print("="*70)
    
    results = []
    for code_phase in [0, 100, 250, 500, 750]:
        result = test_with_code_phase(code_phase)
        results.append(result)
    
    print("\n" + "="*70)
    print("📊 SUMMARY")
    print("="*70)
    print(f"{'Code Phase':<12} {'Peak Power':<15} {'Peak Index':<12}")
    print("-" * 45)
    for r in results:
        print(f"{r['code_phase']:<12} {r['peak_power']:<15.2f} {r['peak_index']:<12}")
    print("="*70)