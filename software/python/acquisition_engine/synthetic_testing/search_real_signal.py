#!/usr/bin/env python3
"""
Multi-PRN, Multi-Time GNSS Search
"""
import numpy as np
import mmap
import struct
import os
import time

ADDR = {
    'carrier_nco_ctrl': 0x40000000, 'carrier_nco_ctrl_r': 0x40010000,
    'complex_conj_1': 0x40020000, 'complex_conj_2': 0x40030000,
    'complex_multiply': 0x40040000, 'complex_scale': 0x40050000,
    'ddr_to_stream_0_ctrl': 0x40060000, 'ddr_to_stream_0_ctrl_r': 0x40070000,
    'ddr_to_stream_1_ctrl': 0x40080000, 'ddr_to_stream_1_ctrl_r': 0x40090000,
    'peak_detector': 0x400A0000,
}

DDR_SIGNAL_I = 0x1E000000
DDR_SIGNAL_Q = 0x1E010000
DDR_WIPED_I  = 0x1E020000
DDR_WIPED_Q  = 0x1E030000
DDR_PRN_REAL = 0x40000000
DDR_PRN_IMAG = 0x40001000

SAMPLE_RATE = 4.092e6
NUM_SAMPLES = 1024

TIME_JUMPS_MS = [0, 100, 200, 300, 400, 500]
PRNS_TO_TEST = [1, 2, 3, 4, 5]
DOPPLERS_TO_TEST = [-2000.0, 0.0, 2000.0]

# [MemoryAccessor class - same as in full_pipeline_test_v3.py]
# [unpack_2bit_iq function - same as in final_real_test.py]
# [generate_prn_code function - same as in full_pipeline_test_v3.py]
# [run_fpga_acquisition function - same as in final_real_test.py]

def main():
    print("="*70)
    print("🛰️  MULTI-PRN, MULTI-TIME GNSS SEARCH")
    print("="*70)
    
    filename = "/root/GPS_L1_4FS_0IF_0dB_test1.bin"
    if not os.path.exists(filename):
        print(f"❌ Error: {filename} not found.")
        return

    # [Full implementation as provided earlier]
    # ... (use the full version from earlier in conversation)

if __name__ == "__main__":
    main()