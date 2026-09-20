// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xenhanced_correlator.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XEnhanced_correlator_CfgInitialize(XEnhanced_correlator *InstancePtr, XEnhanced_correlator_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->Control_r_BaseAddress = ConfigPtr->Control_r_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XEnhanced_correlator_Start(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_AP_CTRL) & 0x80;
    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XEnhanced_correlator_IsDone(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XEnhanced_correlator_IsIdle(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XEnhanced_correlator_IsReady(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XEnhanced_correlator_EnableAutoRestart(XEnhanced_correlator *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XEnhanced_correlator_DisableAutoRestart(XEnhanced_correlator *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_AP_CTRL, 0);
}

u32 XEnhanced_correlator_Get_corr_E_I(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CORR_E_I_DATA);
    return Data;
}

u32 XEnhanced_correlator_Get_corr_E_I_vld(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CORR_E_I_CTRL);
    return Data & 0x1;
}

u32 XEnhanced_correlator_Get_corr_E_Q(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CORR_E_Q_DATA);
    return Data;
}

u32 XEnhanced_correlator_Get_corr_E_Q_vld(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CORR_E_Q_CTRL);
    return Data & 0x1;
}

u32 XEnhanced_correlator_Get_corr_P_I(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CORR_P_I_DATA);
    return Data;
}

u32 XEnhanced_correlator_Get_corr_P_I_vld(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CORR_P_I_CTRL);
    return Data & 0x1;
}

u32 XEnhanced_correlator_Get_corr_P_Q(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CORR_P_Q_DATA);
    return Data;
}

u32 XEnhanced_correlator_Get_corr_P_Q_vld(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CORR_P_Q_CTRL);
    return Data & 0x1;
}

u32 XEnhanced_correlator_Get_corr_L_I(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CORR_L_I_DATA);
    return Data;
}

u32 XEnhanced_correlator_Get_corr_L_I_vld(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CORR_L_I_CTRL);
    return Data & 0x1;
}

u32 XEnhanced_correlator_Get_corr_L_Q(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CORR_L_Q_DATA);
    return Data;
}

u32 XEnhanced_correlator_Get_corr_L_Q_vld(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CORR_L_Q_CTRL);
    return Data & 0x1;
}

void XEnhanced_correlator_Set_num_samples(XEnhanced_correlator *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_NUM_SAMPLES_DATA, Data);
}

u32 XEnhanced_correlator_Get_num_samples(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_NUM_SAMPLES_DATA);
    return Data;
}

void XEnhanced_correlator_Set_carrier_freq(XEnhanced_correlator *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CARRIER_FREQ_DATA, Data);
}

u32 XEnhanced_correlator_Get_carrier_freq(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CARRIER_FREQ_DATA);
    return Data;
}

void XEnhanced_correlator_Set_carrier_phase_init(XEnhanced_correlator *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CARRIER_PHASE_INIT_DATA, Data);
}

u32 XEnhanced_correlator_Get_carrier_phase_init(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CARRIER_PHASE_INIT_DATA);
    return Data;
}

void XEnhanced_correlator_Set_code_phase_init(XEnhanced_correlator *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CODE_PHASE_INIT_DATA, Data);
}

u32 XEnhanced_correlator_Get_code_phase_init(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CODE_PHASE_INIT_DATA);
    return Data;
}

void XEnhanced_correlator_Set_code_freq(XEnhanced_correlator *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CODE_FREQ_DATA, Data);
}

u32 XEnhanced_correlator_Get_code_freq(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CODE_FREQ_DATA);
    return Data;
}

void XEnhanced_correlator_Set_sample_rate(XEnhanced_correlator *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_SAMPLE_RATE_DATA, Data);
}

u32 XEnhanced_correlator_Get_sample_rate(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_SAMPLE_RATE_DATA);
    return Data;
}

void XEnhanced_correlator_Set_code_length(XEnhanced_correlator *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CODE_LENGTH_DATA, Data);
}

u32 XEnhanced_correlator_Get_code_length(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CODE_LENGTH_DATA);
    return Data;
}

void XEnhanced_correlator_Set_correlator_spacing(XEnhanced_correlator *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CORRELATOR_SPACING_DATA, Data);
}

