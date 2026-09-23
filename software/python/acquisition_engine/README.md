# GNSS FPGA Acquisition Engine - Python Script Archive

## Overview
This directory contains all Python scripts used during the development and validation of the FPGA-based GNSS acquisition engine on the Zynq-7000 SoC.

## Directory Structure

### 01_synthetic_testing/
Scripts used during the initial synthetic data validation phase.
- `full_pipeline_test_v3.py` - End-to-end pipeline test with synthetic GPS data
- `test_code_phase_sweep.py` - Verify peak location tracks input code phase
- `simple_test.py` - Minimal test to avoid bus errors

### 02_diagnostics/
Scripts used to debug and verify individual components.
- `verify_carrier_nco.py` - Verify carrier wipeoff functionality
- `test_fft_simple.py` - Verify FFT with sine wave input
- `test_fft_bypass.py` - Verify FFT produces different outputs for different inputs
- `check_bit_reversal.py` - Calculate bit-reversal mapping for FFT output

### 03_real_data_analysis/
Scripts run on the laptop to analyze the real RF data file.
- `analyze_gps_file.py` - Determine file format (bit depth, I/Q structure)
- `scan_quality.py` - Scan file to find valid data regions
- `find_satellite.py` - Software-only search to find satellite parameters

### 04_real_data_validation/
Scripts run on the ZedBoard to validate the FPGA with real data.
- `final_real_test.py` - Initial real data test with Doppler search
- `validate_python.py` - Software ground truth validation
- `time_shift_test.py` - Verify peak tracks across time shifts
- `dense_doppler_test.py` - Dense Doppler search for ambiguity function
- `search_real_signal.py` - Multi-PRN multi-time search
- `verify_prn30.py` - Final targeted verification (PRN 30)

## Key Results

### Synthetic Validation
- Peak Power: 1,048,575.75 (theoretical maximum: 1024² - 1)
- Code Phase: 250 chips (exact match)
- Execution Time: 1.19 ms

### Real Data Validation
- Satellite: PRN 30
- Doppler: 0 Hz
- Code Phase: 371 chips
- Peak Power: ~32,128
- Hardware-Software Match: ✅ Perfect

## Hardware Configuration
- Target: Xilinx Zynq-7020 (xc7z020clg484-1)
- Clock: 100 MHz
- FFT Size: 1024 points
- Data Format: 32-bit IEEE 754 float
- Stream Width: 64 bits (32-bit I + 32-bit Q)

## Usage Notes
- Scripts in `03_real_data_analysis/` run on laptop (no hardware access needed)
- Scripts in `04_real_data_validation/` run on ZedBoard (require /dev/mem access)
- Real data file: GPS_L1_4FS_0IF_0dB_test1.bin (1.8 GB, 2-bit 4FS format)
- Sampling rate: 4.092 MHz