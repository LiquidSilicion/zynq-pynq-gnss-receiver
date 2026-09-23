#!/usr/bin/env python3
"""
Dense Doppler Search - Real satellites show smooth ambiguity function shape
"""
import numpy as np

def unpack_2bit_iq(filename, num_samples=1024):
    with open(filename, 'rb') as f:
        raw_bytes = f.read(num_samples + 100)
    data = np.frombuffer(raw_bytes, dtype=np.uint8)
    s0, s1, s2, s3 = (data>>0)&3, (data>>2)&3, (data>>4)&3, (data>>6)&3
    samples = np.empty(4*len(data), dtype=np.int8)
    samples[0::4], samples[1::4], samples[2::4], samples[3::4] = s0, s1, s2, s3
    samples = samples[:2*num_samples]
    i, q = samples[0::2], samples[1::2]
    def map_2bit(x):
        return np.where(x==0,-3.,np.where(x==1,-1.,np.where(x==2,1.,3.)))
    return map_2bit(i)/3., map_2bit(q)/3.

def generate_prn_code(prn_id, num_chips=1023):
    g2_taps = {1:[2,6], 2:[3,7], 3:[4,8], 4:[5,9], 5:[1,9],
               6:[2,10], 7:[1,8], 8:[2,9], 9:[3,10], 10:[2,3]}
    tap1, tap2 = g2_taps[prn_id]
    g1, g2 = [1]*10, [1]*10
    code = []
    for i in range(num_chips):
        output = g1[9] ^ g2[tap1-1] ^ g2[tap2-1]
        code.append(1. if output==1 else -1.)
        g1 = [g1[9]^g1[2]] + g1[:-1]
        g2 = [g2[9]^g2[8]^g2[7]^g2[5]^g2[2]^g2[1]] + g2[:-1]
    return code

signal_I, signal_Q = unpack_2bit_iq("/root/test_chunk.bin")
prn_code = generate_prn_code(1, 1023)
prn_padded = np.array(prn_code + [prn_code[0]], dtype=np.float32)

N = len(signal_I)
fs = 4.092e6
t = np.arange(N) / fs

print("="*70)
print("📡 DENSE DOPPLER SEARCH (PRN 1)")
print("="*70)

results = []
for doppler in np.arange(-5000, 5001, 250):
    carrier = np.exp(-1j * 2 * np.pi * doppler * t)
    signal_complex = (signal_I + 1j * signal_Q) * carrier
    freq_sig = np.fft.fft(signal_complex)
    freq_prn = np.fft.fft(prn_padded + 1j * 0.0)
    corr_time = np.fft.ifft(freq_sig * np.conj(freq_prn))
    power = np.max((np.abs(corr_time) ** 2) / (N ** 2))
    results.append((doppler, power))

results.sort(key=lambda x: x[1], reverse=True)
peak_doppler, peak_power = results[0]

all_powers = [r[1] for r in results]
noise_floor = np.median(all_powers)
pnr = peak_power / noise_floor

print(f"\n🏆 Peak: Doppler = {peak_doppler:7.0f} Hz, Power = {peak_power:8.2f}")
print(f"📊 Noise Floor (median): {noise_floor:.2f}")
print(f"📈 Peak-to-Noise Ratio: {pnr:.2f}x\n")

print("Top 5 Doppler bins:")
for i, (d, p) in enumerate(results[:5]):
    print(f"   {i+1}. Doppler {d:7.0f} Hz: Power = {p:8.2f}")

print("\n" + "="*70)
if pnr > 3.0:
    print("✅ STRONG DETECTION: PNR > 3.0 is convincing.")
elif pnr > 2.0:
    print("⚠️  MARGINAL DETECTION: PNR 2-3 is borderline.")
else:
    print("❌ WEAK DETECTION: PNR < 2.0 is likely noise.")
print("="*70)