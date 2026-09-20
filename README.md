# 🛰️ Zynq PYNQ GNSS Receiver

A hardware-accelerated Software-Defined GNSS Receiver built on the **PYNQ** framework for Zynq SoCs. 

This project demonstrates how to offload computationally intensive GNSS signal processing tasks (such as Parallel Code Phase Search acquisition and multicorrelator tracking) from an embedded ARM CPU to the FPGA fabric, achieving significant reductions in Time-To-First-Fix (TTFF) and CPU load.

## 🎯 Overview
Traditional software-defined GNSS receivers running on embedded ARM processors often struggle with real-time processing of wideband signals due to CPU bottlenecks. This project bridges the gap by:
1. Using **Analog Devices Kuiper Linux** and `pyadi-iio` for seamless RF front-end control (AD9361).
2. Running a baseline **GNSS-SDR** instance on the ARM Processing System (PS) to establish performance metrics.
3. Implementing custom hardware accelerators (via Verilog or Vitis HLS) in the Programmable Logic (PL).
4. Exposing the hardware accelerators to user-space Python/C++ via Linux **UIO (Userspace I/O)** drivers for real-time, low-latency control.

*Note: While currently targeted at the ADRV9361-Z7035 (Zynq-7035 + AD9361), the architecture is designed to be portable to other Zynq-7000 and Zynq UltraScale+ MPSoC platforms.*

## 🏗️ System Architecture
- **Processing System (PS):** ARM Cortex-A9 running Linux. Handles high-level control, navigation message decoding, and PVT (Position, Velocity, Time) computation.
- **Programmable Logic (PL):** FPGA fabric hosting the custom GNSS Correlator IP.
- **RF Front-End:** AD9361 Agile Transceiver, interfaced via the AXI AD9361 IP core, providing direct I/Q sample streaming to the PL.
- **Interconnect:** AXI4-Stream for high-throughput I/Q data; AXI4-Lite for register-level configuration of the accelerator.

## 📂 Repository Structure
- `vivado/`: Vivado project scripts, constraints, and custom IP repositories.
- `linux-build/`: Device tree overlays and notes for configuring the Linux environment.
- `software/`: Host-side Python/C++ control scripts and GNSS-SDR configuration files.
- `notebooks/`: Jupyter Notebooks for step-by-step testing, profiling, and demonstration.
- `docs/`: Architecture diagrams, profiling results, and technical documentation.

---

### 📂 Repository Structure

Create this exact folder structure in your new repository. It shows maturity and foresight.

```text
zynq-pynq-gnss-receiver/
├── README.md                          # Project overview
├── docs/                              # Documentation
│   ├── architecture.md
│   └── user_guide.md
│
├── hardware/                          # FPGA/Hardware files
│   ├── vivado/                        # Vivado projects
│   │   ├── zynq_gnss_correlator_system/
│   │   └── enhanced_system/
│   └── ip_repo/                       # Custom HLS IPs
│       ├── gnss_correlator/           # Original correlator
│       └── gnss_enhanced_correlator/  # Enhanced correlator (E/P/L)
│
├── software/                          # Software code
│   ├── python/                        # Python scripts
│   │   ├── acquisition_engine.py      # 2D search controller
│   │   ├── diagnostic_test.py         # Hardware diagnostics
│   │   ├── gnss_acquisition_test.py   # Acquisition tests
│   │   └── utils/                     # Helper functions
│   │       ├── prn_generator.py       # GPS PRN code generator
│   │       └── hardware_interface.py  # AXI-Lite interface
│   └── cpp/                           # C/C++ code (future)
│       ├── tracking_loop/
│       └── navigation_decoder/
│
├── test_data/                         # Test files
│   ├── synthetic/                     # Generated test signals
│   └── real/                          # Real GNSS captures
│       └── .gitignore                 # Don't commit large files
│
└── scripts/                           # Build/deployment scripts
    ├── build_bitstream.sh
    └── deploy_to_zedboard.sh
```
---
## 🛠️ Prerequisites
### Hardware
- Zynq-7000 or Zynq UltraScale+ Development Board (Tested on ADRV9361-Z7035)
- MicroSD Card (16GB+)
- GNSS Active Antenna (e.g., Taoglas or equivalent, tuned to 1575.42 MHz)

### Software
- Host PC: Ubuntu 20.04/22.04 with Vivado 202x.x and Vitis HLS installed.
- Target Board: Analog Devices [Kuiper Linux](https://wiki.analog.com/resources/tools-software/linux-software/kuiper-linux) image.
- Python Libraries: `pyadi-iio`, `matplotlib`, `numpy`.

## 🚀 Quick Start Guide

### Phase 1: RF Sanity Check
1. Flash the ADI Kuiper Linux image to the SD card and boot the board.
2. Connect to the board via SSH.
3. Run the provided Python script to tune the AD9361 to GPS L1 and capture a buffer:
   ```bash
   cd software/pyadi_control/
   python3 rf_capture.py
   ```
4. Open `notebooks/01_rf_sanity_check.ipynb` to visualize the Power Spectral Density (PSD) and confirm GNSS signal presence.

### Phase 2: Software Baseline
1. Cross-compile `gnss-sdr` for the ARM architecture.
2. Run the receiver using the provided configuration in `software/gnss-sdr-config/`.
3. Document the baseline CPU utilization and TTFF in `docs/profiling_results.md`.

### Phase 3: Hardware Acceleration (In Progress)
*See `vivado/ip_repo/` for the custom AXI-wrapped correlator design. Integration with the PYNQ overlay and UIO driver is currently underway.*

## 📈 Future Roadmap
- [x] RF front-end validation and I/Q capture.
- [x] Software baseline profiling.
- [ ] Port custom Verilog/HLS GNSS Correlator to AXI4-Stream interface.
- [ ] Implement Linux UIO driver binding for zero-copy data transfer.
- [ ] **GNSS-R Extension:** Expand the correlator architecture to support 2D Delay-Doppler Map (DDM) generation for reflectometry applications.

## 📄 License & Acknowledgments
This project is licensed under the MIT License. 
Special thanks to the [GNSS-SDR](https://gnss-sdr.org/) and [Analog Devices](https://github.com/analogdevicesinc/hdl) open-source communities for their foundational tools and HDL references.
```
