// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xgnss_correlator.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XGnss_correlator_CfgInitialize(XGnss_correlator *InstancePtr, XGnss_correlator_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->Control_r_BaseAddress = ConfigPtr->Control_r_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XGnss_correlator_Start(XGnss_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGnss_correlator_ReadReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_AP_CTRL) & 0x80;
    XGnss_correlator_WriteReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XGnss_correlator_IsDone(XGnss_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGnss_correlator_ReadReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XGnss_correlator_IsIdle(XGnss_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGnss_correlator_ReadReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XGnss_correlator_IsReady(XGnss_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGnss_correlator_ReadReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XGnss_correlator_EnableAutoRestart(XGnss_correlator *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGnss_correlator_WriteReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XGnss_correlator_DisableAutoRestart(XGnss_correlator *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGnss_correlator_WriteReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_AP_CTRL, 0);
}

u32 XGnss_correlator_Get_corr_I(XGnss_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGnss_correlator_ReadReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_CORR_I_DATA);
    return Data;
}

u32 XGnss_correlator_Get_corr_I_vld(XGnss_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGnss_correlator_ReadReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_CORR_I_CTRL);
    return Data & 0x1;
}

u32 XGnss_correlator_Get_corr_Q(XGnss_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGnss_correlator_ReadReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_CORR_Q_DATA);
    return Data;
}

u32 XGnss_correlator_Get_corr_Q_vld(XGnss_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGnss_correlator_ReadReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_CORR_Q_CTRL);
    return Data & 0x1;
}

void XGnss_correlator_Set_num_samples(XGnss_correlator *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGnss_correlator_WriteReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_NUM_SAMPLES_DATA, Data);
}

u32 XGnss_correlator_Get_num_samples(XGnss_correlator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGnss_correlator_ReadReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_NUM_SAMPLES_DATA);
    return Data;
}

void XGnss_correlator_Set_signal_I(XGnss_correlator *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGnss_correlator_WriteReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_SIGNAL_I_DATA, (u32)(Data));
    XGnss_correlator_WriteReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_SIGNAL_I_DATA + 4, (u32)(Data >> 32));
}

u64 XGnss_correlator_Get_signal_I(XGnss_correlator *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGnss_correlator_ReadReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_SIGNAL_I_DATA);
    Data += (u64)XGnss_correlator_ReadReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_SIGNAL_I_DATA + 4) << 32;
    return Data;
}

void XGnss_correlator_Set_signal_Q(XGnss_correlator *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGnss_correlator_WriteReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_SIGNAL_Q_DATA, (u32)(Data));
    XGnss_correlator_WriteReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_SIGNAL_Q_DATA + 4, (u32)(Data >> 32));
}

u64 XGnss_correlator_Get_signal_Q(XGnss_correlator *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGnss_correlator_ReadReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_SIGNAL_Q_DATA);
    Data += (u64)XGnss_correlator_ReadReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_SIGNAL_Q_DATA + 4) << 32;
    return Data;
}

void XGnss_correlator_Set_code_I(XGnss_correlator *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGnss_correlator_WriteReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_CODE_I_DATA, (u32)(Data));
    XGnss_correlator_WriteReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_CODE_I_DATA + 4, (u32)(Data >> 32));
}

u64 XGnss_correlator_Get_code_I(XGnss_correlator *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGnss_correlator_ReadReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_CODE_I_DATA);
    Data += (u64)XGnss_correlator_ReadReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_CODE_I_DATA + 4) << 32;
    return Data;
}

void XGnss_correlator_Set_code_Q(XGnss_correlator *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGnss_correlator_WriteReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_CODE_Q_DATA, (u32)(Data));
    XGnss_correlator_WriteReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_CODE_Q_DATA + 4, (u32)(Data >> 32));
}

u64 XGnss_correlator_Get_code_Q(XGnss_correlator *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGnss_correlator_ReadReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_CODE_Q_DATA);
    Data += (u64)XGnss_correlator_ReadReg(InstancePtr->Control_r_BaseAddress, XGNSS_CORRELATOR_CONTROL_R_ADDR_CODE_Q_DATA + 4) << 32;
    return Data;
}

void XGnss_correlator_InterruptGlobalEnable(XGnss_correlator *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGnss_correlator_WriteReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_GIE, 1);
}

void XGnss_correlator_InterruptGlobalDisable(XGnss_correlator *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGnss_correlator_WriteReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_GIE, 0);
}

void XGnss_correlator_InterruptEnable(XGnss_correlator *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XGnss_correlator_ReadReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_IER);
    XGnss_correlator_WriteReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_IER, Register | Mask);
}

void XGnss_correlator_InterruptDisable(XGnss_correlator *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XGnss_correlator_ReadReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_IER);
    XGnss_correlator_WriteReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_IER, Register & (~Mask));
}

void XGnss_correlator_InterruptClear(XGnss_correlator *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGnss_correlator_WriteReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_ISR, Mask);
}

u32 XGnss_correlator_InterruptGetEnabled(XGnss_correlator *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XGnss_correlator_ReadReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_IER);
}

u32 XGnss_correlator_InterruptGetStatus(XGnss_correlator *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XGnss_correlator_ReadReg(InstancePtr->Control_BaseAddress, XGNSS_CORRELATOR_CONTROL_ADDR_ISR);
}

