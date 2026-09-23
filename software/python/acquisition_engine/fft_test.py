#!/usr/bin/env python3
"""
FFT-Based GNSS Acquisition - CORRECTED VERSION
Fixes Doppler sign and code phase wrap-around conventions.
"""

import numpy as np
import time
import math

# GPS L1 C/A parameters
CODE_LENGTH = 1023
SAMPLE_RATE = 1.023e6  # 1 sample per chip (simplified)
FFT_SIZE = 1024  # Next power of 2 above 1023

def generate_gps_prn(prn_id):
    """Generate GPS L1 C/A PRN code"""
    g2_taps = {
        1: [2,6], 2: [3,7], 3: [4,8], 4: [5,9], 5: [1,9],
        6: [2,10], 7: [1,8], 8: [2,9], 9: [3,10], 10: [2,3],
        11: [3,4], 12: [5,6], 13: [6,7], 14: [7,8], 15: [8,9],
        16: [9,10], 17: [1,4], 18: [2,5], 19: [3,6], 20: [4,7],
        21: [5,8], 22: [6,9], 23: [1,3], 24: [4,6], 25: [5,7],
        26: [6,8], 27: [7,9], 28: [8,10], 29: [1,6], 30: [2,7],
        31: [3,8], 32: [4,9]
    }
    taps = g2_taps[prn_id]
    g1 = [1] * 10
    g2 = [1] * 10
    code = []
    for _ in range(1023):
        output = g1[9] ^ g2[taps[0]-1] ^ g2[taps[1]-1]
        code.append(1.0 if output == 1 else -1.0)
        g1_fb = g1[9] ^ g1[2]
        g2_fb = g2[9] ^ g2[8] ^ g2[7] ^ g2[5] ^ g2[2] ^ g2[1]
        g1 = [g1_fb] + g1[:-1]
        g2 = [g2_fb] + g2[:-1]
    return np.array(code)

def generate_synthetic_signal(prn_code, true_doppler, true_code_phase, num_samples, snr_db=10):
    """Generate synthetic GPS signal"""
    signal_power = 1.0
    noise_power = signal_power / (10 ** (snr_db / 10))
    noise_std = math.sqrt(noise_power)
    
    t = np.arange(num_samples) / SAMPLE_RATE
    # Standard GNSS convention: signal = PRN * exp(+j*2π*f_d*t)
    carrier = np.exp(1j * 2 * np.pi * true_doppler * t)
    
    code_idx = (np.arange(num_samples) + true_code_phase).astype(int) % len(prn_code)
    code_signal = prn_code[code_idx]
    
    signal = code_signal * carrier
    noise = (np.random.randn(num_samples) + 1j * np.random.randn(num_samples)) * noise_std
    
    return signal + noise

def fft_acquisition(signal, prn_code, doppler_range=(-10000, 10000, 500)):
    """
    FFT-based parallel code phase search (PCPS) - CORRECTED
    """
    # Zero-pad to FFT size
    signal_padded = np.zeros(FFT_SIZE, dtype=complex)
    signal_padded[:len(signal)] = signal
    
    code_padded = np.zeros(FFT_SIZE, dtype=complex)
    code_padded[:len(prn_code)] = prn_code
    
    # FFT of code (pre-computed once per PRN)
    code_fft = np.fft.fft(code_padded)
    
    doppler_min, doppler_max, doppler_step = doppler_range
    doppler_bins = np.arange(doppler_min, doppler_max + doppler_step, doppler_step)
    
    best_power = 0
    best_doppler = 0
    best_code_phase = 0
    
    for doppler in doppler_bins:
        # FIX: Use NEGATIVE frequency shift to remove Doppler
        # Signal has exp(+j*2π*f_d*t), so multiply by exp(-j*2π*f_d*t) to wipe off
        freq_shift = np.exp(-1j * 2 * np.pi * doppler * np.arange(FFT_SIZE) / SAMPLE_RATE)
        shifted_signal = signal_padded * freq_shift
        shifted_signal_fft = np.fft.fft(shifted_signal)
        
        # Circular correlation via FFT
        correlation = np.fft.ifft(shifted_signal_fft * np.conj(code_fft))
        
        # Find peak (only first 1023 samples are valid)
        power = np.abs(correlation[:CODE_LENGTH])**2
        peak_idx = np.argmax(power)
        peak_power = power[peak_idx]
        
        if peak_power > best_power:
            best_power = peak_power
            best_doppler = doppler
            # FIX: Handle circular correlation wrap-around
            # If peak is in second half, convert to equivalent negative offset
            if peak_idx > CODE_LENGTH // 2:
                best_code_phase = peak_idx - FFT_SIZE
            else:
                best_code_phase = peak_idx
    
    return best_doppler, best_code_phase, best_power

# Test it!
print("="*70)
print("🚀 FFT-Based GNSS Acquisition Test (CORRECTED)")
print("="*70)

prn_code = generate_gps_prn(1)
TRUE_DOPPLER = 1500.0
TRUE_CODE_PHASE = 250
NUM_SAMPLES = 1023

print(f"\n📊 Generating synthetic signal...")
print(f"   True Doppler: {TRUE_DOPPLER} Hz")
print(f"   True Code Phase: {TRUE_CODE_PHASE} chips")

signal = generate_synthetic_signal(prn_code, TRUE_DOPPLER, TRUE_CODE_PHASE, NUM_SAMPLES)

print(f"\n🔍 Running FFT-based acquisition...")
start = time.perf_counter()
det_doppler, det_code_phase, det_power = fft_acquisition(signal, prn_code)
elapsed = time.perf_counter() - start

print(f"\n🎯 RESULTS:")
print(f"   Detected Doppler: {det_doppler} Hz (error: {abs(det_doppler - TRUE_DOPPLER):.1f} Hz)")
print(f"   Detected Code Phase: {det_code_phase} chips (error: {abs(det_code_phase - TRUE_CODE_PHASE)} chips)")
print(f"   Peak Power: {det_power:.2f}")
print(f"   Search Time: {elapsed*1000:.2f} ms")

print(f"\n✅ FFT acquisition complete!")
print(f"   This searched 41 Doppler bins × 1023 code phases = 41,943 cells")
print(f"   In just {elapsed*1000:.2f} ms!")