// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
// DO NOT MODIFY THIS FILE.

// MODULE VLNV: amd.com:blockdesign:bd_0:1.0

`timescale 1ps / 1ps

`include "vivado_interfaces.svh"

module bd_0_sv (
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0" *)
  (* X_INTERFACE_MODE = "master m_axi_gmem0" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_gmem0, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000.0, ID_WIDTH 1, ADDR_WIDTH 64, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_ONLY, HAS_BURST 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN bd_0_ap_clk_0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
  vivado_aximm_v1_0.master m_axi_gmem0,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1" *)
  (* X_INTERFACE_MODE = "master m_axi_gmem1" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_gmem1, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000.0, ID_WIDTH 1, ADDR_WIDTH 64, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_ONLY, HAS_BURST 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN bd_0_ap_clk_0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
  vivado_aximm_v1_0.master m_axi_gmem1,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control" *)
  (* X_INTERFACE_MODE = "slave s_axi_control" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_control, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000.0, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN bd_0_ap_clk_0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
  vivado_axi4_lite_v1_0.slave s_axi_control,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_r" *)
  (* X_INTERFACE_MODE = "slave s_axi_control_r" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_control_r, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000.0, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN bd_0_ap_clk_0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
  vivado_axi4_lite_v1_0.slave s_axi_control_r,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire ap_clk,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire ap_rst_n,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire interrupt
);

  // interface wire assignments
  assign m_axi_gmem0.ARUSER = 0;
  assign m_axi_gmem0.AWUSER = 0;
  assign m_axi_gmem0.WUSER = 0;
  assign m_axi_gmem1.ARUSER = 0;
  assign m_axi_gmem1.AWUSER = 0;
  assign m_axi_gmem1.WUSER = 0;

  bd_0 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .interrupt(interrupt),
    .m_axi_gmem0_araddr(m_axi_gmem0.ARADDR),
    .m_axi_gmem0_arburst(m_axi_gmem0.ARBURST),
    .m_axi_gmem0_arcache(m_axi_gmem0.ARCACHE),
    .m_axi_gmem0_arid(m_axi_gmem0.ARID),
    .m_axi_gmem0_arlen(m_axi_gmem0.ARLEN),
    .m_axi_gmem0_arlock(m_axi_gmem0.ARLOCK),
    .m_axi_gmem0_arprot(m_axi_gmem0.ARPROT),
    .m_axi_gmem0_arqos(m_axi_gmem0.ARQOS),
    .m_axi_gmem0_arready(m_axi_gmem0.ARREADY),
    .m_axi_gmem0_arregion(m_axi_gmem0.ARREGION),
    .m_axi_gmem0_arsize(m_axi_gmem0.ARSIZE),
    .m_axi_gmem0_arvalid(m_axi_gmem0.ARVALID),
    .m_axi_gmem0_awaddr(m_axi_gmem0.AWADDR),
    .m_axi_gmem0_awburst(m_axi_gmem0.AWBURST),
    .m_axi_gmem0_awcache(m_axi_gmem0.AWCACHE),
    .m_axi_gmem0_awid(m_axi_gmem0.AWID),
    .m_axi_gmem0_awlen(m_axi_gmem0.AWLEN),
    .m_axi_gmem0_awlock(m_axi_gmem0.AWLOCK),
    .m_axi_gmem0_awprot(m_axi_gmem0.AWPROT),
    .m_axi_gmem0_awqos(m_axi_gmem0.AWQOS),
    .m_axi_gmem0_awready(m_axi_gmem0.AWREADY),
    .m_axi_gmem0_awregion(m_axi_gmem0.AWREGION),
    .m_axi_gmem0_awsize(m_axi_gmem0.AWSIZE),
    .m_axi_gmem0_awvalid(m_axi_gmem0.AWVALID),
    .m_axi_gmem0_bid(m_axi_gmem0.BID),
    .m_axi_gmem0_bready(m_axi_gmem0.BREADY),
    .m_axi_gmem0_bresp(m_axi_gmem0.BRESP),
    .m_axi_gmem0_bvalid(m_axi_gmem0.BVALID),
    .m_axi_gmem0_rdata(m_axi_gmem0.RDATA),
    .m_axi_gmem0_rid(m_axi_gmem0.RID),
    .m_axi_gmem0_rlast(m_axi_gmem0.RLAST),
    .m_axi_gmem0_rready(m_axi_gmem0.RREADY),
    .m_axi_gmem0_rresp(m_axi_gmem0.RRESP),
    .m_axi_gmem0_rvalid(m_axi_gmem0.RVALID),
    .m_axi_gmem0_wdata(m_axi_gmem0.WDATA),
    .m_axi_gmem0_wid(m_axi_gmem0.WID),
    .m_axi_gmem0_wlast(m_axi_gmem0.WLAST),
    .m_axi_gmem0_wready(m_axi_gmem0.WREADY),
    .m_axi_gmem0_wstrb(m_axi_gmem0.WSTRB),
    .m_axi_gmem0_wvalid(m_axi_gmem0.WVALID),
    .m_axi_gmem1_araddr(m_axi_gmem1.ARADDR),
    .m_axi_gmem1_arburst(m_axi_gmem1.ARBURST),
    .m_axi_gmem1_arcache(m_axi_gmem1.ARCACHE),
    .m_axi_gmem1_arid(m_axi_gmem1.ARID),
    .m_axi_gmem1_arlen(m_axi_gmem1.ARLEN),
    .m_axi_gmem1_arlock(m_axi_gmem1.ARLOCK),
    .m_axi_gmem1_arprot(m_axi_gmem1.ARPROT),
    .m_axi_gmem1_arqos(m_axi_gmem1.ARQOS),
    .m_axi_gmem1_arready(m_axi_gmem1.ARREADY),
    .m_axi_gmem1_arregion(m_axi_gmem1.ARREGION),
    .m_axi_gmem1_arsize(m_axi_gmem1.ARSIZE),
    .m_axi_gmem1_arvalid(m_axi_gmem1.ARVALID),
    .m_axi_gmem1_awaddr(m_axi_gmem1.AWADDR),
    .m_axi_gmem1_awburst(m_axi_gmem1.AWBURST),
    .m_axi_gmem1_awcache(m_axi_gmem1.AWCACHE),
    .m_axi_gmem1_awid(m_axi_gmem1.AWID),
    .m_axi_gmem1_awlen(m_axi_gmem1.AWLEN),
    .m_axi_gmem1_awlock(m_axi_gmem1.AWLOCK),
    .m_axi_gmem1_awprot(m_axi_gmem1.AWPROT),
    .m_axi_gmem1_awqos(m_axi_gmem1.AWQOS),
    .m_axi_gmem1_awready(m_axi_gmem1.AWREADY),
    .m_axi_gmem1_awregion(m_axi_gmem1.AWREGION),
    .m_axi_gmem1_awsize(m_axi_gmem1.AWSIZE),
    .m_axi_gmem1_awvalid(m_axi_gmem1.AWVALID),
    .m_axi_gmem1_bid(m_axi_gmem1.BID),
    .m_axi_gmem1_bready(m_axi_gmem1.BREADY),
    .m_axi_gmem1_bresp(m_axi_gmem1.BRESP),
    .m_axi_gmem1_bvalid(m_axi_gmem1.BVALID),
    .m_axi_gmem1_rdata(m_axi_gmem1.RDATA),
    .m_axi_gmem1_rid(m_axi_gmem1.RID),
    .m_axi_gmem1_rlast(m_axi_gmem1.RLAST),
    .m_axi_gmem1_rready(m_axi_gmem1.RREADY),
    .m_axi_gmem1_rresp(m_axi_gmem1.RRESP),
    .m_axi_gmem1_rvalid(m_axi_gmem1.RVALID),
    .m_axi_gmem1_wdata(m_axi_gmem1.WDATA),
    .m_axi_gmem1_wid(m_axi_gmem1.WID),
    .m_axi_gmem1_wlast(m_axi_gmem1.WLAST),
    .m_axi_gmem1_wready(m_axi_gmem1.WREADY),
    .m_axi_gmem1_wstrb(m_axi_gmem1.WSTRB),
    .m_axi_gmem1_wvalid(m_axi_gmem1.WVALID),
    .s_axi_control_araddr(s_axi_control.ARADDR),
    .s_axi_control_arready(s_axi_control.ARREADY),
    .s_axi_control_arvalid(s_axi_control.ARVALID),
    .s_axi_control_awaddr(s_axi_control.AWADDR),
    .s_axi_control_awready(s_axi_control.AWREADY),
    .s_axi_control_awvalid(s_axi_control.AWVALID),
    .s_axi_control_bready(s_axi_control.BREADY),
    .s_axi_control_bresp(s_axi_control.BRESP),
    .s_axi_control_bvalid(s_axi_control.BVALID),
    .s_axi_control_rdata(s_axi_control.RDATA),
    .s_axi_control_rready(s_axi_control.RREADY),
    .s_axi_control_rresp(s_axi_control.RRESP),
    .s_axi_control_rvalid(s_axi_control.RVALID),
    .s_axi_control_wdata(s_axi_control.WDATA),
    .s_axi_control_wready(s_axi_control.WREADY),
    .s_axi_control_wstrb(s_axi_control.WSTRB),
    .s_axi_control_wvalid(s_axi_control.WVALID),
    .s_axi_control_r_araddr(s_axi_control_r.ARADDR),
    .s_axi_control_r_arready(s_axi_control_r.ARREADY),
    .s_axi_control_r_arvalid(s_axi_control_r.ARVALID),
    .s_axi_control_r_awaddr(s_axi_control_r.AWADDR),
    .s_axi_control_r_awready(s_axi_control_r.AWREADY),
    .s_axi_control_r_awvalid(s_axi_control_r.AWVALID),
    .s_axi_control_r_bready(s_axi_control_r.BREADY),
    .s_axi_control_r_bresp(s_axi_control_r.BRESP),
    .s_axi_control_r_bvalid(s_axi_control_r.BVALID),
    .s_axi_control_r_rdata(s_axi_control_r.RDATA),
    .s_axi_control_r_rready(s_axi_control_r.RREADY),
    .s_axi_control_r_rresp(s_axi_control_r.RRESP),
    .s_axi_control_r_rvalid(s_axi_control_r.RVALID),
    .s_axi_control_r_wdata(s_axi_control_r.WDATA),
    .s_axi_control_r_wready(s_axi_control_r.WREADY),
    .s_axi_control_r_wstrb(s_axi_control_r.WSTRB),
    .s_axi_control_r_wvalid(s_axi_control_r.WVALID)
  );

endmodule
