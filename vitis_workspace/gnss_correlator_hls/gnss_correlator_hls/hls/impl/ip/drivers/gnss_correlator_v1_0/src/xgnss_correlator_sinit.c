// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xgnss_correlator.h"

extern XGnss_correlator_Config XGnss_correlator_ConfigTable[];

#ifdef SDT
XGnss_correlator_Config *XGnss_correlator_LookupConfig(UINTPTR BaseAddress) {
	XGnss_correlator_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XGnss_correlator_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XGnss_correlator_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XGnss_correlator_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XGnss_correlator_Initialize(XGnss_correlator *InstancePtr, UINTPTR BaseAddress) {
	XGnss_correlator_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XGnss_correlator_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XGnss_correlator_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XGnss_correlator_Config *XGnss_correlator_LookupConfig(u16 DeviceId) {
	XGnss_correlator_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XGNSS_CORRELATOR_NUM_INSTANCES; Index++) {
		if (XGnss_correlator_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XGnss_correlator_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XGnss_correlator_Initialize(XGnss_correlator *InstancePtr, u16 DeviceId) {
	XGnss_correlator_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XGnss_correlator_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XGnss_correlator_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

