import numpy as np
import matplotlib.pyplot as plt
import os

def analyze_gps_file(filepath):
    if not os.path.exists(filepath):
        print(f"❌ File not found: {filepath}")
        return

    file_size = os.path.getsize(filepath)
    print(f"📂 File: {filepath}")
    print(f"📏 Total Size: {file_size / (1024**2):.2f} MB")
    
    read_size = min(100000, file_size)
    with open(filepath, 'rb') as f:
        raw_bytes = f.read(read_size)
    
    print(f"🔍 Analyzing first {read_size} bytes...\n")

    # 1. Test 8-bit Signed Integer (int8)
    data_i8 = np.frombuffer(raw_bytes, dtype=np.int8)
    print("--- 1. 8-bit (int8) Interpretation ---")
    print(f"   Unique values: {len(np.unique(data_i8))}")
    print(f"   Min: {np.min(data_i8):4d}, Max: {np.max(data_i8):4d}, Mean: {np.mean(data_i8):.2f}")

    # 2. Test 16-bit Signed Integer (int16)
    if len(raw_bytes) % 2 == 0:
        data_i16 = np.frombuffer(raw_bytes, dtype=np.int16)
        print("\n--- 2. 16-bit (int16) Interpretation ---")
        print(f"   Unique values: {len(np.unique(data_i16))}")
        print(f"   Min: {np.min(data_i16):6d}, Max: {np.max(data_i16):6d}, Mean: {np.mean(data_i16):.2f}")

    # 3. Test 2-bit Packed (4FS - 4-Level F-Sign)
    bytes_arr = np.frombuffer(raw_bytes, dtype=np.uint8)
    s0 = (bytes_arr >> 6) & 0x03
    s1 = (bytes_arr >> 4) & 0x03
    s2 = (bytes_arr >> 2) & 0x03
    s3 = (bytes_arr >> 0) & 0x03
    
    samples_2bit = np.concatenate([s0, s1, s2, s3])
    mapped_2bit = np.where(samples_2bit == 0, -3,
                  np.where(samples_2bit == 1, -1,
                  np.where(samples_2bit == 2,  1, 3)))
    
    unique_vals, counts = np.unique(mapped_2bit, return_counts=True)
    print("\n--- 3. 2-bit Packed (4FS) Interpretation ---")
    print(f"   Unique values and counts: {dict(zip(unique_vals, counts))}")
    print(f"   Min: {np.min(mapped_2bit)}, Max: {np.max(mapped_2bit)}")

    # 4. Plotting Histograms
    plt.figure(figsize=(15, 5))
    
    plt.subplot(1, 3, 1)
    plt.hist(data_i8, bins=60, density=True, alpha=0.7, color='blue')
    plt.title("8-bit (int8) Histogram")
    plt.xlabel("Amplitude")
    
    plt.subplot(1, 3, 2)
    if len(raw_bytes) % 2 == 0:
        plt.hist(data_i16, bins=60, density=True, alpha=0.7, color='green')
    plt.title("16-bit (int16) Histogram")
    plt.xlabel("Amplitude")
    
    plt.subplot(1, 3, 3)
    plt.hist(mapped_2bit, bins=[-4, -2, 0, 2, 4], density=True, alpha=0.7, color='red', rwidth=0.8)
    plt.title("2-bit Packed (Mapped to -3, -1, 1, 3)")
    plt.xlabel("Amplitude")
    plt.xticks([-3, -1, 1, 3])
    
    plt.tight_layout()
    plt.show()

    # 5. Heuristic Conclusion
    print("\n" + "="*60)
    print("💡 CONCLUSION:")
    if len(unique_vals) == 4 and np.array_equal(unique_vals, [-3, -1, 1, 3]):
        print("✅ This is almost certainly a 2-bit (4FS) packed file.")
        print("   Since it is '0IF' (Zero IF), the samples are likely interleaved I and Q.")
        print("   Format: 1 byte = 4 samples (e.g., I0, Q0, I1, Q1 or similar packing).")
    elif len(np.unique(data_i8)) > 50:
        print("✅ This looks like a standard 8-bit (int8) file.")
    elif len(raw_bytes) % 2 == 0 and len(np.unique(data_i16)) > 50:
        print("✅ This looks like a standard 16-bit (int16) file.")
    else:
        print("⚠️  Format is ambiguous. Please share the histogram output.")
    print("="*60)

if __name__ == "__main__":
    FILE_PATH = r"/home/johan2/Documents/event_horizon_data/GPS_L1_4FS_0IF_0dB_test1.bin"
    analyze_gps_file(FILE_PATH)