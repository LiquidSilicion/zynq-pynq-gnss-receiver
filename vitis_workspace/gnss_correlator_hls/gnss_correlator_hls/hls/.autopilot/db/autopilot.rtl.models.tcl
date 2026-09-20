set SynModuleInfo {
  {SRCNAME gnss_correlator MODELNAME gnss_correlator RTLNAME gnss_correlator IS_TOP 1
    SUBMODULES {
      {MODELNAME gnss_correlator_faddfsub_32ns_32ns_32_5_full_dsp_1 RTLNAME gnss_correlator_faddfsub_32ns_32ns_32_5_full_dsp_1 BINDTYPE op TYPE fsub IMPL fulldsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME gnss_correlator_fadd_32ns_32ns_32_2_full_dsp_1 RTLNAME gnss_correlator_fadd_32ns_32ns_32_2_full_dsp_1 BINDTYPE op TYPE fadd IMPL fulldsp LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME gnss_correlator_fmul_32ns_32ns_32_4_max_dsp_1 RTLNAME gnss_correlator_fmul_32ns_32ns_32_4_max_dsp_1 BINDTYPE op TYPE fmul IMPL maxdsp LATENCY 3 ALLOW_PRAGMA 1}
      {MODELNAME gnss_correlator_gmem0_m_axi RTLNAME gnss_correlator_gmem0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME gnss_correlator_gmem1_m_axi RTLNAME gnss_correlator_gmem1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME gnss_correlator_control_s_axi RTLNAME gnss_correlator_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
      {MODELNAME gnss_correlator_control_r_s_axi RTLNAME gnss_correlator_control_r_s_axi BINDTYPE interface TYPE interface_s_axilite}
      {MODELNAME gnss_correlator_flow_control_loop_delay_pipe RTLNAME gnss_correlator_flow_control_loop_delay_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME gnss_correlator_flow_control_loop_delay_pipe_U}
    }
  }
}
