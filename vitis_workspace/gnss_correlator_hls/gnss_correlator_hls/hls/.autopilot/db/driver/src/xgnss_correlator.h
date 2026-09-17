// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XGNSS_CORRELATOR_H
#define XGNSS_CORRELATOR_H

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
#include "xgnss_correlator_hw.h"

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
} XGnss_correlator_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u64 Control_r_BaseAddress;
    u32 IsReady;
} XGnss_correlator;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XGnss_correlator_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XGnss_correlator_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XGnss_correlator_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XGnss_correlator_ReadReg(BaseAddress, RegOffset) \
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
int XGnss_correlator_Initialize(XGnss_correlator *InstancePtr, UINTPTR BaseAddress);
XGnss_correlator_Config* XGnss_correlator_LookupConfig(UINTPTR BaseAddress);
#else
int XGnss_correlator_Initialize(XGnss_correlator *InstancePtr, u16 DeviceId);
XGnss_correlator_Config* XGnss_correlator_LookupConfig(u16 DeviceId);
#endif
int XGnss_correlator_CfgInitialize(XGnss_correlator *InstancePtr, XGnss_correlator_Config *ConfigPtr);
#else
int XGnss_correlator_Initialize(XGnss_correlator *InstancePtr, const char* InstanceName);
int XGnss_correlator_Release(XGnss_correlator *InstancePtr);
#endif

void XGnss_correlator_Start(XGnss_correlator *InstancePtr);
u32 XGnss_correlator_IsDone(XGnss_correlator *InstancePtr);
u32 XGnss_correlator_IsIdle(XGnss_correlator *InstancePtr);
u32 XGnss_correlator_IsReady(XGnss_correlator *InstancePtr);
void XGnss_correlator_EnableAutoRestart(XGnss_correlator *InstancePtr);
void XGnss_correlator_DisableAutoRestart(XGnss_correlator *InstancePtr);

u32 XGnss_correlator_Get_corr_I(XGnss_correlator *InstancePtr);
u32 XGnss_correlator_Get_corr_I_vld(XGnss_correlator *InstancePtr);
u32 XGnss_correlator_Get_corr_Q(XGnss_correlator *InstancePtr);
u32 XGnss_correlator_Get_corr_Q_vld(XGnss_correlator *InstancePtr);
void XGnss_correlator_Set_num_samples(XGnss_correlator *InstancePtr, u32 Data);
u32 XGnss_correlator_Get_num_samples(XGnss_correlator *InstancePtr);
void XGnss_correlator_Set_signal_I(XGnss_correlator *InstancePtr, u64 Data);
u64 XGnss_correlator_Get_signal_I(XGnss_correlator *InstancePtr);
void XGnss_correlator_Set_signal_Q(XGnss_correlator *InstancePtr, u64 Data);
u64 XGnss_correlator_Get_signal_Q(XGnss_correlator *InstancePtr);
void XGnss_correlator_Set_code_I(XGnss_correlator *InstancePtr, u64 Data);
u64 XGnss_correlator_Get_code_I(XGnss_correlator *InstancePtr);
void XGnss_correlator_Set_code_Q(XGnss_correlator *InstancePtr, u64 Data);
u64 XGnss_correlator_Get_code_Q(XGnss_correlator *InstancePtr);

void XGnss_correlator_InterruptGlobalEnable(XGnss_correlator *InstancePtr);
void XGnss_correlator_InterruptGlobalDisable(XGnss_correlator *InstancePtr);
void XGnss_correlator_InterruptEnable(XGnss_correlator *InstancePtr, u32 Mask);
void XGnss_correlator_InterruptDisable(XGnss_correlator *InstancePtr, u32 Mask);
void XGnss_correlator_InterruptClear(XGnss_correlator *InstancePtr, u32 Mask);
u32 XGnss_correlator_InterruptGetEnabled(XGnss_correlator *InstancePtr);
u32 XGnss_correlator_InterruptGetStatus(XGnss_correlator *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
