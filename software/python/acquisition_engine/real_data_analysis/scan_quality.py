#!/usr/bin/env python3
"""
Quick diagnostic to scan different parts of the file and find valid data
"""
import numpy as np
import os

def scan_file(filename, sample_rate=4.092e6):
    print("="*70)
    print("🔍 Scanning file for valid data regions")
    print("="*70)
    
    file_size = os.path.getsize(filename)
    total_seconds = file_size / (sample_rate * 0.5)
    print(f"📂 File: {filename}")
    print(f"📏 Total duration: {total_seconds:.2f} seconds\n")
    
    offsets = [0, 1, 2, 5, 10, 20, 50, 100, 200, 500]
    
    print(f"{'Offset (s)':<12} {'I std':<10} {'Q std':<10} {'Status'}")
    print("-" * 50)
    
    for offset_sec in offsets:
        if offset_sec >= total_seconds:
            break
            
        byte_offset = int(offset_sec * sample_rate * 0.5)
        
        with open(filename, 'rb') as f:
            f.seek(byte_offset)
            raw_bytes = f.read(10000)
        
        if len(raw_bytes) < 10000:
            print(f"{offset_sec:<12} {'EOF':<10} {'EOF':<10} End of file")
            break
        
        data = np.frombuffer(raw_bytes, dtype=np.uint8)
        
        s0 = (data >> 0) & 0x03
        s1 = (data >> 2) & 0x03
        s2 = (data >> 4) & 0x03
        s3 = (data >> 6) & 0x03
        
        samples = np.concatenate([s0, s1, s2, s3])
        i_samples = samples[0::2]
        q_samples = samples[1::2]
        
        def map_2bit(x):
            return np.where(x == 0, -3.0,
                   np.where(x == 1, -1.0,
                   np.where(x == 2,  1.0, 3.0)))
        
        i_float = map_2bit(i_samples) / 3.0
        q_float = map_2bit(q_samples) / 3.0
        
        i_std = np.std(i_float)
        q_std = np.std(q_float)
        
        if i_std < 0.1:
            status = "❌ Garbage/Low signal"
        elif i_std < 0.3:
            status = "⚠️  Weak signal"
        else:
            status = "✅ Good signal"
        
        print(f"{offset_sec:<12.1f} {i_std:<10.4f} {q_std:<10.4f} {status}")

if __name__ == "__main__":
    filename = "/home/johan2/Documents/event_horizon_data/GPS_L1_4FS_0IF_0dB_test1.bin"
    if not os.path.exists(filename):
        print(f"❌ File not found: {filename}")
    else:
        scan_file(filename)