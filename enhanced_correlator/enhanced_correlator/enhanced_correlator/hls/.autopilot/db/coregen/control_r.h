// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of signal_I
//        bit 31~0 - signal_I[31:0] (Read/Write)
// 0x14 : Data signal of signal_I
//        bit 31~0 - signal_I[63:32] (Read/Write)
// 0x18 : reserved
// 0x1c : Data signal of signal_Q
//        bit 31~0 - signal_Q[31:0] (Read/Write)
// 0x20 : Data signal of signal_Q
//        bit 31~0 - signal_Q[63:32] (Read/Write)
// 0x24 : reserved
// 0x28 : Data signal of prn_code
//        bit 31~0 - prn_code[31:0] (Read/Write)
// 0x2c : Data signal of prn_code
//        bit 31~0 - prn_code[63:32] (Read/Write)
// 0x30 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define CONTROL_R_ADDR_SIGNAL_I_DATA 0x10
#define CONTROL_R_BITS_SIGNAL_I_DATA 64
#define CONTROL_R_ADDR_SIGNAL_Q_DATA 0x1c
#define CONTROL_R_BITS_SIGNAL_Q_DATA 64
#define CONTROL_R_ADDR_PRN_CODE_DATA 0x28
#define CONTROL_R_BITS_PRN_CODE_DATA 64
