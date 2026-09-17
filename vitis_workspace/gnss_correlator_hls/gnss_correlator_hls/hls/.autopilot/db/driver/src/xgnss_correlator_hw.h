// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
// control
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read/COR)
//        bit 7  - auto_restart (Read/Write)
//        bit 9  - interrupt (Read)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0 - enable ap_done interrupt (Read/Write)
//        bit 1 - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0 - ap_done (Read/TOW)
//        bit 1 - ap_ready (Read/TOW)
//        others - reserved
// 0x10 : Data signal of corr_I
//        bit 31~0 - corr_I[31:0] (Read)
// 0x14 : Control signal of corr_I
//        bit 0  - corr_I_ap_vld (Read/COR)
//        others - reserved
// 0x20 : Data signal of corr_Q
//        bit 31~0 - corr_Q[31:0] (Read)
// 0x24 : Control signal of corr_Q
//        bit 0  - corr_Q_ap_vld (Read/COR)
//        others - reserved
// 0x30 : Data signal of num_samples
//        bit 31~0 - num_samples[31:0] (Read/Write)
// 0x34 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XGNSS_CORRELATOR_CONTROL_ADDR_AP_CTRL          0x00
#define XGNSS_CORRELATOR_CONTROL_ADDR_GIE              0x04
#define XGNSS_CORRELATOR_CONTROL_ADDR_IER              0x08
#define XGNSS_CORRELATOR_CONTROL_ADDR_ISR              0x0c
#define XGNSS_CORRELATOR_CONTROL_ADDR_CORR_I_DATA      0x10
#define XGNSS_CORRELATOR_CONTROL_BITS_CORR_I_DATA      32
#define XGNSS_CORRELATOR_CONTROL_ADDR_CORR_I_CTRL      0x14
#define XGNSS_CORRELATOR_CONTROL_ADDR_CORR_Q_DATA      0x20
#define XGNSS_CORRELATOR_CONTROL_BITS_CORR_Q_DATA      32
#define XGNSS_CORRELATOR_CONTROL_ADDR_CORR_Q_CTRL      0x24
#define XGNSS_CORRELATOR_CONTROL_ADDR_NUM_SAMPLES_DATA 0x30
#define XGNSS_CORRELATOR_CONTROL_BITS_NUM_SAMPLES_DATA 32

// control_r
// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of signal_I
//        bit 31~0 - signal_I[31:0] (Read/Write)
// 0x14 : Data signal of signal_I
//        bit 31~0 - signal_I[63:32] (Read/Write)
// 0x18 : reserved
// 0x1c : Data signal of signal_Q
//        bit 31~0 - signal_Q[31:0] (Read/Write)
// 0x20 : Data signal of signal_Q
//        bit 31~0 - signal_Q[63:32] (Read/Write)
// 0x24 : reserved
// 0x28 : Data signal of code_I
//        bit 31~0 - code_I[31:0] (Read/Write)
// 0x2c : Data signal of code_I
//        bit 31~0 - code_I[63:32] (Read/Write)
// 0x30 : reserved
// 0x34 : Data signal of code_Q
//        bit 31~0 - code_Q[31:0] (Read/Write)
// 0x38 : Data signal of code_Q
//        bit 31~0 - code_Q[63:32] (Read/Write)
// 0x3c : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XGNSS_CORRELATOR_CONTROL_R_ADDR_SIGNAL_I_DATA 0x10
#define XGNSS_CORRELATOR_CONTROL_R_BITS_SIGNAL_I_DATA 64
#define XGNSS_CORRELATOR_CONTROL_R_ADDR_SIGNAL_Q_DATA 0x1c
#define XGNSS_CORRELATOR_CONTROL_R_BITS_SIGNAL_Q_DATA 64
#define XGNSS_CORRELATOR_CONTROL_R_ADDR_CODE_I_DATA   0x28
#define XGNSS_CORRELATOR_CONTROL_R_BITS_CODE_I_DATA   64
#define XGNSS_CORRELATOR_CONTROL_R_ADDR_CODE_Q_DATA   0x34
#define XGNSS_CORRELATOR_CONTROL_R_BITS_CODE_Q_DATA   64

