//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
//Date        : Sun Sep 20 21:49:39 2026
//Host        : johan2-Yoga-7-15ITL5 running 64-bit Ubuntu 22.04.5 LTS
//Command     : generate_target bd_0_wrapper.bd
//Design      : bd_0_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module bd_0_wrapper
   (ap_clk,
    ap_rst_n,
    interrupt,
    m_axi_gmem0_araddr,
    m_axi_gmem0_arburst,
    m_axi_gmem0_arcache,
    m_axi_gmem0_arid,
    m_axi_gmem0_arlen,
    m_axi_gmem0_arlock,
    m_axi_gmem0_arprot,
    m_axi_gmem0_arqos,
    m_axi_gmem0_arready,
    m_axi_gmem0_arregion,
    m_axi_gmem0_arsize,
    m_axi_gmem0_arvalid,
    m_axi_gmem0_awaddr,
    m_axi_gmem0_awburst,
    m_axi_gmem0_awcache,
    m_axi_gmem0_awid,
    m_axi_gmem0_awlen,
    m_axi_gmem0_awlock,
    m_axi_gmem0_awprot,
    m_axi_gmem0_awqos,
    m_axi_gmem0_awready,
    m_axi_gmem0_awregion,
    m_axi_gmem0_awsize,
    m_axi_gmem0_awvalid,
    m_axi_gmem0_bid,
    m_axi_gmem0_bready,
    m_axi_gmem0_bresp,
    m_axi_gmem0_bvalid,
    m_axi_gmem0_rdata,
    m_axi_gmem0_rid,
    m_axi_gmem0_rlast,
    m_axi_gmem0_rready,
    m_axi_gmem0_rresp,
    m_axi_gmem0_rvalid,
    m_axi_gmem0_wdata,
    m_axi_gmem0_wid,
    m_axi_gmem0_wlast,
    m_axi_gmem0_wready,
    m_axi_gmem0_wstrb,
    m_axi_gmem0_wvalid,
    m_axi_gmem1_araddr,
    m_axi_gmem1_arburst,
    m_axi_gmem1_arcache,
    m_axi_gmem1_arid,
    m_axi_gmem1_arlen,
    m_axi_gmem1_arlock,
    m_axi_gmem1_arprot,
    m_axi_gmem1_arqos,
    m_axi_gmem1_arready,
    m_axi_gmem1_arregion,
    m_axi_gmem1_arsize,
    m_axi_gmem1_arvalid,
    m_axi_gmem1_awaddr,
    m_axi_gmem1_awburst,
    m_axi_gmem1_awcache,
    m_axi_gmem1_awid,
    m_axi_gmem1_awlen,
    m_axi_gmem1_awlock,
    m_axi_gmem1_awprot,
    m_axi_gmem1_awqos,
    m_axi_gmem1_awready,
    m_axi_gmem1_awregion,
    m_axi_gmem1_awsize,
    m_axi_gmem1_awvalid,
    m_axi_gmem1_bid,
    m_axi_gmem1_bready,
    m_axi_gmem1_bresp,
    m_axi_gmem1_bvalid,
    m_axi_gmem1_rdata,
    m_axi_gmem1_rid,
    m_axi_gmem1_rlast,
    m_axi_gmem1_rready,
    m_axi_gmem1_rresp,
    m_axi_gmem1_rvalid,
    m_axi_gmem1_wdata,
    m_axi_gmem1_wid,
    m_axi_gmem1_wlast,
    m_axi_gmem1_wready,
    m_axi_gmem1_wstrb,
    m_axi_gmem1_wvalid,
    s_axi_control_araddr,
    s_axi_control_arready,
    s_axi_control_arvalid,
    s_axi_control_awaddr,
    s_axi_control_awready,
    s_axi_control_awvalid,
    s_axi_control_bready,
    s_axi_control_bresp,
    s_axi_control_bvalid,
    s_axi_control_r_araddr,
    s_axi_control_r_arready,
    s_axi_control_r_arvalid,
    s_axi_control_r_awaddr,
    s_axi_control_r_awready,
    s_axi_control_r_awvalid,
    s_axi_control_r_bready,
    s_axi_control_r_bresp,
    s_axi_control_r_bvalid,
    s_axi_control_r_rdata,
    s_axi_control_r_rready,
    s_axi_control_r_rresp,
    s_axi_control_r_rvalid,
    s_axi_control_r_wdata,
    s_axi_control_r_wready,
    s_axi_control_r_wstrb,
    s_axi_control_r_wvalid,
    s_axi_control_rdata,
    s_axi_control_rready,
    s_axi_control_rresp,
    s_axi_control_rvalid,
    s_axi_control_wdata,
    s_axi_control_wready,
    s_axi_control_wstrb,
    s_axi_control_wvalid);
  input ap_clk;
  input ap_rst_n;
  output interrupt;
  output [63:0]m_axi_gmem0_araddr;
  output [1:0]m_axi_gmem0_arburst;
  output [3:0]m_axi_gmem0_arcache;
  output [0:0]m_axi_gmem0_arid;
  output [7:0]m_axi_gmem0_arlen;
  output [1:0]m_axi_gmem0_arlock;
  output [2:0]m_axi_gmem0_arprot;
  output [3:0]m_axi_gmem0_arqos;
  input m_axi_gmem0_arready;
  output [3:0]m_axi_gmem0_arregion;
  output [2:0]m_axi_gmem0_arsize;
  output m_axi_gmem0_arvalid;
  output [63:0]m_axi_gmem0_awaddr;
  output [1:0]m_axi_gmem0_awburst;
  output [3:0]m_axi_gmem0_awcache;
  output [0:0]m_axi_gmem0_awid;
  output [7:0]m_axi_gmem0_awlen;
  output [1:0]m_axi_gmem0_awlock;
  output [2:0]m_axi_gmem0_awprot;
  output [3:0]m_axi_gmem0_awqos;
  input m_axi_gmem0_awready;
  output [3:0]m_axi_gmem0_awregion;
  output [2:0]m_axi_gmem0_awsize;
  output m_axi_gmem0_awvalid;
  input [0:0]m_axi_gmem0_bid;
  output m_axi_gmem0_bready;
  input [1:0]m_axi_gmem0_bresp;
  input m_axi_gmem0_bvalid;
  input [31:0]m_axi_gmem0_rdata;
  input [0:0]m_axi_gmem0_rid;
  input m_axi_gmem0_rlast;
  output m_axi_gmem0_rready;
  input [1:0]m_axi_gmem0_rresp;
  input m_axi_gmem0_rvalid;
  output [31:0]m_axi_gmem0_wdata;
  output [0:0]m_axi_gmem0_wid;
  output m_axi_gmem0_wlast;
  input m_axi_gmem0_wready;
  output [3:0]m_axi_gmem0_wstrb;
  output m_axi_gmem0_wvalid;
  output [63:0]m_axi_gmem1_araddr;
  output [1:0]m_axi_gmem1_arburst;
  output [3:0]m_axi_gmem1_arcache;
  output [0:0]m_axi_gmem1_arid;
  output [7:0]m_axi_gmem1_arlen;
  output [1:0]m_axi_gmem1_arlock;
  output [2:0]m_axi_gmem1_arprot;
  output [3:0]m_axi_gmem1_arqos;
  input m_axi_gmem1_arready;
  output [3:0]m_axi_gmem1_arregion;
  output [2:0]m_axi_gmem1_arsize;
  output m_axi_gmem1_arvalid;
  output [63:0]m_axi_gmem1_awaddr;
  output [1:0]m_axi_gmem1_awburst;
  output [3:0]m_axi_gmem1_awcache;
  output [0:0]m_axi_gmem1_awid;
  output [7:0]m_axi_gmem1_awlen;
  output [1:0]m_axi_gmem1_awlock;
  output [2:0]m_axi_gmem1_awprot;
  output [3:0]m_axi_gmem1_awqos;
  input m_axi_gmem1_awready;
  output [3:0]m_axi_gmem1_awregion;
  output [2:0]m_axi_gmem1_awsize;
  output m_axi_gmem1_awvalid;
  input [0:0]m_axi_gmem1_bid;
  output m_axi_gmem1_bready;
  input [1:0]m_axi_gmem1_bresp;
  input m_axi_gmem1_bvalid;
  input [31:0]m_axi_gmem1_rdata;
  input [0:0]m_axi_gmem1_rid;
  input m_axi_gmem1_rlast;
  output m_axi_gmem1_rready;
  input [1:0]m_axi_gmem1_rresp;
  input m_axi_gmem1_rvalid;
  output [31:0]m_axi_gmem1_wdata;
  output [0:0]m_axi_gmem1_wid;
  output m_axi_gmem1_wlast;
  input m_axi_gmem1_wready;
  output [3:0]m_axi_gmem1_wstrb;
  output m_axi_gmem1_wvalid;
  input [7:0]s_axi_control_araddr;
  output s_axi_control_arready;
  input s_axi_control_arvalid;
  input [7:0]s_axi_control_awaddr;
  output s_axi_control_awready;
  input s_axi_control_awvalid;
  input s_axi_control_bready;
  output [1:0]s_axi_control_bresp;
  output s_axi_control_bvalid;
  input [5:0]s_axi_control_r_araddr;
  output s_axi_control_r_arready;
  input s_axi_control_r_arvalid;
  input [5:0]s_axi_control_r_awaddr;
  output s_axi_control_r_awready;
  input s_axi_control_r_awvalid;
  input s_axi_control_r_bready;
  output [1:0]s_axi_control_r_bresp;
  output s_axi_control_r_bvalid;
  output [31:0]s_axi_control_r_rdata;
  input s_axi_control_r_rready;
  output [1:0]s_axi_control_r_rresp;
  output s_axi_control_r_rvalid;
  input [31:0]s_axi_control_r_wdata;
  output s_axi_control_r_wready;
  input [3:0]s_axi_control_r_wstrb;
  input s_axi_control_r_wvalid;
  output [31:0]s_axi_control_rdata;
  input s_axi_control_rready;
  output [1:0]s_axi_control_rresp;
  output s_axi_control_rvalid;
  input [31:0]s_axi_control_wdata;
  output s_axi_control_wready;
  input [3:0]s_axi_control_wstrb;
  input s_axi_control_wvalid;

  wire ap_clk;
  wire ap_rst_n;
  wire interrupt;
  wire [63:0]m_axi_gmem0_araddr;
  wire [1:0]m_axi_gmem0_arburst;
  wire [3:0]m_axi_gmem0_arcache;
  wire [0:0]m_axi_gmem0_arid;
  wire [7:0]m_axi_gmem0_arlen;
  wire [1:0]m_axi_gmem0_arlock;
  wire [2:0]m_axi_gmem0_arprot;
  wire [3:0]m_axi_gmem0_arqos;
  wire m_axi_gmem0_arready;
  wire [3:0]m_axi_gmem0_arregion;
  wire [2:0]m_axi_gmem0_arsize;
  wire m_axi_gmem0_arvalid;
  wire [63:0]m_axi_gmem0_awaddr;
  wire [1:0]m_axi_gmem0_awburst;
  wire [3:0]m_axi_gmem0_awcache;
  wire [0:0]m_axi_gmem0_awid;
  wire [7:0]m_axi_gmem0_awlen;
  wire [1:0]m_axi_gmem0_awlock;
  wire [2:0]m_axi_gmem0_awprot;
  wire [3:0]m_axi_gmem0_awqos;
  wire m_axi_gmem0_awready;
  wire [3:0]m_axi_gmem0_awregion;
  wire [2:0]m_axi_gmem0_awsize;
  wire m_axi_gmem0_awvalid;
  wire [0:0]m_axi_gmem0_bid;
  wire m_axi_gmem0_bready;
  wire [1:0]m_axi_gmem0_bresp;
  wire m_axi_gmem0_bvalid;
  wire [31:0]m_axi_gmem0_rdata;
  wire [0:0]m_axi_gmem0_rid;
  wire m_axi_gmem0_rlast;
  wire m_axi_gmem0_rready;
  wire [1:0]m_axi_gmem0_rresp;
  wire m_axi_gmem0_rvalid;
  wire [31:0]m_axi_gmem0_wdata;
  wire [0:0]m_axi_gmem0_wid;
  wire m_axi_gmem0_wlast;
  wire m_axi_gmem0_wready;
  wire [3:0]m_axi_gmem0_wstrb;
  wire m_axi_gmem0_wvalid;
  wire [63:0]m_axi_gmem1_araddr;
  wire [1:0]m_axi_gmem1_arburst;
  wire [3:0]m_axi_gmem1_arcache;
  wire [0:0]m_axi_gmem1_arid;
  wire [7:0]m_axi_gmem1_arlen;
  wire [1:0]m_axi_gmem1_arlock;
  wire [2:0]m_axi_gmem1_arprot;
  wire [3:0]m_axi_gmem1_arqos;
  wire m_axi_gmem1_arready;
  wire [3:0]m_axi_gmem1_arregion;
  wire [2:0]m_axi_gmem1_arsize;
  wire m_axi_gmem1_arvalid;
  wire [63:0]m_axi_gmem1_awaddr;
  wire [1:0]m_axi_gmem1_awburst;
  wire [3:0]m_axi_gmem1_awcache;
  wire [0:0]m_axi_gmem1_awid;
  wire [7:0]m_axi_gmem1_awlen;
  wire [1:0]m_axi_gmem1_awlock;
  wire [2:0]m_axi_gmem1_awprot;
  wire [3:0]m_axi_gmem1_awqos;
  wire m_axi_gmem1_awready;
  wire [3:0]m_axi_gmem1_awregion;
  wire [2:0]m_axi_gmem1_awsize;
  wire m_axi_gmem1_awvalid;
  wire [0:0]m_axi_gmem1_bid;
  wire m_axi_gmem1_bready;
  wire [1:0]m_axi_gmem1_bresp;
  wire m_axi_gmem1_bvalid;
  wire [31:0]m_axi_gmem1_rdata;
  wire [0:0]m_axi_gmem1_rid;
  wire m_axi_gmem1_rlast;
  wire m_axi_gmem1_rready;
  wire [1:0]m_axi_gmem1_rresp;
  wire m_axi_gmem1_rvalid;
  wire [31:0]m_axi_gmem1_wdata;
  wire [0:0]m_axi_gmem1_wid;
  wire m_axi_gmem1_wlast;
  wire m_axi_gmem1_wready;
  wire [3:0]m_axi_gmem1_wstrb;
  wire m_axi_gmem1_wvalid;
  wire [7:0]s_axi_control_araddr;
  wire s_axi_control_arready;
  wire s_axi_control_arvalid;
  wire [7:0]s_axi_control_awaddr;
  wire s_axi_control_awready;
  wire s_axi_control_awvalid;
  wire s_axi_control_bready;
  wire [1:0]s_axi_control_bresp;
  wire s_axi_control_bvalid;
  wire [5:0]s_axi_control_r_araddr;
  wire s_axi_control_r_arready;
  wire s_axi_control_r_arvalid;
  wire [5:0]s_axi_control_r_awaddr;
  wire s_axi_control_r_awready;
  wire s_axi_control_r_awvalid;
  wire s_axi_control_r_bready;
  wire [1:0]s_axi_control_r_bresp;
  wire s_axi_control_r_bvalid;
  wire [31:0]s_axi_control_r_rdata;
  wire s_axi_control_r_rready;
  wire [1:0]s_axi_control_r_rresp;
  wire s_axi_control_r_rvalid;
  wire [31:0]s_axi_control_r_wdata;
  wire s_axi_control_r_wready;
  wire [3:0]s_axi_control_r_wstrb;
  wire s_axi_control_r_wvalid;
  wire [31:0]s_axi_control_rdata;
  wire s_axi_control_rready;
  wire [1:0]s_axi_control_rresp;
  wire s_axi_control_rvalid;
  wire [31:0]s_axi_control_wdata;
  wire s_axi_control_wready;
  wire [3:0]s_axi_control_wstrb;
  wire s_axi_control_wvalid;

  bd_0 bd_0_i
       (.ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .interrupt(interrupt),
        .m_axi_gmem0_araddr(m_axi_gmem0_araddr),
        .m_axi_gmem0_arburst(m_axi_gmem0_arburst),
        .m_axi_gmem0_arcache(m_axi_gmem0_arcache),
        .m_axi_gmem0_arid(m_axi_gmem0_arid),
        .m_axi_gmem0_arlen(m_axi_gmem0_arlen),
        .m_axi_gmem0_arlock(m_axi_gmem0_arlock),
        .m_axi_gmem0_arprot(m_axi_gmem0_arprot),
        .m_axi_gmem0_arqos(m_axi_gmem0_arqos),
        .m_axi_gmem0_arready(m_axi_gmem0_arready),
        .m_axi_gmem0_arregion(m_axi_gmem0_arregion),
        .m_axi_gmem0_arsize(m_axi_gmem0_arsize),
        .m_axi_gmem0_arvalid(m_axi_gmem0_arvalid),
        .m_axi_gmem0_awaddr(m_axi_gmem0_awaddr),
        .m_axi_gmem0_awburst(m_axi_gmem0_awburst),
        .m_axi_gmem0_awcache(m_axi_gmem0_awcache),
        .m_axi_gmem0_awid(m_axi_gmem0_awid),
        .m_axi_gmem0_awlen(m_axi_gmem0_awlen),
        .m_axi_gmem0_awlock(m_axi_gmem0_awlock),
        .m_axi_gmem0_awprot(m_axi_gmem0_awprot),
        .m_axi_gmem0_awqos(m_axi_gmem0_awqos),
        .m_axi_gmem0_awready(m_axi_gmem0_awready),
        .m_axi_gmem0_awregion(m_axi_gmem0_awregion),
        .m_axi_gmem0_awsize(m_axi_gmem0_awsize),
        .m_axi_gmem0_awvalid(m_axi_gmem0_awvalid),
        .m_axi_gmem0_bid(m_axi_gmem0_bid),
        .m_axi_gmem0_bready(m_axi_gmem0_bready),
        .m_axi_gmem0_bresp(m_axi_gmem0_bresp),
        .m_axi_gmem0_bvalid(m_axi_gmem0_bvalid),
        .m_axi_gmem0_rdata(m_axi_gmem0_rdata),
        .m_axi_gmem0_rid(m_axi_gmem0_rid),
        .m_axi_gmem0_rlast(m_axi_gmem0_rlast),
        .m_axi_gmem0_rready(m_axi_gmem0_rready),
        .m_axi_gmem0_rresp(m_axi_gmem0_rresp),
        .m_axi_gmem0_rvalid(m_axi_gmem0_rvalid),
        .m_axi_gmem0_wdata(m_axi_gmem0_wdata),
        .m_axi_gmem0_wid(m_axi_gmem0_wid),
        .m_axi_gmem0_wlast(m_axi_gmem0_wlast),
        .m_axi_gmem0_wready(m_axi_gmem0_wready),
        .m_axi_gmem0_wstrb(m_axi_gmem0_wstrb),
        .m_axi_gmem0_wvalid(m_axi_gmem0_wvalid),
        .m_axi_gmem1_araddr(m_axi_gmem1_araddr),
        .m_axi_gmem1_arburst(m_axi_gmem1_arburst),
        .m_axi_gmem1_arcache(m_axi_gmem1_arcache),
        .m_axi_gmem1_arid(m_axi_gmem1_arid),
        .m_axi_gmem1_arlen(m_axi_gmem1_arlen),
        .m_axi_gmem1_arlock(m_axi_gmem1_arlock),
        .m_axi_gmem1_arprot(m_axi_gmem1_arprot),
        .m_axi_gmem1_arqos(m_axi_gmem1_arqos),
        .m_axi_gmem1_arready(m_axi_gmem1_arready),
        .m_axi_gmem1_arregion(m_axi_gmem1_arregion),
        .m_axi_gmem1_arsize(m_axi_gmem1_arsize),
        .m_axi_gmem1_arvalid(m_axi_gmem1_arvalid),
        .m_axi_gmem1_awaddr(m_axi_gmem1_awaddr),
        .m_axi_gmem1_awburst(m_axi_gmem1_awburst),
        .m_axi_gmem1_awcache(m_axi_gmem1_awcache),
        .m_axi_gmem1_awid(m_axi_gmem1_awid),
        .m_axi_gmem1_awlen(m_axi_gmem1_awlen),
        .m_axi_gmem1_awlock(m_axi_gmem1_awlock),
        .m_axi_gmem1_awprot(m_axi_gmem1_awprot),
        .m_axi_gmem1_awqos(m_axi_gmem1_awqos),
        .m_axi_gmem1_awready(m_axi_gmem1_awready),
        .m_axi_gmem1_awregion(m_axi_gmem1_awregion),
        .m_axi_gmem1_awsize(m_axi_gmem1_awsize),
        .m_axi_gmem1_awvalid(m_axi_gmem1_awvalid),
        .m_axi_gmem1_bid(m_axi_gmem1_bid),
        .m_axi_gmem1_bready(m_axi_gmem1_bready),
        .m_axi_gmem1_bresp(m_axi_gmem1_bresp),
        .m_axi_gmem1_bvalid(m_axi_gmem1_bvalid),
        .m_axi_gmem1_rdata(m_axi_gmem1_rdata),
        .m_axi_gmem1_rid(m_axi_gmem1_rid),
        .m_axi_gmem1_rlast(m_axi_gmem1_rlast),
        .m_axi_gmem1_rready(m_axi_gmem1_rready),
        .m_axi_gmem1_rresp(m_axi_gmem1_rresp),
        .m_axi_gmem1_rvalid(m_axi_gmem1_rvalid),
        .m_axi_gmem1_wdata(m_axi_gmem1_wdata),
        .m_axi_gmem1_wid(m_axi_gmem1_wid),
        .m_axi_gmem1_wlast(m_axi_gmem1_wlast),
        .m_axi_gmem1_wready(m_axi_gmem1_wready),
        .m_axi_gmem1_wstrb(m_axi_gmem1_wstrb),
        .m_axi_gmem1_wvalid(m_axi_gmem1_wvalid),
        .s_axi_control_araddr(s_axi_control_araddr),
        .s_axi_control_arready(s_axi_control_arready),
        .s_axi_control_arvalid(s_axi_control_arvalid),
        .s_axi_control_awaddr(s_axi_control_awaddr),
        .s_axi_control_awready(s_axi_control_awready),
        .s_axi_control_awvalid(s_axi_control_awvalid),
        .s_axi_control_bready(s_axi_control_bready),
        .s_axi_control_bresp(s_axi_control_bresp),
        .s_axi_control_bvalid(s_axi_control_bvalid),
        .s_axi_control_r_araddr(s_axi_control_r_araddr),
        .s_axi_control_r_arready(s_axi_control_r_arready),
        .s_axi_control_r_arvalid(s_axi_control_r_arvalid),
        .s_axi_control_r_awaddr(s_axi_control_r_awaddr),
        .s_axi_control_r_awready(s_axi_control_r_awready),
        .s_axi_control_r_awvalid(s_axi_control_r_awvalid),
        .s_axi_control_r_bready(s_axi_control_r_bready),
        .s_axi_control_r_bresp(s_axi_control_r_bresp),
        .s_axi_control_r_bvalid(s_axi_control_r_bvalid),
        .s_axi_control_r_rdata(s_axi_control_r_rdata),
        .s_axi_control_r_rready(s_axi_control_r_rready),
        .s_axi_control_r_rresp(s_axi_control_r_rresp),
        .s_axi_control_r_rvalid(s_axi_control_r_rvalid),
        .s_axi_control_r_wdata(s_axi_control_r_wdata),
        .s_axi_control_r_wready(s_axi_control_r_wready),
        .s_axi_control_r_wstrb(s_axi_control_r_wstrb),
        .s_axi_control_r_wvalid(s_axi_control_r_wvalid),
        .s_axi_control_rdata(s_axi_control_rdata),
        .s_axi_control_rready(s_axi_control_rready),
        .s_axi_control_rresp(s_axi_control_rresp),
        .s_axi_control_rvalid(s_axi_control_rvalid),
        .s_axi_control_wdata(s_axi_control_wdata),
        .s_axi_control_wready(s_axi_control_wready),
        .s_axi_control_wstrb(s_axi_control_wstrb),
        .s_axi_control_wvalid(s_axi_control_wvalid));
endmodule
