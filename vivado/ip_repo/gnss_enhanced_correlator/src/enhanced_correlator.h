#ifndef ENHANCED_CORRELATOR_H
#define ENHANCED_CORRELATOR_H

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
);

#endif