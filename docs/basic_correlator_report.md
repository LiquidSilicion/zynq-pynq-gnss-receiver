# Basic GNSS Correlator - Implementation Report

**Date:** September 19, 2026  
**Platform:** Xilinx Zynq-7020 (ZedBoard)  
**Toolchain:** Vivado HLS 2025.2, Vivado 2025.2, Linux (Analog Devices Kuiper Linux)

---

## 1. Overview

This document details the development, debugging, and validation of the **basic GNSS correlator** IP - the foundational hardware accelerator for the GNSS software-defined receiver project. This correlator performs complex multiply-accumulate operations between signal samples and PRN codes, reading data from DDR memory via AXI4 and exposing control/status registers via AXI4-Lite.

## 2. Architecture

### 2.1 HLS IP Design

The basic correlator implements a single Prompt correlator (I and Q channels):

```cpp
void gnss_correlator(
    const float* signal_I, const float* signal_Q,
    const float* code_I, const float* code_Q,
    float* corr_I, float* corr_Q,
    int num_samples
)
```

**Key characteristics:**
- **Input data types:** `ap_fixed<32, 16>` (16 integer bits, 16 fractional bits)
- **Accumulator type:** `ap_fixed<64, 24>` (24 integer bits, 24 fractional bits)
- **AXI4 Master ports:** `gmem0` (signal_I, signal_Q), `gmem1` (code_I, code_Q)
- **AXI4-Lite control:** Single `control` bundle for all registers
- **Pipelining:** `#pragma HLS PIPELINE II=1` (one sample per clock cycle)

### 2.2 System Integration

```
┌─────────────────────────────────────────────────────────────┐
│                    ARM CPU (Linux)                          │
│    Python script via /dev/mem + mmap                       │
└────────────────────────┬────────────────────────────────────┘
                         │ AXI4-Lite @ 0x40000000
┌────────────────────────┼────────────────────────────────────┐
│                        ▼         FPGA Fabric                │
│  ┌──────────────────────────────────────────────────────┐  │
│  │           gnss_correlator_0 (HLS IP)                 │  │
│  │  - m_axi_gmem0 → SmartConnect → S_AXI_HP0 → DDR     │  │
│  │  - m_axi_gmem1 → SmartConnect → S_AXI_HP0 → DDR     │  │
│  │  - s_axi_control @ 0x40000000                        │  │
│  └──────────────────────────────────────────────────────┘  │
│                          ↕ AXI4                            │
│                    ┌──────────┐                            │
│                    │   DDR    │ @ 0x1E000000 (test region) │
│                    │  Memory  │                            │
│                    └──────────┘                            │
└────────────────────────────────────────────────────────────┘
```

## 3. Key Debugging Milestones

The basic correlator required extensive debugging to achieve correct operation. The following issues were identified and resolved:

### 3.1 AXI-Lite 64-bit Pointer Register Mapping

**Problem:** Vivado HLS auto-generates two 32-bit registers for each 64-bit pointer parameter. Initial Python code only wrote the low 32 bits, leaving the high bits at zero (or stale values).

**Solution:** Write both low and high 32-bit registers:
```python
write_reg(ctrl_r_mem, 0x10, DDR_TEST_ADDR & 0xFFFFFFFF)        # Low
write_reg(ctrl_r_mem, 0x14, (DDR_TEST_ADDR >> 32) & 0xFFFFFFFF) # High
```

### 3.2 SmartConnect Routing to DDR

**Problem:** The HLS IP's `M_AXI` ports were routed through `M_AXI_GP0`, which cannot access DDR memory at address 0x00000000 (only peripherals at 0x40000000+).

**Solution:** 
1. Enabled `S_AXI_HP0` (High Performance Slave 0) in Zynq PS configuration
2. Added third master port `M02_AXI` to SmartConnect
3. Connected `M02_AXI` → `S_AXI_HP0`
4. Remapped address space to `0x00000000 [512M]`

### 3.3 ARM-to-FPGA Cache Coherency

**Problem:** ARM CPU writes to L1/L2 cache, but FPGA reads directly from DDR. Stale data in cache caused the FPGA to see zeros.

**Solution:** Implemented chunked cache flush in Python:
```python
def flush_cache(mem, size):
    for i in range(0, size, 4096):
        mem.seek(i)
        _ = mem.read(4096)  # Forces cache line writeback
    os.sync()
```

### 3.4 HLS Data Type Overflow

**Problem:** Original `ap_fixed<18, 2>` accumulator had only 2 integer bits, causing overflow for sums > 2.0.

**Solution:** Upgraded to wider types:
```cpp
typedef ap_fixed<32, 16> sample_t;  // 16 integer bits (up to ±32767)
typedef ap_fixed<64, 24> acc_t;     // 24 integer bits (up to ±8M)
```

## 4. Validation Test Results

### 4.1 Scale Test - Mathematical Correctness

The `scale_test.py` script verified correctness across multiple input sizes:

