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

#define CONTROL_ADDR_AP_CTRL                 0x00
#define CONTROL_ADDR_GIE                     0x04
#define CONTROL_ADDR_IER                     0x08
#define CONTROL_ADDR_ISR                     0x0c
#define CONTROL_ADDR_CORR_E_I_DATA           0x10
#define CONTROL_BITS_CORR_E_I_DATA           32
#define CONTROL_ADDR_CORR_E_I_CTRL           0x14
#define CONTROL_ADDR_CORR_E_Q_DATA           0x20
#define CONTROL_BITS_CORR_E_Q_DATA           32
#define CONTROL_ADDR_CORR_E_Q_CTRL           0x24
#define CONTROL_ADDR_CORR_P_I_DATA           0x30
#define CONTROL_BITS_CORR_P_I_DATA           32
#define CONTROL_ADDR_CORR_P_I_CTRL           0x34
#define CONTROL_ADDR_CORR_P_Q_DATA           0x40
#define CONTROL_BITS_CORR_P_Q_DATA           32
#define CONTROL_ADDR_CORR_P_Q_CTRL           0x44
#define CONTROL_ADDR_CORR_L_I_DATA           0x50
#define CONTROL_BITS_CORR_L_I_DATA           32
#define CONTROL_ADDR_CORR_L_I_CTRL           0x54
#define CONTROL_ADDR_CORR_L_Q_DATA           0x60
#define CONTROL_BITS_CORR_L_Q_DATA           32
#define CONTROL_ADDR_CORR_L_Q_CTRL           0x64
#define CONTROL_ADDR_NUM_SAMPLES_DATA        0x70
#define CONTROL_BITS_NUM_SAMPLES_DATA        32
#define CONTROL_ADDR_CARRIER_FREQ_DATA       0x78
#define CONTROL_BITS_CARRIER_FREQ_DATA       32
#define CONTROL_ADDR_CARRIER_PHASE_INIT_DATA 0x80
#define CONTROL_BITS_CARRIER_PHASE_INIT_DATA 32
#define CONTROL_ADDR_CODE_PHASE_INIT_DATA    0x88
#define CONTROL_BITS_CODE_PHASE_INIT_DATA    32
#define CONTROL_ADDR_CODE_FREQ_DATA          0x90
#define CONTROL_BITS_CODE_FREQ_DATA          32
#define CONTROL_ADDR_SAMPLE_RATE_DATA        0x98
#define CONTROL_BITS_SAMPLE_RATE_DATA        32
#define CONTROL_ADDR_CODE_LENGTH_DATA        0xa0
#define CONTROL_BITS_CODE_LENGTH_DATA        32
#define CONTROL_ADDR_CORRELATOR_SPACING_DATA 0xa8
#define CONTROL_BITS_CORRELATOR_SPACING_DATA 32
