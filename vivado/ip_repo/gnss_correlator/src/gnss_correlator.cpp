#include "gnss_correlator.h"

void gnss_correlator(
    const float* signal_I, const float* signal_Q,
    const float* code_I, const float* code_Q,
    float* corr_I, float* corr_Q,
    int num_samples
) {
    #pragma HLS INTERFACE m_axi port=signal_I offset=slave bundle=gmem0
    #pragma HLS INTERFACE m_axi port=signal_Q offset=slave bundle=gmem0
    #pragma HLS INTERFACE m_axi port=code_I  offset=slave bundle=gmem1
    #pragma HLS INTERFACE m_axi port=code_Q  offset=slave bundle=gmem1
    
    #pragma HLS INTERFACE s_axilite port=corr_I bundle=control
    #pragma HLS INTERFACE s_axilite port=corr_Q bundle=control
    #pragma HLS INTERFACE s_axilite port=num_samples bundle=control
    #pragma HLS INTERFACE s_axilite port=return bundle=control

    // Use native float for accumulation. No ap_fixed conversion bugs!
    float acc_I = 0.0f;
    float acc_Q = 0.0f;

    for (int i = 0; i < num_samples; i++) {
        #pragma HLS PIPELINE II=1
        
        float a = signal_I[i];
        float b = signal_Q[i];
        float c = code_I[i];
        float d = code_Q[i];

        acc_I += (a * c) - (b * d);
        acc_Q += (a * d) + (b * c);
    }

    *corr_I = acc_I;
    *corr_Q = acc_Q;
}