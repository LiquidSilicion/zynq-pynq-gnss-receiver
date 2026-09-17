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

// The following must be inserted into your Verilog file for this
// module to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

// INST_TAG     ------ Begin cut for INSTANTIATION Template ------
bd_0 your_instance_name (
  .ap_clk(ap_clk), // input wire ap_clk
  .ap_rst_n(ap_rst_n), // input wire ap_rst_n
  .interrupt(interrupt), // output wire interrupt
  .m_axi_gmem0_araddr(m_axi_gmem0_araddr), // output wire [63:0] m_axi_gmem0_araddr
  .m_axi_gmem0_arburst(m_axi_gmem0_arburst), // output wire [1:0] m_axi_gmem0_arburst
  .m_axi_gmem0_arcache(m_axi_gmem0_arcache), // output wire [3:0] m_axi_gmem0_arcache
  .m_axi_gmem0_arid(m_axi_gmem0_arid), // output wire [0:0] m_axi_gmem0_arid
  .m_axi_gmem0_arlen(m_axi_gmem0_arlen), // output wire [7:0] m_axi_gmem0_arlen
  .m_axi_gmem0_arlock(m_axi_gmem0_arlock), // output wire [1:0] m_axi_gmem0_arlock
  .m_axi_gmem0_arprot(m_axi_gmem0_arprot), // output wire [2:0] m_axi_gmem0_arprot
  .m_axi_gmem0_arqos(m_axi_gmem0_arqos), // output wire [3:0] m_axi_gmem0_arqos
  .m_axi_gmem0_arready(m_axi_gmem0_arready), // input wire m_axi_gmem0_arready
  .m_axi_gmem0_arregion(m_axi_gmem0_arregion), // output wire [3:0] m_axi_gmem0_arregion
  .m_axi_gmem0_arsize(m_axi_gmem0_arsize), // output wire [2:0] m_axi_gmem0_arsize
  .m_axi_gmem0_arvalid(m_axi_gmem0_arvalid), // output wire m_axi_gmem0_arvalid
  .m_axi_gmem0_awaddr(m_axi_gmem0_awaddr), // output wire [63:0] m_axi_gmem0_awaddr
  .m_axi_gmem0_awburst(m_axi_gmem0_awburst), // output wire [1:0] m_axi_gmem0_awburst
  .m_axi_gmem0_awcache(m_axi_gmem0_awcache), // output wire [3:0] m_axi_gmem0_awcache
  .m_axi_gmem0_awid(m_axi_gmem0_awid), // output wire [0:0] m_axi_gmem0_awid
  .m_axi_gmem0_awlen(m_axi_gmem0_awlen), // output wire [7:0] m_axi_gmem0_awlen
  .m_axi_gmem0_awlock(m_axi_gmem0_awlock), // output wire [1:0] m_axi_gmem0_awlock
  .m_axi_gmem0_awprot(m_axi_gmem0_awprot), // output wire [2:0] m_axi_gmem0_awprot
  .m_axi_gmem0_awqos(m_axi_gmem0_awqos), // output wire [3:0] m_axi_gmem0_awqos
  .m_axi_gmem0_awready(m_axi_gmem0_awready), // input wire m_axi_gmem0_awready
  .m_axi_gmem0_awregion(m_axi_gmem0_awregion), // output wire [3:0] m_axi_gmem0_awregion
  .m_axi_gmem0_awsize(m_axi_gmem0_awsize), // output wire [2:0] m_axi_gmem0_awsize
  .m_axi_gmem0_awvalid(m_axi_gmem0_awvalid), // output wire m_axi_gmem0_awvalid
  .m_axi_gmem0_bid(m_axi_gmem0_bid), // input wire [0:0] m_axi_gmem0_bid
  .m_axi_gmem0_bready(m_axi_gmem0_bready), // output wire m_axi_gmem0_bready
  .m_axi_gmem0_bresp(m_axi_gmem0_bresp), // input wire [1:0] m_axi_gmem0_bresp
  .m_axi_gmem0_bvalid(m_axi_gmem0_bvalid), // input wire m_axi_gmem0_bvalid
  .m_axi_gmem0_rdata(m_axi_gmem0_rdata), // input wire [31:0] m_axi_gmem0_rdata
  .m_axi_gmem0_rid(m_axi_gmem0_rid), // input wire [0:0] m_axi_gmem0_rid
  .m_axi_gmem0_rlast(m_axi_gmem0_rlast), // input wire m_axi_gmem0_rlast
  .m_axi_gmem0_rready(m_axi_gmem0_rready), // output wire m_axi_gmem0_rready
  .m_axi_gmem0_rresp(m_axi_gmem0_rresp), // input wire [1:0] m_axi_gmem0_rresp
  .m_axi_gmem0_rvalid(m_axi_gmem0_rvalid), // input wire m_axi_gmem0_rvalid
  .m_axi_gmem0_wdata(m_axi_gmem0_wdata), // output wire [31:0] m_axi_gmem0_wdata
  .m_axi_gmem0_wid(m_axi_gmem0_wid), // output wire [0:0] m_axi_gmem0_wid
  .m_axi_gmem0_wlast(m_axi_gmem0_wlast), // output wire m_axi_gmem0_wlast
  .m_axi_gmem0_wready(m_axi_gmem0_wready), // input wire m_axi_gmem0_wready
  .m_axi_gmem0_wstrb(m_axi_gmem0_wstrb), // output wire [3:0] m_axi_gmem0_wstrb
  .m_axi_gmem0_wvalid(m_axi_gmem0_wvalid), // output wire m_axi_gmem0_wvalid
  .m_axi_gmem1_araddr(m_axi_gmem1_araddr), // output wire [63:0] m_axi_gmem1_araddr
  .m_axi_gmem1_arburst(m_axi_gmem1_arburst), // output wire [1:0] m_axi_gmem1_arburst
  .m_axi_gmem1_arcache(m_axi_gmem1_arcache), // output wire [3:0] m_axi_gmem1_arcache
  .m_axi_gmem1_arid(m_axi_gmem1_arid), // output wire [0:0] m_axi_gmem1_arid
  .m_axi_gmem1_arlen(m_axi_gmem1_arlen), // output wire [7:0] m_axi_gmem1_arlen
  .m_axi_gmem1_arlock(m_axi_gmem1_arlock), // output wire [1:0] m_axi_gmem1_arlock
  .m_axi_gmem1_arprot(m_axi_gmem1_arprot), // output wire [2:0] m_axi_gmem1_arprot
  .m_axi_gmem1_arqos(m_axi_gmem1_arqos), // output wire [3:0] m_axi_gmem1_arqos
  .m_axi_gmem1_arready(m_axi_gmem1_arready), // input wire m_axi_gmem1_arready
  .m_axi_gmem1_arregion(m_axi_gmem1_arregion), // output wire [3:0] m_axi_gmem1_arregion
  .m_axi_gmem1_arsize(m_axi_gmem1_arsize), // output wire [2:0] m_axi_gmem1_arsize
  .m_axi_gmem1_arvalid(m_axi_gmem1_arvalid), // output wire m_axi_gmem1_arvalid
  .m_axi_gmem1_awaddr(m_axi_gmem1_awaddr), // output wire [63:0] m_axi_gmem1_awaddr
  .m_axi_gmem1_awburst(m_axi_gmem1_awburst), // output wire [1:0] m_axi_gmem1_awburst
  .m_axi_gmem1_awcache(m_axi_gmem1_awcache), // output wire [3:0] m_axi_gmem1_awcache
  .m_axi_gmem1_awid(m_axi_gmem1_awid), // output wire [0:0] m_axi_gmem1_awid
  .m_axi_gmem1_awlen(m_axi_gmem1_awlen), // output wire [7:0] m_axi_gmem1_awlen
  .m_axi_gmem1_awlock(m_axi_gmem1_awlock), // output wire [1:0] m_axi_gmem1_awlock
  .m_axi_gmem1_awprot(m_axi_gmem1_awprot), // output wire [2:0] m_axi_gmem1_awprot
  .m_axi_gmem1_awqos(m_axi_gmem1_awqos), // output wire [3:0] m_axi_gmem1_awqos
  .m_axi_gmem1_awready(m_axi_gmem1_awready), // input wire m_axi_gmem1_awready
  .m_axi_gmem1_awregion(m_axi_gmem1_awregion), // output wire [3:0] m_axi_gmem1_awregion
  .m_axi_gmem1_awsize(m_axi_gmem1_awsize), // output wire [2:0] m_axi_gmem1_awsize
  .m_axi_gmem1_awvalid(m_axi_gmem1_awvalid), // output wire m_axi_gmem1_awvalid
  .m_axi_gmem1_bid(m_axi_gmem1_bid), // input wire [0:0] m_axi_gmem1_bid
  .m_axi_gmem1_bready(m_axi_gmem1_bready), // output wire m_axi_gmem1_bready
  .m_axi_gmem1_bresp(m_axi_gmem1_bresp), // input wire [1:0] m_axi_gmem1_bresp
  .m_axi_gmem1_bvalid(m_axi_gmem1_bvalid), // input wire m_axi_gmem1_bvalid
  .m_axi_gmem1_rdata(m_axi_gmem1_rdata), // input wire [31:0] m_axi_gmem1_rdata
  .m_axi_gmem1_rid(m_axi_gmem1_rid), // input wire [0:0] m_axi_gmem1_rid
  .m_axi_gmem1_rlast(m_axi_gmem1_rlast), // input wire m_axi_gmem1_rlast
  .m_axi_gmem1_rready(m_axi_gmem1_rready), // output wire m_axi_gmem1_rready
  .m_axi_gmem1_rresp(m_axi_gmem1_rresp), // input wire [1:0] m_axi_gmem1_rresp
  .m_axi_gmem1_rvalid(m_axi_gmem1_rvalid), // input wire m_axi_gmem1_rvalid
  .m_axi_gmem1_wdata(m_axi_gmem1_wdata), // output wire [31:0] m_axi_gmem1_wdata
  .m_axi_gmem1_wid(m_axi_gmem1_wid), // output wire [0:0] m_axi_gmem1_wid
  .m_axi_gmem1_wlast(m_axi_gmem1_wlast), // output wire m_axi_gmem1_wlast
  .m_axi_gmem1_wready(m_axi_gmem1_wready), // input wire m_axi_gmem1_wready
  .m_axi_gmem1_wstrb(m_axi_gmem1_wstrb), // output wire [3:0] m_axi_gmem1_wstrb
  .m_axi_gmem1_wvalid(m_axi_gmem1_wvalid), // output wire m_axi_gmem1_wvalid
  .s_axi_control_araddr(s_axi_control_araddr), // input wire [5:0] s_axi_control_araddr
  .s_axi_control_arready(s_axi_control_arready), // output wire s_axi_control_arready
  .s_axi_control_arvalid(s_axi_control_arvalid), // input wire s_axi_control_arvalid
  .s_axi_control_awaddr(s_axi_control_awaddr), // input wire [5:0] s_axi_control_awaddr
  .s_axi_control_awready(s_axi_control_awready), // output wire s_axi_control_awready
  .s_axi_control_awvalid(s_axi_control_awvalid), // input wire s_axi_control_awvalid
  .s_axi_control_bready(s_axi_control_bready), // input wire s_axi_control_bready
  .s_axi_control_bresp(s_axi_control_bresp), // output wire [1:0] s_axi_control_bresp
  .s_axi_control_bvalid(s_axi_control_bvalid), // output wire s_axi_control_bvalid
  .s_axi_control_rdata(s_axi_control_rdata), // output wire [31:0] s_axi_control_rdata
  .s_axi_control_rready(s_axi_control_rready), // input wire s_axi_control_rready
  .s_axi_control_rresp(s_axi_control_rresp), // output wire [1:0] s_axi_control_rresp
  .s_axi_control_rvalid(s_axi_control_rvalid), // output wire s_axi_control_rvalid
  .s_axi_control_wdata(s_axi_control_wdata), // input wire [31:0] s_axi_control_wdata
  .s_axi_control_wready(s_axi_control_wready), // output wire s_axi_control_wready
  .s_axi_control_wstrb(s_axi_control_wstrb), // input wire [3:0] s_axi_control_wstrb
  .s_axi_control_wvalid(s_axi_control_wvalid), // input wire s_axi_control_wvalid
  .s_axi_control_r_araddr(s_axi_control_r_araddr), // input wire [5:0] s_axi_control_r_araddr
  .s_axi_control_r_arready(s_axi_control_r_arready), // output wire s_axi_control_r_arready
  .s_axi_control_r_arvalid(s_axi_control_r_arvalid), // input wire s_axi_control_r_arvalid
  .s_axi_control_r_awaddr(s_axi_control_r_awaddr), // input wire [5:0] s_axi_control_r_awaddr
  .s_axi_control_r_awready(s_axi_control_r_awready), // output wire s_axi_control_r_awready
  .s_axi_control_r_awvalid(s_axi_control_r_awvalid), // input wire s_axi_control_r_awvalid
  .s_axi_control_r_bready(s_axi_control_r_bready), // input wire s_axi_control_r_bready
  .s_axi_control_r_bresp(s_axi_control_r_bresp), // output wire [1:0] s_axi_control_r_bresp
  .s_axi_control_r_bvalid(s_axi_control_r_bvalid), // output wire s_axi_control_r_bvalid
  .s_axi_control_r_rdata(s_axi_control_r_rdata), // output wire [31:0] s_axi_control_r_rdata
  .s_axi_control_r_rready(s_axi_control_r_rready), // input wire s_axi_control_r_rready
  .s_axi_control_r_rresp(s_axi_control_r_rresp), // output wire [1:0] s_axi_control_r_rresp
  .s_axi_control_r_rvalid(s_axi_control_r_rvalid), // output wire s_axi_control_r_rvalid
  .s_axi_control_r_wdata(s_axi_control_r_wdata), // input wire [31:0] s_axi_control_r_wdata
  .s_axi_control_r_wready(s_axi_control_r_wready), // output wire s_axi_control_r_wready
  .s_axi_control_r_wstrb(s_axi_control_r_wstrb), // input wire [3:0] s_axi_control_r_wstrb
  .s_axi_control_r_wvalid(s_axi_control_r_wvalid) // input wire s_axi_control_r_wvalid
);
// INST_TAG_END ------  End cut for INSTANTIATION Template  ------

// You must compile the wrapper file bd_0.v when simulating
// the module, bd_0. When compiling the wrapper file, be sure to
// reference the Verilog simulation library.
