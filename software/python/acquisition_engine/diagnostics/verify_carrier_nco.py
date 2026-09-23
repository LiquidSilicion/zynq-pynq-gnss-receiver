#!/usr/bin/env python3
"""
Verify carrier_nco output is correct
"""
import sys
sys.path.insert(0, '/root')
from full_pipeline_test_v3 import *

def verify_carrier_nco():
    print("="*70)
    print("🔍 Verifying Carrier NCO Output")
    print("="*70)
    
    mem = MemoryAccessor()
    try:
        # Reset carrier_nco
        mem.reset_ip(ADDR['carrier_nco_ctrl'])
        
        # Generate GPS signal with known code phase
        prn_code = generate_prn_code(PRN_ID, NUM_SAMPLES)
        signal_I, signal_Q = generate_test_signal(
            NUM_SAMPLES, TRUE_DOPPLER, SAMPLE_RATE, TRUE_CODE_PHASE, prn_code
        )
        
        # Write to DDR
        mem.write_float_array(DDR_SIGNAL_I, signal_I)
        mem.write_float_array(DDR_SIGNAL_Q, signal_Q)
        
        # Configure carrier_nco
        mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], OFF['signal_i_ptr'], DDR_SIGNAL_I)
        mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], OFF['signal_q_ptr'], DDR_SIGNAL_Q)
        mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], OFF['wiped_i_ptr'], DDR_WIPED_I)
        mem.write_pointer64(ADDR['carrier_nco_ctrl_r'], OFF['wiped_q_ptr'], DDR_WIPED_Q)
        mem.write32(ADDR['carrier_nco_ctrl'] + OFF['num_samples'], NUM_SAMPLES)
        mem.write_float(ADDR['carrier_nco_ctrl'] + OFF['carrier_freq'], TRUE_DOPPLER)
        mem.write_float(ADDR['carrier_nco_ctrl'] + OFF['sample_rate'], SAMPLE_RATE)
        mem.write_float(ADDR['carrier_nco_ctrl'] + OFF['initial_phase'], 0.0)
        
        # Start carrier_nco
        mem.start_ip(ADDR['carrier_nco_ctrl'])
        mem.wait_for_done(ADDR['carrier_nco_ctrl'], timeout=5.0)
        
        # Read wiped data
        wiped_I = mem.read_float_array(DDR_WIPED_I, 20)
        wiped_Q = mem.read_float_array(DDR_WIPED_Q, 20)
        
        print("\n📊 First 20 samples of wiped data:")
        print(f"{'Sample':<8} {'Wiped I':<12} {'Wiped Q':<12} {'Expected I':<12}")
        print("-" * 50)
        for i in range(20):
            expected_I = prn_code[(i + TRUE_CODE_PHASE) % NUM_SAMPLES]
            print(f"{i:<8} {wiped_I[i]:<12.4f} {wiped_Q[i]:<12.4f} {expected_I:<12.4f}")
        
        # Check if wiped_I matches PRN code
        print("\n🔍 Analysis:")
        q_rms = math.sqrt(sum(q*q for q in wiped_Q) / len(wiped_Q))
        print(f"   Wiped Q RMS: {q_rms:.6f} (should be ~0)")
        
        if q_rms < 0.01:
            print("   ✅ Carrier wipeoff is working correctly")
        else:
            print("   ❌ Carrier wipeoff has issues")
        
    finally:
        mem.close()

if __name__ == "__main__":
    verify_carrier_nco()