#include "enhanced_correlator.h"
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846f
#endif
#define TWO_PI 6.28318530717958647692f

void enhanced_correlator(
    const float* signal_I,
    const float* signal_Q,
    float* corr_E_I, float* corr_E_Q,
    float* corr_P_I, float* corr_P_Q,
    float* corr_L_I, float* corr_L_Q,
    int num_samples,
    float carrier_freq,
    float carrier_phase_init,
    float code_phase_init,
    float code_freq,
    float sample_rate,
    int code_length,
    float correlator_spacing,
    const float* prn_code
) {
    // AXI4 Master interfaces
    #pragma HLS INTERFACE m_axi port=signal_I offset=slave bundle=gmem0 depth=100000
    #pragma HLS INTERFACE m_axi port=signal_Q offset=slave bundle=gmem0 depth=100000
    #pragma HLS INTERFACE m_axi port=prn_code offset=slave bundle=gmem1 depth=4092
    
    // AXI4-Lite slave interface
    #pragma HLS INTERFACE s_axilite port=corr_E_I bundle=control
    #pragma HLS INTERFACE s_axilite port=corr_E_Q bundle=control
    #pragma HLS INTERFACE s_axilite port=corr_P_I bundle=control
    #pragma HLS INTERFACE s_axilite port=corr_P_Q bundle=control
    #pragma HLS INTERFACE s_axilite port=corr_L_I bundle=control
    #pragma HLS INTERFACE s_axilite port=corr_L_Q bundle=control
    #pragma HLS INTERFACE s_axilite port=num_samples bundle=control
    #pragma HLS INTERFACE s_axilite port=carrier_freq bundle=control
    #pragma HLS INTERFACE s_axilite port=carrier_phase_init bundle=control
    #pragma HLS INTERFACE s_axilite port=code_phase_init bundle=control
    #pragma HLS INTERFACE s_axilite port=code_freq bundle=control
    #pragma HLS INTERFACE s_axilite port=sample_rate bundle=control
    #pragma HLS INTERFACE s_axilite port=code_length bundle=control
    #pragma HLS INTERFACE s_axilite port=correlator_spacing bundle=control
    #pragma HLS INTERFACE s_axilite port=return bundle=control
    
    // Compute phase increments
    float carrier_phase_inc = TWO_PI * carrier_freq / sample_rate;
    float code_phase_inc = code_freq / sample_rate;
    float el_spacing_samples = correlator_spacing * sample_rate / code_freq;
    
    // Initialize accumulators as native float (perfectly accurate for this scale)
    float acc_E_I = 0.0f, acc_E_Q = 0.0f;
    float acc_P_I = 0.0f, acc_P_Q = 0.0f;
    float acc_L_I = 0.0f, acc_L_Q = 0.0f;
    
    float carrier_phase = carrier_phase_init;
    float code_phase = code_phase_init;
    
    // Main correlation loop
    for (int i = 0; i < num_samples; i++) {
        #pragma HLS PIPELINE II=1
        
        // Read input samples
        float sig_I = signal_I[i];
        float sig_Q = signal_Q[i];
        
        // Carrier NCO: normalize phase to [0, 2π)
        float phase = carrier_phase;
        while (phase >= TWO_PI) phase -= TWO_PI;
        while (phase < 0) phase += TWO_PI;
        
        float cos_val = cosf(phase);
        float sin_val = sinf(phase);
        
        // Carrier wipeoff
        float mixed_I = sig_I * cos_val - sig_Q * sin_val;
        float mixed_Q = sig_I * sin_val + sig_Q * cos_val;
        
        // Code phase calculations
        float prompt_phase = code_phase;
        float early_phase = code_phase - el_spacing_samples;
        float late_phase = code_phase + el_spacing_samples;
        
        // Wrap phases
        while (early_phase < 0) early_phase += code_length;
        while (late_phase >= code_length) late_phase -= code_length;
        while (prompt_phase >= code_length) prompt_phase -= code_length;
        
        // Get code values
        int prompt_idx = (int)prompt_phase;
        int early_idx = (int)early_phase;
        int late_idx = (int)late_phase;
        
        float prompt_code = prn_code[prompt_idx];
        float early_code = prn_code[early_idx];
        float late_code = prn_code[late_idx];
        
        // Correlate (No ap_fixed ambiguity!)
        acc_E_I += mixed_I * early_code;
        acc_E_Q += mixed_Q * early_code;
        acc_P_I += mixed_I * prompt_code;
        acc_P_Q += mixed_Q * prompt_code;
        acc_L_I += mixed_I * late_code;
        acc_L_Q += mixed_Q * late_code;
        
        // Update phases
        carrier_phase += carrier_phase_inc;
        code_phase += code_phase_inc;
    }
    
    // Write results
    *corr_E_I = acc_E_I;
    *corr_E_Q = acc_E_Q;
    *corr_P_I = acc_P_I;
    *corr_P_Q = acc_P_Q;
    *corr_L_I = acc_L_I;
    *corr_L_Q = acc_L_Q;
}