   # Software Baseline Profiling
   
   - **Host CPU:** Intel Core (Laptop)
   - **Signal:** 29.8 seconds of GPS L1 C/A (Simulated via gps-sdr-sim)
   - **Software:** GNSS-SDR v0.0.21 (Vanilla, no hardware acceleration)
   - **Result:** Successfully acquired and tracked 4 satellites (PRN 08, 10, 15, 16).
   - **Execution Time:** 2.82 seconds (10.5x real-time on host PC).
   
   **Conclusion:** While functional on a high-end PC, this software-only approach will bottleneck on embedded ARM cores (like the Zynq-7020/7035), necessitating FPGA hardware acceleration for the Acquisition and Tracking blocks.