u32 XEnhanced_correlator_Get_correlator_spacing(XEnhanced_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_CORRELATOR_SPACING_DATA);
    return Data;
}

void XEnhanced_correlator_Set_signal_I(XEnhanced_correlator *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_r_BaseAddress, XENHANCED_CORRELATOR_CONTROL_R_ADDR_SIGNAL_I_DATA, (u32)(Data));
    XEnhanced_correlator_WriteReg(InstancePtr->Control_r_BaseAddress, XENHANCED_CORRELATOR_CONTROL_R_ADDR_SIGNAL_I_DATA + 4, (u32)(Data >> 32));
}

u64 XEnhanced_correlator_Get_signal_I(XEnhanced_correlator *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_r_BaseAddress, XENHANCED_CORRELATOR_CONTROL_R_ADDR_SIGNAL_I_DATA);
    Data += (u64)XEnhanced_correlator_ReadReg(InstancePtr->Control_r_BaseAddress, XENHANCED_CORRELATOR_CONTROL_R_ADDR_SIGNAL_I_DATA + 4) << 32;
    return Data;
}

void XEnhanced_correlator_Set_signal_Q(XEnhanced_correlator *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_r_BaseAddress, XENHANCED_CORRELATOR_CONTROL_R_ADDR_SIGNAL_Q_DATA, (u32)(Data));
    XEnhanced_correlator_WriteReg(InstancePtr->Control_r_BaseAddress, XENHANCED_CORRELATOR_CONTROL_R_ADDR_SIGNAL_Q_DATA + 4, (u32)(Data >> 32));
}

u64 XEnhanced_correlator_Get_signal_Q(XEnhanced_correlator *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_r_BaseAddress, XENHANCED_CORRELATOR_CONTROL_R_ADDR_SIGNAL_Q_DATA);
    Data += (u64)XEnhanced_correlator_ReadReg(InstancePtr->Control_r_BaseAddress, XENHANCED_CORRELATOR_CONTROL_R_ADDR_SIGNAL_Q_DATA + 4) << 32;
    return Data;
}

void XEnhanced_correlator_Set_prn_code(XEnhanced_correlator *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_r_BaseAddress, XENHANCED_CORRELATOR_CONTROL_R_ADDR_PRN_CODE_DATA, (u32)(Data));
    XEnhanced_correlator_WriteReg(InstancePtr->Control_r_BaseAddress, XENHANCED_CORRELATOR_CONTROL_R_ADDR_PRN_CODE_DATA + 4, (u32)(Data >> 32));
}

u64 XEnhanced_correlator_Get_prn_code(XEnhanced_correlator *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XEnhanced_correlator_ReadReg(InstancePtr->Control_r_BaseAddress, XENHANCED_CORRELATOR_CONTROL_R_ADDR_PRN_CODE_DATA);
    Data += (u64)XEnhanced_correlator_ReadReg(InstancePtr->Control_r_BaseAddress, XENHANCED_CORRELATOR_CONTROL_R_ADDR_PRN_CODE_DATA + 4) << 32;
    return Data;
}

void XEnhanced_correlator_InterruptGlobalEnable(XEnhanced_correlator *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_GIE, 1);
}

void XEnhanced_correlator_InterruptGlobalDisable(XEnhanced_correlator *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_GIE, 0);
}

void XEnhanced_correlator_InterruptEnable(XEnhanced_correlator *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_IER);
    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_IER, Register | Mask);
}

void XEnhanced_correlator_InterruptDisable(XEnhanced_correlator *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_IER);
    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_IER, Register & (~Mask));
}

void XEnhanced_correlator_InterruptClear(XEnhanced_correlator *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XEnhanced_correlator_WriteReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_ISR, Mask);
}

u32 XEnhanced_correlator_InterruptGetEnabled(XEnhanced_correlator *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_IER);
}

u32 XEnhanced_correlator_InterruptGetStatus(XEnhanced_correlator *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XEnhanced_correlator_ReadReg(InstancePtr->Control_BaseAddress, XENHANCED_CORRELATOR_CONTROL_ADDR_ISR);
}

