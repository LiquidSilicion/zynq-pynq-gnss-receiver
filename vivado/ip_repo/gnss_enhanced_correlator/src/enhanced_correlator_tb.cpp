#include "enhanced_correlator.h"
#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#define NUM_SAMPLES 1023
#define CODE_LENGTH 1023

int main() {
    printf("🧪 Enhanced Correlator C Simulation Testbench (DC Carrier)\n");
    printf("==========================================================\n\n");
    
    // Allocate arrays
    float signal_I[NUM_SAMPLES];
    float signal_Q[NUM_SAMPLES];
    float prn_code[CODE_LENGTH];
    
    float corr_E_I, corr_E_Q;
    float corr_P_I, corr_P_Q;
    float corr_L_I, corr_L_Q;
    
    // Generate simple PRN code (alternating +1/-1 for testing)
    for (int i = 0; i < CODE_LENGTH; i++) {
        prn_code[i] = (i % 2 == 0) ? 1.0f : -1.0f;
    }
    
    // SIMPLIFIED: Use 0 Hz carrier (DC) to isolate code phase logic
    float carrier_freq = 0.0f;          // 0 Hz (DC)
    float sample_rate = 1023000.0f;     // 1.023 MHz
    float code_freq = 1023000.0f;       // 1.023 MHz
    
    printf("📊 Generating test signal...\n");
    printf("   Carrier frequency: %.1f Hz (DC)\n", carrier_freq);
    printf("   Sample rate: %.1f Hz\n", sample_rate);
    printf("   Samples: %d\n", NUM_SAMPLES);
    
    for (int i = 0; i < NUM_SAMPLES; i++) {
        int chip_idx = i % CODE_LENGTH; // Exactly 1 chip per sample
        
        // DC signal: just the PRN code scaled by 2.0
        signal_I[i] = 2.0f * prn_code[chip_idx];
        signal_Q[i] = 0.0f; // No Q component for DC
    }
    
    // Test 1: Perfect alignment (code_phase = 0)
    printf("\n🎯 TEST 1: Perfect Alignment\n");
    printf("   Doppler: %.1f Hz, Code Phase: 0.0 chips\n", carrier_freq);
    
    enhanced_correlator(
        signal_I, signal_Q,
        &corr_E_I, &corr_E_Q,
        &corr_P_I, &corr_P_Q,
        &corr_L_I, &corr_L_Q,
        NUM_SAMPLES,
        carrier_freq,      // carrier_freq
        0.0f,              // carrier_phase_init
        0.0f,              // code_phase_init (perfect alignment)
        code_freq,         // code_freq
        sample_rate,       // sample_rate
        CODE_LENGTH,       // code_length
        0.5f,              // correlator_spacing (0.5 chips)
        prn_code
    );
    
    float power_P = corr_P_I * corr_P_I + corr_P_Q * corr_P_Q;
    float power_E = corr_E_I * corr_E_I + corr_E_Q * corr_E_Q;
    float power_L = corr_L_I * corr_L_I + corr_L_Q * corr_L_Q;
    
    printf("\n   Results:\n");
    printf("   Early:  I=%8.2f, Q=%8.2f, Power=%10.2f\n", corr_E_I, corr_E_Q, power_E);
    printf("   Prompt: I=%8.2f, Q=%8.2f, Power=%10.2f\n", corr_P_I, corr_P_Q, power_P);
    printf("   Late:   I=%8.2f, Q=%8.2f, Power=%10.2f\n", corr_L_I, corr_L_Q, power_L);
    
    // Expected: Prompt power should be ~2000^2 = 4,000,000
    if (power_P > 3000000.0f) {
        printf("\n   ✅ PASS: Prompt correlation strong (power > 3M)\n");
    } else {
        printf("\n   ❌ FAIL: Prompt correlation weak (power = %.2f)\n", power_P);
    }
    
    // Test 2: Code phase offset (should see triangular correlation peak)
    printf("\n🎯 TEST 2: Code Phase Offset (0.5 chips off)\n");
    printf("   Code Phase: 0.5 chips (true: 0.0 chips)\n");
    
    enhanced_correlator(
        signal_I, signal_Q,
        &corr_E_I, &corr_E_Q,
        &corr_P_I, &corr_P_Q,
        &corr_L_I, &corr_L_Q,
        NUM_SAMPLES,
        carrier_freq,
        0.0f,
        0.5f,  // 0.5 chips off
        code_freq,
        sample_rate,
        CODE_LENGTH,
        0.5f,
        prn_code
    );
    
    float power_P_offset = corr_P_I * corr_P_I + corr_P_Q * corr_P_Q;
    float power_E_offset = corr_E_I * corr_E_I + corr_E_Q * corr_E_Q;
    float power_L_offset = corr_L_I * corr_L_I + corr_L_Q * corr_L_Q;
    
    printf("\n   Results:\n");
    printf("   Early:  I=%8.2f, Q=%8.2f, Power=%10.2f\n", corr_E_I, corr_E_Q, power_E_offset);
    printf("   Prompt: I=%8.2f, Q=%8.2f, Power=%10.2f\n", corr_P_I, corr_P_Q, power_P_offset);
    printf("   Late:   I=%8.2f, Q=%8.2f, Power=%10.2f\n", corr_L_I, corr_L_Q, power_L_offset);
    
    // With 0.5 chip offset, Early and Late should be ~half of Prompt, and Prompt should be near 0
    if (power_P_offset < power_P * 0.1f && power_E_offset > power_P * 0.2f) {
        printf("\n   ✅ PASS: Code offset creates triangular peak (Early/Late > Prompt)\n");
    } else {
        printf("\n   ⚠️  WARNING: Triangular peak not as expected\n");
    }
    
    printf("\n==========================================================\n");
    printf("🏁 Testbench Complete\n");
    printf("==========================================================\n");
    
    return 0;
}