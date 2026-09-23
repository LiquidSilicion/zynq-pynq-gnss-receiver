#!/usr/bin/env python3
"""
Check if FFT output is bit-reversed
"""
import math

def bit_reverse(n, num_bits):
    """Reverse the bits of n"""
    result = 0
    for i in range(num_bits):
        result = (result << 1) | (n & 1)
        n >>= 1
    return result

# For 1024-point FFT (10 bits)
N = 1024
num_bits = 10

print("Bit-Reversal Mapping (first 20 bins):")
print(f"{'Natural':<10} {'Bit-Reversed':<15}")
print("-" * 25)
for i in range(20):
    reversed_i = bit_reverse(i, num_bits)
    print(f"{i:<10} {reversed_i:<15}")

print(f"\nIf peak is at natural bin 100, it would appear at bit-reversed bin {bit_reverse(100, num_bits)}")
print(f"If peak is at natural bin 250, it would appear at bit-reversed bin {bit_reverse(250, num_bits)}")