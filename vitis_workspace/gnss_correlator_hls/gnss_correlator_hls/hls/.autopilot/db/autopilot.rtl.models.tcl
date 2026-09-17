set SynModuleInfo {
  {SRCNAME gnss_correlator_Pipeline_VITIS_LOOP_30_1 MODELNAME gnss_correlator_Pipeline_VITIS_LOOP_30_1 RTLNAME gnss_correlator_gnss_correlator_Pipeline_VITIS_LOOP_30_1
    SUBMODULES {
      {MODELNAME gnss_correlator_fpext_32ns_64_2_no_dsp_1 RTLNAME gnss_correlator_fpext_32ns_64_2_no_dsp_1 BINDTYPE op TYPE fpext IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME gnss_correlator_sparsemux_9_3_18_1_1 RTLNAME gnss_correlator_sparsemux_9_3_18_1_1 BINDTYPE op TYPE sparsemux IMPL onehotencoding_realdef}
      {MODELNAME gnss_correlator_mul_18s_18s_34_1_1 RTLNAME gnss_correlator_mul_18s_18s_34_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME gnss_correlator_mac_mulsub_18s_18s_34s_34_4_1 RTLNAME gnss_correlator_mac_mulsub_18s_18s_34s_34_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
      {MODELNAME gnss_correlator_mac_muladd_18s_18s_34s_34_4_1 RTLNAME gnss_correlator_mac_muladd_18s_18s_34s_34_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
      {MODELNAME gnss_correlator_flow_control_loop_pipe_sequential_init RTLNAME gnss_correlator_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME gnss_correlator_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME gnss_correlator MODELNAME gnss_correlator RTLNAME gnss_correlator IS_TOP 1
    SUBMODULES {
      {MODELNAME gnss_correlator_ctlz_18_18_1_1 RTLNAME gnss_correlator_ctlz_18_18_1_1 BINDTYPE op TYPE ctlz IMPL auto}
      {MODELNAME gnss_correlator_gmem0_m_axi RTLNAME gnss_correlator_gmem0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME gnss_correlator_gmem1_m_axi RTLNAME gnss_correlator_gmem1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME gnss_correlator_control_s_axi RTLNAME gnss_correlator_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
      {MODELNAME gnss_correlator_control_r_s_axi RTLNAME gnss_correlator_control_r_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
