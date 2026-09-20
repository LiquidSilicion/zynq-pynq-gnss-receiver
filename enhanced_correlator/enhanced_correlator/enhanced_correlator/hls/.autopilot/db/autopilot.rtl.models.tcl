set SynModuleInfo {
  {SRCNAME sin_or_cos<float> MODELNAME sin_or_cos_float_s RTLNAME enhanced_correlator_sin_or_cos_float_s
    SUBMODULES {
      {MODELNAME enhanced_correlator_mul_23s_22ns_45_1_1 RTLNAME enhanced_correlator_mul_23s_22ns_45_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME enhanced_correlator_mul_30s_29ns_58_2_1 RTLNAME enhanced_correlator_mul_30s_29ns_58_2_1 BINDTYPE op TYPE mul IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME enhanced_correlator_mul_80s_24ns_80_5_1 RTLNAME enhanced_correlator_mul_80s_24ns_80_5_1 BINDTYPE op TYPE mul IMPL auto LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME enhanced_correlator_sparsemux_17_3_1_1_1 RTLNAME enhanced_correlator_sparsemux_17_3_1_1_1 BINDTYPE op TYPE sparsemux IMPL compactencoding_dontcare}
      {MODELNAME enhanced_correlator_ctlz_30_30_1_1 RTLNAME enhanced_correlator_ctlz_30_30_1_1 BINDTYPE op TYPE ctlz IMPL auto}
      {MODELNAME enhanced_correlator_sparsemux_33_4_1_1_1 RTLNAME enhanced_correlator_sparsemux_33_4_1_1_1 BINDTYPE op TYPE sparsemux IMPL compactencoding_dontcare}
      {MODELNAME enhanced_correlator_mul_15ns_15ns_30_1_1 RTLNAME enhanced_correlator_mul_15ns_15ns_30_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME enhanced_correlator_mul_15ns_15s_30_1_1 RTLNAME enhanced_correlator_mul_15ns_15s_30_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME enhanced_correlator_ctlz_32_32_1_1 RTLNAME enhanced_correlator_ctlz_32_32_1_1 BINDTYPE op TYPE ctlz IMPL auto}
      {MODELNAME enhanced_correlator_sin_or_cos_float_s_ref_4oPi_table_100_ROM_1P_LUTRAM_1R RTLNAME enhanced_correlator_sin_or_cos_float_s_ref_4oPi_table_100_ROM_1P_LUTRAM_1R BINDTYPE storage TYPE rom_1p IMPL lutram LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME enhanced_correlator_sin_or_cos_float_s_second_order_float_sin_cos_K0_ROM_1P_LUTRAM_1R RTLNAME enhanced_correlator_sin_or_cos_float_s_second_order_float_sin_cos_K0_ROM_1P_LUTRAM_1R BINDTYPE storage TYPE rom_1p IMPL lutram LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME enhanced_correlator_sin_or_cos_float_s_second_order_float_sin_cos_K1_ROM_1P_LUTRAM_1R RTLNAME enhanced_correlator_sin_or_cos_float_s_second_order_float_sin_cos_K1_ROM_1P_LUTRAM_1R BINDTYPE storage TYPE rom_1p IMPL lutram LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME enhanced_correlator_sin_or_cos_float_s_second_order_float_sin_cos_K2_ROM_1P_LUTRAM_1R RTLNAME enhanced_correlator_sin_or_cos_float_s_second_order_float_sin_cos_K2_ROM_1P_LUTRAM_1R BINDTYPE storage TYPE rom_1p IMPL lutram LATENCY 2 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME enhanced_correlator MODELNAME enhanced_correlator RTLNAME enhanced_correlator IS_TOP 1
    SUBMODULES {
      {MODELNAME enhanced_correlator_faddfsub_32ns_32ns_32_5_full_dsp_1 RTLNAME enhanced_correlator_faddfsub_32ns_32ns_32_5_full_dsp_1 BINDTYPE op TYPE fadd IMPL fulldsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME enhanced_correlator_fadd_32ns_32ns_32_5_full_dsp_1 RTLNAME enhanced_correlator_fadd_32ns_32ns_32_5_full_dsp_1 BINDTYPE op TYPE fadd IMPL fulldsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME enhanced_correlator_fmul_32ns_32ns_32_4_max_dsp_1 RTLNAME enhanced_correlator_fmul_32ns_32ns_32_4_max_dsp_1 BINDTYPE op TYPE fmul IMPL maxdsp LATENCY 3 ALLOW_PRAGMA 1}
      {MODELNAME enhanced_correlator_fdiv_32ns_32ns_32_16_no_dsp_1 RTLNAME enhanced_correlator_fdiv_32ns_32ns_32_16_no_dsp_1 BINDTYPE op TYPE fdiv IMPL fabric LATENCY 15 ALLOW_PRAGMA 1}
      {MODELNAME enhanced_correlator_sitofp_32ns_32_6_no_dsp_1 RTLNAME enhanced_correlator_sitofp_32ns_32_6_no_dsp_1 BINDTYPE op TYPE sitofp IMPL auto LATENCY 5 ALLOW_PRAGMA 1}
      {MODELNAME enhanced_correlator_fcmp_32ns_32ns_1_2_no_dsp_1 RTLNAME enhanced_correlator_fcmp_32ns_32ns_1_2_no_dsp_1 BINDTYPE op TYPE fcmp IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME enhanced_correlator_gmem0_m_axi RTLNAME enhanced_correlator_gmem0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME enhanced_correlator_gmem1_m_axi RTLNAME enhanced_correlator_gmem1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME enhanced_correlator_control_s_axi RTLNAME enhanced_correlator_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
      {MODELNAME enhanced_correlator_control_r_s_axi RTLNAME enhanced_correlator_control_r_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
