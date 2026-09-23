#!/usr/bin/env python3
"""
Time-Shift Tracking Test
If the peak is a real satellite, it will "track" smoothly across time shifts.
"""
import numpy as np
import os

def unpack_2bit_iq(filename, byte_offset, num_samples=1024):
    with open(filename, 'rb') as f:
        f.seek(byte_offset)
        raw_bytes = f.read(num_samples + 100)
    
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
    
    return map_2bit(i_samples) / 3.0, map_2bit(q_samples) / 3.0

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
        g1 = [g1[9] ^ g1[2]] + g1[:-1]
        g2 = [g2[9] ^ g2[8] ^ g2[7] ^ g2[5] ^ g2[2] ^ g2[1]] + g2[:-1]
    return code

def correlate(signal_I, signal_Q, prn_padded, doppler=0.0, fs=4.092e6):
    N = len(signal_I)
    t = np.arange(N) / fs
    carrier = np.exp(-1j * 2 * np.pi * doppler * t)
    signal_complex = (signal_I + 1j * signal_Q) * carrier
    freq_sig = np.fft.fft(signal_complex)
    freq_prn = np.fft.fft(prn_padded + 1j * 0.0)
    corr_time = np.fft.ifft(freq_sig * np.conj(freq_prn))
    power = (np.abs(corr_time) ** 2) / (N ** 2)
    return np.max(power), np.argmax(power)

print("="*70)
print("🕐 TIME-SHIFT TRACKING TEST")
print("="*70)
print("If this is a real satellite, the peak will shift predictably.")
print("If it's noise, the peak will jump randomly.\n")

filename = "/home/johan2/Documents/event_horizon_data/GPS_L1_4FS_0IF_0dB_test1.bin"
SAMPLE_RATE = 4.092e6
BYTES_PER_SAMPLE = 0.5
MS_PER_CHUNK = 1.0

prn_code = generate_prn_code(1, 1023)
prn_padded = np.array(prn_code + [prn_code[0]], dtype=np.float32)

print(f"{'Offset (ms)':<12} {'Peak Power':<12} {'Code Phase':<12} {'Status'}")
print("-" * 55)

prev_power = None
prev_phase = None
tracking_count = 0

for ms_offset in range(5):
    byte_offset = int(ms_offset * MS_PER_CHUNK * SAMPLE_RATE * BYTES_PER_SAMPLE)
    signal_I, signal_Q = unpack_2bit_iq(filename, byte_offset)
    
    best_power = -1
    best_phase = -1
    for doppler in [-500, 0, 500]:
        power, phase = correlate(signal_I, signal_Q, prn_padded, doppler)
        if power > best_power:
            best_power = power
            best_phase = phase
    
    status = ""
    if prev_power is not None:
        power_ratio = best_power / prev_power if prev_power > 0 else 0
        phase_diff = (best_phase - prev_phase) % 1024
        
        if power_ratio > 0.3 and power_ratio < 3.0 and phase_diff <= 3:
            status = "✅ TRACKING"
            tracking_count += 1
        else:
            status = "❌ LOST"
    else:
        status = "(baseline)"
    
    print(f"{ms_offset:<12} {best_power:<12.2f} {best_phase:<12} {status}")
    
    prev_power = best_power
    prev_phase = best_phase

print("\n" + "="*70)
if tracking_count >= 3:
    print("✅ CONFIRMED: This is a REAL SATELLITE!")
elif tracking_count >= 1:
    print("⚠️  LIKELY REAL: Some tracking observed.")
else:
    print("❌ LIKELY FALSE ALARM: Peak did not track across time.")
print("="*70)