#ifndef GNSS_CORRELATOR_H
#define GNSS_CORRELATOR_H

// Top-level function for the GNSS Correlator
void gnss_correlator(
    const float* signal_I, const float* signal_Q,
    const float* code_I, const float* code_Q,
    float* corr_I, float* corr_Q,
    int num_samples
);

#endif