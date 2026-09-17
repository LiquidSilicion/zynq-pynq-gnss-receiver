#include "gnss_correlator.h"
#include <ap_fixed.h> // Xilinx arbitrary precision fixed-point library

// 18-bit fixed-point: 2 bits integer, 16 bits fraction. 
// Perfect for normalized GNSS signals (-2.0 to +1.999)
typedef ap_fixed<18, 2> fixed_t; 

void gnss_correlator(
    const float* signal_I, const float* signal_Q,
    const float* code_I, const float* code_Q,
    float* corr_I, float* corr_Q,
    int num_samples
) {
    // --- AXI INTERFACE PRAGMAS ---
    // m_axi: Connects large arrays to external memory (DDR/BRAM) via AXI4 Master
    #pragma HLS INTERFACE m_axi port=signal_I offset=slave bundle=gmem0
    #pragma HLS INTERFACE m_axi port=signal_Q offset=slave bundle=gmem0
    #pragma HLS INTERFACE m_axi port=code_I  offset=slave bundle=gmem1
    #pragma HLS INTERFACE m_axi port=code_Q  offset=slave bundle=gmem1
    
    // s_axilite: Connects scalars and control signals to the ARM CPU via AXI4-Lite
    #pragma HLS INTERFACE s_axilite port=corr_I bundle=control
    #pragma HLS INTERFACE s_axilite port=corr_Q bundle=control
    #pragma HLS INTERFACE s_axilite port=num_samples bundle=control
    #pragma HLS INTERFACE s_axilite port=return bundle=control

    fixed_t acc_I = 0;
    fixed_t acc_Q = 0;

    for (int i = 0; i < num_samples; i++) {
        #pragma HLS PIPELINE II=1
        
        // Cast incoming floats to fixed-point for ultra-fast hardware math
        fixed_t a = signal_I[i];
        fixed_t b = signal_Q[i];
        fixed_t c = code_I[i];
        fixed_t d = code_Q[i];

        // Complex multiply-accumulate in fixed-point
        acc_I += (a * c) - (b * d);
        acc_Q += (a * d) + (b * c);
    }

    // Cast the final accumulated result back to float for the output port
    *corr_I = (float)acc_I;
    *corr_Q = (float)acc_Q;
}