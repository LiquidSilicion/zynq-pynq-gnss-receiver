dict set slaves control {ports {corr_E_I {type o_ap_vld width 32} corr_E_Q {type o_ap_vld width 32} corr_P_I {type o_ap_vld width 32} corr_P_Q {type o_ap_vld width 32} corr_L_I {type o_ap_vld width 32} corr_L_Q {type o_ap_vld width 32} num_samples {type i_ap_none width 32} carrier_freq {type i_ap_none width 32} carrier_phase_init {type i_ap_none width 32} code_phase_init {type i_ap_none width 32} code_freq {type i_ap_none width 32} sample_rate {type i_ap_none width 32} code_length {type i_ap_none width 32} correlator_spacing {type i_ap_none width 32} ap_start {type ap_ctrl width 1} ap_done {type ap_ctrl width 1} ap_ready {type ap_ctrl width 1} ap_idle {type ap_ctrl width 1}} mems {} has_ctrl 1}
set datawidth 32
set addrwidth 64
set intr_clr_mode TOW
