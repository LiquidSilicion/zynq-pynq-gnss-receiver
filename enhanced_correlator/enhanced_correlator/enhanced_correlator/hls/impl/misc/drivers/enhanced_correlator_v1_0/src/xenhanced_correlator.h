// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XENHANCED_CORRELATOR_H
#define XENHANCED_CORRELATOR_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xenhanced_correlator_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Control_BaseAddress;
    u64 Control_r_BaseAddress;
} XEnhanced_correlator_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u64 Control_r_BaseAddress;
    u32 IsReady;
} XEnhanced_correlator;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XEnhanced_correlator_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XEnhanced_correlator_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XEnhanced_correlator_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XEnhanced_correlator_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
#ifdef SDT
int XEnhanced_correlator_Initialize(XEnhanced_correlator *InstancePtr, UINTPTR BaseAddress);
XEnhanced_correlator_Config* XEnhanced_correlator_LookupConfig(UINTPTR BaseAddress);
#else
int XEnhanced_correlator_Initialize(XEnhanced_correlator *InstancePtr, u16 DeviceId);
XEnhanced_correlator_Config* XEnhanced_correlator_LookupConfig(u16 DeviceId);
#endif
int XEnhanced_correlator_CfgInitialize(XEnhanced_correlator *InstancePtr, XEnhanced_correlator_Config *ConfigPtr);
#else
int XEnhanced_correlator_Initialize(XEnhanced_correlator *InstancePtr, const char* InstanceName);
int XEnhanced_correlator_Release(XEnhanced_correlator *InstancePtr);
#endif

void XEnhanced_correlator_Start(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_IsDone(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_IsIdle(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_IsReady(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_EnableAutoRestart(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_DisableAutoRestart(XEnhanced_correlator *InstancePtr);

u32 XEnhanced_correlator_Get_corr_E_I(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_Get_corr_E_I_vld(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_Get_corr_E_Q(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_Get_corr_E_Q_vld(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_Get_corr_P_I(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_Get_corr_P_I_vld(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_Get_corr_P_Q(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_Get_corr_P_Q_vld(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_Get_corr_L_I(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_Get_corr_L_I_vld(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_Get_corr_L_Q(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_Get_corr_L_Q_vld(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_Set_num_samples(XEnhanced_correlator *InstancePtr, u32 Data);
u32 XEnhanced_correlator_Get_num_samples(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_Set_carrier_freq(XEnhanced_correlator *InstancePtr, u32 Data);
u32 XEnhanced_correlator_Get_carrier_freq(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_Set_carrier_phase_init(XEnhanced_correlator *InstancePtr, u32 Data);
u32 XEnhanced_correlator_Get_carrier_phase_init(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_Set_code_phase_init(XEnhanced_correlator *InstancePtr, u32 Data);
u32 XEnhanced_correlator_Get_code_phase_init(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_Set_code_freq(XEnhanced_correlator *InstancePtr, u32 Data);
u32 XEnhanced_correlator_Get_code_freq(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_Set_sample_rate(XEnhanced_correlator *InstancePtr, u32 Data);
u32 XEnhanced_correlator_Get_sample_rate(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_Set_code_length(XEnhanced_correlator *InstancePtr, u32 Data);
u32 XEnhanced_correlator_Get_code_length(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_Set_correlator_spacing(XEnhanced_correlator *InstancePtr, u32 Data);
u32 XEnhanced_correlator_Get_correlator_spacing(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_Set_signal_I(XEnhanced_correlator *InstancePtr, u64 Data);
u64 XEnhanced_correlator_Get_signal_I(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_Set_signal_Q(XEnhanced_correlator *InstancePtr, u64 Data);
u64 XEnhanced_correlator_Get_signal_Q(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_Set_prn_code(XEnhanced_correlator *InstancePtr, u64 Data);
u64 XEnhanced_correlator_Get_prn_code(XEnhanced_correlator *InstancePtr);

void XEnhanced_correlator_InterruptGlobalEnable(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_InterruptGlobalDisable(XEnhanced_correlator *InstancePtr);
void XEnhanced_correlator_InterruptEnable(XEnhanced_correlator *InstancePtr, u32 Mask);
void XEnhanced_correlator_InterruptDisable(XEnhanced_correlator *InstancePtr, u32 Mask);
void XEnhanced_correlator_InterruptClear(XEnhanced_correlator *InstancePtr, u32 Mask);
u32 XEnhanced_correlator_InterruptGetEnabled(XEnhanced_correlator *InstancePtr);
u32 XEnhanced_correlator_InterruptGetStatus(XEnhanced_correlator *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
