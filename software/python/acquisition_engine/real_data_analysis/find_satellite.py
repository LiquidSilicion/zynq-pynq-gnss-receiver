#!/usr/bin/env python3
"""
Fast software search to find satellite parameters.
Run this on your LAPTOP (not ZedBoard).
"""
import numpy as np
import os

FILENAME = "/home/johan2/Documents/event_horizon_data/GPS_L1_4FS_0IF_0dB_test1.bin"
SAMPLE_RATE = 4.092e6
NUM_SAMPLES = 1024
BYTES_PER_SAMPLE = 0.5

TIME_OFFSETS_MS = [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000]
PRNS = list(range(1, 33))
DOPPLERS = np.arange(-10000, 10001, 500)

def unpack_2bit_iq(filename, byte_offset, num_samples=1024):
    with open(filename, 'rb') as f:
        f.seek(byte_offset)
        raw_bytes = f.read(num_samples + 100)
    data = np.frombuffer(raw_bytes, dtype=np.uint8)
    s0, s1, s2, s3 = (data>>0)&3, (data>>2)&3, (data>>4)&3, (data>>6)&3
    samples = np.empty(4*len(data), dtype=np.int8)
    samples[0::4], samples[1::4], samples[2::4], samples[3::4] = s0, s1, s2, s3
    samples = samples[:2*num_samples]
    i, q = samples[0::2], samples[1::2]
    def map_2bit(x): return np.where(x==0,-3.,np.where(x==1,-1.,np.where(x==2,1.,3.)))
    return map_2bit(i)/3., map_2bit(q)/3.

def generate_prn_code(prn_id, num_chips=1023):
    g2_taps = {
        1:[2,6], 2:[3,7], 3:[4,8], 4:[5,9], 5:[1,9], 6:[2,10], 7:[1,8], 8:[2,9], 9:[3,10], 10:[2,3],
        11:[1,3,4,6], 12:[2,5,7,8,10], 13:[1,2,5,8,9,10], 14:[1,3,6,8,9,10], 15:[2,3,4,6,9,10],
        16:[3,4,5,7,9,10], 17:[1,2,4,5,6,8,9,10], 18:[2,3,5,6,8,9], 19:[1,3,5,6,7,9,10],
        20:[2,4,5,6,8,10], 21:[1,2,3,6,7,9,10], 22:[1,3,4,5,6,8,10], 23:[2,3,4,5,8,9,10],
        24:[2,3,4,6,7,9,10], 25:[1,3,5,6,8,10], 26:[2,3,5,6,9,10], 27:[1,2,3,6,8,10],
        28:[1,3,4,7,8,10], 29:[2,4,5,7,9,10], 30:[1,2,5,6,8,10], 31:[2,4,6,7,9,10],
        32:[1,2,3,5,7,9,10]
    }
    taps = g2_taps[prn_id]
    g1, g2 = [1]*10, [1]*10
    code = []
    for i in range(num_chips):
        output = g1[9]
        for tap in taps:
            output ^= g2[tap-1]
        code.append(1. if output else -1.)
        g1 = [g1[9]^g1[2]] + g1[:-1]
        g2 = [g2[9]^g2[8]^g2[7]^g2[5]^g2[2]^g2[1]] + g2[:-1]
    return code

print("="*70)
print("🛰️  SOFTWARE-ONLY SATELLITE SEARCH (LAPTOP)")
print("="*70)
print(f"File: {FILENAME}")
print(f"Search grid: {len(TIME_OFFSETS_MS)} times × {len(PRNS)} PRNs × {len(DOPPLERS)} Dopplers")
print(f"Total acquisitions: {len(TIME_OFFSETS_MS) * len(PRNS) * len(DOPPLERS)}")
print("This will take ~5-10 minutes in software...\n")

best = {'power': -1, 'prn': 0, 'time_ms': 0, 'doppler': 0, 'phase': 0}
N = NUM_SAMPLES
t = np.arange(N) / SAMPLE_RATE

prn_codes = {}
for prn in PRNS:
    code = generate_prn_code(prn, 1023)
    prn_codes[prn] = np.array(code + [code[0]], dtype=np.float32)

total = len(TIME_OFFSETS_MS) * len(PRNS) * len(DOPPLERS)
count = 0

for time_ms in TIME_OFFSETS_MS:
    byte_offset = int(time_ms * 1e-3 * SAMPLE_RATE * BYTES_PER_SAMPLE)
    signal_I, signal_Q = unpack_2bit_iq(FILENAME, byte_offset)
    signal_complex = signal_I + 1j * signal_Q
    
    for prn in PRNS:
        prn_padded = prn_codes[prn]
        freq_prn = np.fft.fft(prn_padded + 1j * 0.0)
        
        for doppler in DOPPLERS:
            carrier = np.exp(-1j * 2 * np.pi * doppler * t)
            freq_sig = np.fft.fft(signal_complex * carrier)
            corr_time = np.fft.ifft(freq_sig * np.conj(freq_prn))
            
            power = np.max((np.abs(corr_time) ** 2) / (N ** 2))
            
            if power > best['power']:
                best = {'power': power, 'prn': prn, 'time_ms': time_ms, 
                        'doppler': doppler, 'phase': int(np.argmax(np.abs(corr_time)))}
            
            count += 1
            if count % 500 == 0:
                print(f"   Progress: {count}/{total} ({100*count/total:.1f}%) - Current best: PRN {best['prn']} @ {best['doppler']:.0f}Hz, power={best['power']:.4f}")

print("\n" + "="*70)
print("🏆 BEST RESULT (SOFTWARE):")
print(f"   PRN:        {best['prn']}")
print(f"   Time Offset:{best['time_ms']} ms")
print(f"   Doppler:    {best['doppler']:.0f} Hz")
print(f"   Code Phase: {best['phase']} chips")
print(f"   Peak Power: {best['power']:.4f}")
print("="*70)
print("\n✅ Now take these parameters to the FPGA test script!")