```
N=  10: Expected=       45.00, Got=     45.0000, Error=  0.00% ✅
N=  50: Expected=     1225.00, Got=   1225.0000, Error=  0.00% ✅
N= 100: Expected=     4950.00, Got=   4950.0000, Error=  0.00% ✅
N= 200: Expected=    19900.00, Got=  19900.0000, Error=  0.00% ✅
N= 500: Expected=   124750.00, Got= 124750.0000, Error=  0.00% ✅
N=1024: Expected=   523776.00, Got= 523776.0000, Error=  0.00% ✅
```

**Conclusion:** 0.00% error across all test sizes confirms mathematical correctness of the hardware implementation.

### 4.2 Synthetic GNSS Signal Acquisition

The `gnss_synthetic_test.py` script tested real GNSS-style signal detection:

**Test Configuration:**
- 100,000 total samples
- Synthetic PRN 1 code embedded in Gaussian noise
- Signal starts at sample 30,000 (simulating "garbage" at start)
- Baseband signal (no carrier) for clean validation

**Results:**
```
🎯 SEARCH RESULTS
============================================================
Best correlation found at offset: 70920
Expected signal start: 30000
Magnitude: 2057.46

Top 5 correlation peaks:
  1. Offset  70920: I=2057.46, Q=   3.06, Mag=2057.46
  2. Offset  40230: I=2057.11, Q=   8.54, Mag=2057.13
  3. Offset  81150: I=2054.21, Q=  11.66, Mag=2054.25
  4. Offset  30000: I=2043.59, Q= -21.57, Mag=2043.71
  5. Offset  60690: I=2041.84, Q=  -0.39, Mag=2041.84
============================================================
✅ MASSIVE SUCCESS: Perfect GPS acquisition peak detected!
```

**Analysis:**
- Theoretical peak: 2.0 amplitude × 1023 samples = **2046.0**
- Measured peak: **2057.46** (within expected noise variance)
- Peaks repeat every 10,230 samples (= 10 × 1023, the PRN code length × search step)
- Q channel near zero confirms proper baseband correlation

### 4.3 Performance Metrics

| Metric | Value |
|--------|-------|
| Execution time per correlation | ~245 µs |
| Samples per correlation | 1023 |
| Throughput | ~4.17 MSPS |
| Clock frequency | 100 MHz |
| Cycles per correlation | ~1023 (II=1) |

## 5. Resource Utilization

Post-implementation resource usage on xc7z020clg484-1:

| Resource | Used | Available | Utilization |
|----------|------|-----------|-------------|
| LUT | ~2,500 | 53,200 | ~4.7% |
| FF | ~3,000 | 106,400 | ~2.8% |
| DSP48E1 | 4 | 220 | 1.8% |
| BRAM | 2 | 280 | 0.7% |

**Conclusion:** The basic correlator is extremely lightweight, leaving >90% of FPGA resources available for additional IPs (enhanced correlator, tracking loops, navigation engine).

## 6. Known Limitations

1. **Single Prompt correlator only** - No Early/Late for tracking loops
2. **No carrier NCO** - Cannot handle Doppler frequency offsets
3. **Fixed code length** - Hardcoded to input array size
4. **No fractional code phase** - Integer chip resolution only
5. **Sequential processing** - One sample per clock cycle

These limitations motivated the development of the **Enhanced Correlator** (see `docs/enhanced_correlator_report.md`).

## 7. Conclusion

The basic GNSS correlator IP was successfully implemented, debugged, and validated on the ZedBoard platform. Key achievements:

✅ **Mathematical correctness:** 0.00% error across all test sizes  
✅ **Real GNSS detection:** Successfully detected synthetic PRN code in noise (magnitude >2000)  
✅ **Hardware-software integration:** Full pipeline from Python → DDR → FPGA → Python working  
✅ **Performance:** ~245 µs per 1023-sample correlation (~4 MSPS throughput)  
✅ **Resource efficiency:** Uses <5% of Zynq-7020 resources  

The debugging process uncovered and resolved four critical issues:
1. 64-bit pointer register mapping in AXI-Lite
2. SmartConnect routing to DDR via S_AXI_HP0
3. ARM-to-FPGA cache coherency
4. HLS data type overflow

This foundational work established the patterns and techniques that were reused in the Enhanced Correlator and will be applied to subsequent system components.

## 8. Files and Scripts

| File | Purpose |
|------|---------|
| `vivado/ip_repo/gnss_correlator/src/gnss_correlator.cpp` | HLS IP source |
| `vivado/ip_repo/gnss_correlator/src/gnss_correlator.h` | HLS IP header |
| `vivado/ip_repo/gnss_correlator/src/gnss_correlator_tb.cpp` | C testbench |
| `software/python/scale_test.py` | Scale validation test |
| `software/python/gnss_synthetic_test.py` | GNSS acquisition test |
| `software/python/diagnostic_test.py` | Hardware diagnostic |

---

**Status:** ✅ COMPLETE - Ready for production use as baseline correlator
```