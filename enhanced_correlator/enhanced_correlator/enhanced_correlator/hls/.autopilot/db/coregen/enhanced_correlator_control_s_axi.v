// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
`timescale 1ns/1ps
(* DowngradeIPIdentifiedWarnings="yes" *) module enhanced_correlator_control_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 8,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    output wire                          interrupt,
    input  wire [31:0]                   corr_E_I,
    input  wire                          corr_E_I_ap_vld,
    input  wire [31:0]                   corr_E_Q,
    input  wire                          corr_E_Q_ap_vld,
    input  wire [31:0]                   corr_P_I,
    input  wire                          corr_P_I_ap_vld,
    input  wire [31:0]                   corr_P_Q,
    input  wire                          corr_P_Q_ap_vld,
    input  wire [31:0]                   corr_L_I,
    input  wire                          corr_L_I_ap_vld,
    input  wire [31:0]                   corr_L_Q,
    input  wire                          corr_L_Q_ap_vld,
    output wire [31:0]                   num_samples,
    output wire [31:0]                   carrier_freq,
    output wire [31:0]                   carrier_phase_init,
    output wire [31:0]                   code_phase_init,
    output wire [31:0]                   code_freq,
    output wire [31:0]                   sample_rate,
    output wire [31:0]                   code_length,
    output wire [31:0]                   correlator_spacing,
    output wire                          ap_start,
    input  wire                          ap_done,
    input  wire                          ap_ready,
    input  wire                          ap_idle
);
//------------------------Address Info-------------------
// Protocol Used: ap_ctrl_hs
//
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
// 0x10 : Data signal of corr_E_I
//        bit 31~0 - corr_E_I[31:0] (Read)
// 0x14 : Control signal of corr_E_I
//        bit 0  - corr_E_I_ap_vld (Read/COR)
//        others - reserved
// 0x20 : Data signal of corr_E_Q
//        bit 31~0 - corr_E_Q[31:0] (Read)
// 0x24 : Control signal of corr_E_Q
//        bit 0  - corr_E_Q_ap_vld (Read/COR)
//        others - reserved
// 0x30 : Data signal of corr_P_I
//        bit 31~0 - corr_P_I[31:0] (Read)
// 0x34 : Control signal of corr_P_I
//        bit 0  - corr_P_I_ap_vld (Read/COR)
//        others - reserved
// 0x40 : Data signal of corr_P_Q
//        bit 31~0 - corr_P_Q[31:0] (Read)
// 0x44 : Control signal of corr_P_Q
//        bit 0  - corr_P_Q_ap_vld (Read/COR)
//        others - reserved
// 0x50 : Data signal of corr_L_I
//        bit 31~0 - corr_L_I[31:0] (Read)
// 0x54 : Control signal of corr_L_I
//        bit 0  - corr_L_I_ap_vld (Read/COR)
//        others - reserved
// 0x60 : Data signal of corr_L_Q
//        bit 31~0 - corr_L_Q[31:0] (Read)
// 0x64 : Control signal of corr_L_Q
//        bit 0  - corr_L_Q_ap_vld (Read/COR)
//        others - reserved
// 0x70 : Data signal of num_samples
//        bit 31~0 - num_samples[31:0] (Read/Write)
// 0x74 : reserved
// 0x78 : Data signal of carrier_freq
//        bit 31~0 - carrier_freq[31:0] (Read/Write)
// 0x7c : reserved
// 0x80 : Data signal of carrier_phase_init
//        bit 31~0 - carrier_phase_init[31:0] (Read/Write)
// 0x84 : reserved
// 0x88 : Data signal of code_phase_init
//        bit 31~0 - code_phase_init[31:0] (Read/Write)
// 0x8c : reserved
// 0x90 : Data signal of code_freq
//        bit 31~0 - code_freq[31:0] (Read/Write)
// 0x94 : reserved
// 0x98 : Data signal of sample_rate
//        bit 31~0 - sample_rate[31:0] (Read/Write)
// 0x9c : reserved
// 0xa0 : Data signal of code_length
//        bit 31~0 - code_length[31:0] (Read/Write)
// 0xa4 : reserved
// 0xa8 : Data signal of correlator_spacing
//        bit 31~0 - correlator_spacing[31:0] (Read/Write)
// 0xac : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

//------------------------Parameter----------------------
localparam
    ADDR_AP_CTRL                   = 8'h00,
    ADDR_GIE                       = 8'h04,
    ADDR_IER                       = 8'h08,
    ADDR_ISR                       = 8'h0c,
    ADDR_CORR_E_I_DATA_0           = 8'h10,
    ADDR_CORR_E_I_CTRL             = 8'h14,
    ADDR_CORR_E_Q_DATA_0           = 8'h20,
    ADDR_CORR_E_Q_CTRL             = 8'h24,
    ADDR_CORR_P_I_DATA_0           = 8'h30,
    ADDR_CORR_P_I_CTRL             = 8'h34,
    ADDR_CORR_P_Q_DATA_0           = 8'h40,
    ADDR_CORR_P_Q_CTRL             = 8'h44,
    ADDR_CORR_L_I_DATA_0           = 8'h50,
    ADDR_CORR_L_I_CTRL             = 8'h54,
    ADDR_CORR_L_Q_DATA_0           = 8'h60,
    ADDR_CORR_L_Q_CTRL             = 8'h64,
    ADDR_NUM_SAMPLES_DATA_0        = 8'h70,
    ADDR_NUM_SAMPLES_CTRL          = 8'h74,
    ADDR_CARRIER_FREQ_DATA_0       = 8'h78,
    ADDR_CARRIER_FREQ_CTRL         = 8'h7c,
    ADDR_CARRIER_PHASE_INIT_DATA_0 = 8'h80,
    ADDR_CARRIER_PHASE_INIT_CTRL   = 8'h84,
    ADDR_CODE_PHASE_INIT_DATA_0    = 8'h88,
    ADDR_CODE_PHASE_INIT_CTRL      = 8'h8c,
    ADDR_CODE_FREQ_DATA_0          = 8'h90,
    ADDR_CODE_FREQ_CTRL            = 8'h94,
    ADDR_SAMPLE_RATE_DATA_0        = 8'h98,
    ADDR_SAMPLE_RATE_CTRL          = 8'h9c,
    ADDR_CODE_LENGTH_DATA_0        = 8'ha0,
    ADDR_CODE_LENGTH_CTRL          = 8'ha4,
    ADDR_CORRELATOR_SPACING_DATA_0 = 8'ha8,
    ADDR_CORRELATOR_SPACING_CTRL   = 8'hac,
    WRIDLE                         = 2'd0,
    WRDATA                         = 2'd1,
    WRRESP                         = 2'd2,
    WRRESET                        = 2'd3,
    RDIDLE                         = 2'd0,
    RDDATA                         = 2'd1,
    RDRESET                        = 2'd2,
    ADDR_BITS                = 8;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [C_S_AXI_DATA_WIDTH-1:0] wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [C_S_AXI_DATA_WIDTH-1:0] rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // internal registers
    reg                           int_ap_idle = 1'b0;
    reg                           int_ap_ready = 1'b0;
    wire                          task_ap_ready;
    reg                           int_ap_done = 1'b0;
    wire                          task_ap_done;
    reg                           int_task_ap_done = 1'b0;
    reg                           int_ap_start = 1'b0;
    reg                           int_interrupt = 1'b0;
    reg                           int_auto_restart = 1'b0;
    reg                           auto_restart_status = 1'b0;
    wire                          auto_restart_done;
    reg                           int_gie = 1'b0;
    reg  [1:0]                    int_ier = 2'b0;
    reg  [1:0]                    int_isr = 2'b0;
    reg                           int_corr_E_I_ap_vld;
    reg  [31:0]                   int_corr_E_I = 'b0;
    reg                           int_corr_E_Q_ap_vld;
    reg  [31:0]                   int_corr_E_Q = 'b0;
    reg                           int_corr_P_I_ap_vld;
    reg  [31:0]                   int_corr_P_I = 'b0;
    reg                           int_corr_P_Q_ap_vld;
    reg  [31:0]                   int_corr_P_Q = 'b0;
    reg                           int_corr_L_I_ap_vld;
    reg  [31:0]                   int_corr_L_I = 'b0;
    reg                           int_corr_L_Q_ap_vld;
    reg  [31:0]                   int_corr_L_Q = 'b0;
    reg  [31:0]                   int_num_samples = 'b0;
    reg  [31:0]                   int_carrier_freq = 'b0;
    reg  [31:0]                   int_carrier_phase_init = 'b0;
    reg  [31:0]                   int_code_phase_init = 'b0;
    reg  [31:0]                   int_code_freq = 'b0;
    reg  [31:0]                   int_sample_rate = 'b0;
    reg  [31:0]                   int_code_length = 'b0;
    reg  [31:0]                   int_correlator_spacing = 'b0;

//------------------------Instantiation------------------


//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA);
assign BVALID  = (wstate == WRRESP);
assign BRESP   = 2'b00;  // OKAY
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (WVALID)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY & BVALID)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= {AWADDR[ADDR_BITS-1:2], {2{1'b0}}};
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA);
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 'b0;
            case (raddr)
                ADDR_AP_CTRL: begin
                    rdata[0] <= int_ap_start;
                    rdata[1] <= int_task_ap_done;
                    rdata[2] <= int_ap_idle;
                    rdata[3] <= int_ap_ready;
                    rdata[7] <= int_auto_restart;
                    rdata[9] <= int_interrupt;
                end
                ADDR_GIE: begin
                    rdata <= int_gie;
                end
                ADDR_IER: begin
                    rdata <= int_ier;
                end
                ADDR_ISR: begin
                    rdata <= int_isr;
                end
                ADDR_CORR_E_I_DATA_0: begin
                    rdata <= int_corr_E_I[31:0];
                end
                ADDR_CORR_E_I_CTRL: begin
                    rdata[0] <= int_corr_E_I_ap_vld;
                end
                ADDR_CORR_E_Q_DATA_0: begin
                    rdata <= int_corr_E_Q[31:0];
                end
                ADDR_CORR_E_Q_CTRL: begin
                    rdata[0] <= int_corr_E_Q_ap_vld;
                end
                ADDR_CORR_P_I_DATA_0: begin
                    rdata <= int_corr_P_I[31:0];
                end
                ADDR_CORR_P_I_CTRL: begin
                    rdata[0] <= int_corr_P_I_ap_vld;
                end
                ADDR_CORR_P_Q_DATA_0: begin
                    rdata <= int_corr_P_Q[31:0];
                end
                ADDR_CORR_P_Q_CTRL: begin
                    rdata[0] <= int_corr_P_Q_ap_vld;
                end
                ADDR_CORR_L_I_DATA_0: begin
                    rdata <= int_corr_L_I[31:0];
                end
                ADDR_CORR_L_I_CTRL: begin
                    rdata[0] <= int_corr_L_I_ap_vld;
                end
                ADDR_CORR_L_Q_DATA_0: begin
                    rdata <= int_corr_L_Q[31:0];
                end
                ADDR_CORR_L_Q_CTRL: begin
                    rdata[0] <= int_corr_L_Q_ap_vld;
                end
                ADDR_NUM_SAMPLES_DATA_0: begin
                    rdata <= int_num_samples[31:0];
                end
                ADDR_CARRIER_FREQ_DATA_0: begin
                    rdata <= int_carrier_freq[31:0];
                end
                ADDR_CARRIER_PHASE_INIT_DATA_0: begin
                    rdata <= int_carrier_phase_init[31:0];
                end
                ADDR_CODE_PHASE_INIT_DATA_0: begin
                    rdata <= int_code_phase_init[31:0];
                end
                ADDR_CODE_FREQ_DATA_0: begin
                    rdata <= int_code_freq[31:0];
                end
                ADDR_SAMPLE_RATE_DATA_0: begin
                    rdata <= int_sample_rate[31:0];
                end
                ADDR_CODE_LENGTH_DATA_0: begin
                    rdata <= int_code_length[31:0];
                end
                ADDR_CORRELATOR_SPACING_DATA_0: begin
                    rdata <= int_correlator_spacing[31:0];
                end
            endcase
        end
    end
end


//------------------------Register logic-----------------
assign interrupt          = int_interrupt;
assign ap_start           = int_ap_start;
assign task_ap_done       = (ap_done && !auto_restart_status) || auto_restart_done;
assign task_ap_ready      = ap_ready && !int_auto_restart;
assign auto_restart_done  = auto_restart_status && (ap_idle && !int_ap_idle);
assign num_samples        = int_num_samples;
assign carrier_freq       = int_carrier_freq;
assign carrier_phase_init = int_carrier_phase_init;
assign code_phase_init    = int_code_phase_init;
assign code_freq          = int_code_freq;
assign sample_rate        = int_sample_rate;
assign code_length        = int_code_length;
assign correlator_spacing = int_correlator_spacing;
// int_interrupt
always @(posedge ACLK) begin
    if (ARESET)
        int_interrupt <= 1'b0;
    else if (ACLK_EN) begin
        if (int_gie && (|int_isr))
            int_interrupt <= 1'b1;
        else
            int_interrupt <= 1'b0;
    end
end

// int_ap_start
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_start <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_AP_CTRL && WSTRB[0] && WDATA[0])
            int_ap_start <= 1'b1;
        else if (ap_ready)
            int_ap_start <= int_auto_restart; // clear on handshake/auto restart
    end
end

// int_ap_done
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_done <= 1'b0;
    else if (ACLK_EN) begin
            int_ap_done <= ap_done;
    end
end

// int_task_ap_done
always @(posedge ACLK) begin
    if (ARESET)
        int_task_ap_done <= 1'b0;
    else if (ACLK_EN) begin
        if (task_ap_done)
            int_task_ap_done <= 1'b1;
        else if (ar_hs && raddr == ADDR_AP_CTRL)
            int_task_ap_done <= 1'b0; // clear on read
    end
end

// int_ap_idle
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_idle <= 1'b0;
    else if (ACLK_EN) begin
            int_ap_idle <= ap_idle;
    end
end

// int_ap_ready
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_ready <= 1'b0;
    else if (ACLK_EN) begin
        if (task_ap_ready)
            int_ap_ready <= 1'b1;
        else if (ar_hs && raddr == ADDR_AP_CTRL)
            int_ap_ready <= 1'b0;
    end
end

// int_auto_restart
always @(posedge ACLK) begin
    if (ARESET)
        int_auto_restart <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_AP_CTRL && WSTRB[0])
            int_auto_restart <= WDATA[7];
    end
end

// auto_restart_status
always @(posedge ACLK) begin
    if (ARESET)
        auto_restart_status <= 1'b0;
    else if (ACLK_EN) begin
        if (int_auto_restart)
            auto_restart_status <= 1'b1;
        else if (ap_idle)
            auto_restart_status <= 1'b0;
    end
end

// int_gie
always @(posedge ACLK) begin
    if (ARESET)
        int_gie <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_GIE && WSTRB[0])
            int_gie <= WDATA[0];
    end
end

// int_ier
always @(posedge ACLK) begin
    if (ARESET)
        int_ier <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_IER && WSTRB[0])
            int_ier <= WDATA[1:0];
    end
end

// int_isr[0]
always @(posedge ACLK) begin
    if (ARESET)
        int_isr[0] <= 1'b0;
    else if (ACLK_EN) begin
        if (int_ier[0] & ap_done)
            int_isr[0] <= 1'b1;
        else if (w_hs && waddr == ADDR_ISR && WSTRB[0])
            int_isr[0] <= int_isr[0] ^ WDATA[0]; // toggle on write
    end
end

// int_isr[1]
always @(posedge ACLK) begin
    if (ARESET)
        int_isr[1] <= 1'b0;
    else if (ACLK_EN) begin
        if (int_ier[1] & ap_ready)
            int_isr[1] <= 1'b1;
        else if (w_hs && waddr == ADDR_ISR && WSTRB[0])
            int_isr[1] <= int_isr[1] ^ WDATA[1]; // toggle on write
    end
end

// int_corr_E_I
always @(posedge ACLK) begin
    if (ARESET)
        int_corr_E_I <= 0;
    else if (ACLK_EN) begin
        if (corr_E_I_ap_vld)
            int_corr_E_I <= corr_E_I;
    end
end

// int_corr_E_I_ap_vld
always @(posedge ACLK) begin
    if (ARESET)
        int_corr_E_I_ap_vld <= 1'b0;
    else if (ACLK_EN) begin
        if (corr_E_I_ap_vld)
            int_corr_E_I_ap_vld <= 1'b1;
        else if (ar_hs && raddr == ADDR_CORR_E_I_CTRL)
            int_corr_E_I_ap_vld <= 1'b0; // clear on read
    end
end

// int_corr_E_Q
always @(posedge ACLK) begin
    if (ARESET)
        int_corr_E_Q <= 0;
    else if (ACLK_EN) begin
        if (corr_E_Q_ap_vld)
            int_corr_E_Q <= corr_E_Q;
    end
end

// int_corr_E_Q_ap_vld
always @(posedge ACLK) begin
    if (ARESET)
        int_corr_E_Q_ap_vld <= 1'b0;
    else if (ACLK_EN) begin
        if (corr_E_Q_ap_vld)
            int_corr_E_Q_ap_vld <= 1'b1;
        else if (ar_hs && raddr == ADDR_CORR_E_Q_CTRL)
            int_corr_E_Q_ap_vld <= 1'b0; // clear on read
    end
end

// int_corr_P_I
always @(posedge ACLK) begin
    if (ARESET)
        int_corr_P_I <= 0;
    else if (ACLK_EN) begin
        if (corr_P_I_ap_vld)
            int_corr_P_I <= corr_P_I;
    end
end

// int_corr_P_I_ap_vld
always @(posedge ACLK) begin
    if (ARESET)
        int_corr_P_I_ap_vld <= 1'b0;
    else if (ACLK_EN) begin
        if (corr_P_I_ap_vld)
            int_corr_P_I_ap_vld <= 1'b1;
        else if (ar_hs && raddr == ADDR_CORR_P_I_CTRL)
            int_corr_P_I_ap_vld <= 1'b0; // clear on read
    end
end

// int_corr_P_Q
always @(posedge ACLK) begin
    if (ARESET)
        int_corr_P_Q <= 0;
    else if (ACLK_EN) begin
        if (corr_P_Q_ap_vld)
            int_corr_P_Q <= corr_P_Q;
    end
end

// int_corr_P_Q_ap_vld
always @(posedge ACLK) begin
    if (ARESET)
        int_corr_P_Q_ap_vld <= 1'b0;
    else if (ACLK_EN) begin
        if (corr_P_Q_ap_vld)
            int_corr_P_Q_ap_vld <= 1'b1;
        else if (ar_hs && raddr == ADDR_CORR_P_Q_CTRL)
            int_corr_P_Q_ap_vld <= 1'b0; // clear on read
    end
end

// int_corr_L_I
always @(posedge ACLK) begin
    if (ARESET)
        int_corr_L_I <= 0;
    else if (ACLK_EN) begin
        if (corr_L_I_ap_vld)
            int_corr_L_I <= corr_L_I;
    end
end

// int_corr_L_I_ap_vld
always @(posedge ACLK) begin
    if (ARESET)
        int_corr_L_I_ap_vld <= 1'b0;
    else if (ACLK_EN) begin
        if (corr_L_I_ap_vld)
            int_corr_L_I_ap_vld <= 1'b1;
        else if (ar_hs && raddr == ADDR_CORR_L_I_CTRL)
            int_corr_L_I_ap_vld <= 1'b0; // clear on read
    end
end

// int_corr_L_Q
always @(posedge ACLK) begin
    if (ARESET)
        int_corr_L_Q <= 0;
    else if (ACLK_EN) begin
        if (corr_L_Q_ap_vld)
            int_corr_L_Q <= corr_L_Q;
    end
end

// int_corr_L_Q_ap_vld
always @(posedge ACLK) begin
    if (ARESET)
        int_corr_L_Q_ap_vld <= 1'b0;
    else if (ACLK_EN) begin
        if (corr_L_Q_ap_vld)
            int_corr_L_Q_ap_vld <= 1'b1;
        else if (ar_hs && raddr == ADDR_CORR_L_Q_CTRL)
            int_corr_L_Q_ap_vld <= 1'b0; // clear on read
    end
end

// int_num_samples[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_num_samples[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_NUM_SAMPLES_DATA_0)
            int_num_samples[31:0] <= (WDATA[31:0] & wmask) | (int_num_samples[31:0] & ~wmask);
    end
end

// int_carrier_freq[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_carrier_freq[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CARRIER_FREQ_DATA_0)
            int_carrier_freq[31:0] <= (WDATA[31:0] & wmask) | (int_carrier_freq[31:0] & ~wmask);
    end
end

// int_carrier_phase_init[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_carrier_phase_init[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CARRIER_PHASE_INIT_DATA_0)
            int_carrier_phase_init[31:0] <= (WDATA[31:0] & wmask) | (int_carrier_phase_init[31:0] & ~wmask);
    end
end

// int_code_phase_init[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_code_phase_init[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CODE_PHASE_INIT_DATA_0)
            int_code_phase_init[31:0] <= (WDATA[31:0] & wmask) | (int_code_phase_init[31:0] & ~wmask);
    end
end

// int_code_freq[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_code_freq[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CODE_FREQ_DATA_0)
            int_code_freq[31:0] <= (WDATA[31:0] & wmask) | (int_code_freq[31:0] & ~wmask);
    end
end

// int_sample_rate[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_sample_rate[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_SAMPLE_RATE_DATA_0)
            int_sample_rate[31:0] <= (WDATA[31:0] & wmask) | (int_sample_rate[31:0] & ~wmask);
    end
end

// int_code_length[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_code_length[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CODE_LENGTH_DATA_0)
            int_code_length[31:0] <= (WDATA[31:0] & wmask) | (int_code_length[31:0] & ~wmask);
    end
end

// int_correlator_spacing[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_correlator_spacing[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CORRELATOR_SPACING_DATA_0)
            int_correlator_spacing[31:0] <= (WDATA[31:0] & wmask) | (int_correlator_spacing[31:0] & ~wmask);
    end
end

//synthesis translate_off
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (int_gie & ~int_isr[0] & int_ier[0] & ap_done)
            $display ("// Interrupt Monitor : interrupt for ap_done detected @ \"%0t\"", $time);
        if (int_gie & ~int_isr[1] & int_ier[1] & ap_ready)
            $display ("// Interrupt Monitor : interrupt for ap_ready detected @ \"%0t\"", $time);
    end
end
//synthesis translate_on

//------------------------Memory logic-------------------

endmodule
