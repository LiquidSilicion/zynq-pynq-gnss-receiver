# This script segment is generated automatically by AutoPilot

set axilite_register_dict [dict create]
set port_control {
corr_E_I { 
	dir O
	width 32
	depth 1
	mode ap_vld
	offset 16
	offset_end 23
}
corr_E_Q { 
	dir O
	width 32
	depth 1
	mode ap_vld
	offset 32
	offset_end 39
}
corr_P_I { 
	dir O
	width 32
	depth 1
	mode ap_vld
	offset 48
	offset_end 55
}
corr_P_Q { 
	dir O
	width 32
	depth 1
	mode ap_vld
	offset 64
	offset_end 71
}
corr_L_I { 
	dir O
	width 32
	depth 1
	mode ap_vld
	offset 80
	offset_end 87
}
corr_L_Q { 
	dir O
	width 32
	depth 1
	mode ap_vld
	offset 96
	offset_end 103
}
num_samples { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 112
	offset_end 119
}
carrier_freq { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 120
	offset_end 127
}
carrier_phase_init { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 128
	offset_end 135
}
code_phase_init { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 136
	offset_end 143
}
code_freq { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 144
	offset_end 151
}
sample_rate { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 152
	offset_end 159
}
code_length { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 160
	offset_end 167
}
correlator_spacing { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 168
	offset_end 175
}
ap_start { }
ap_done { }
ap_ready { }
ap_idle { }
interrupt {
}
}
dict set axilite_register_dict control $port_control


set port_control_r {
signal_I { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 16
	offset_end 27
}
signal_Q { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 28
	offset_end 39
}
prn_code { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 40
	offset_end 51
}
}
dict set axilite_register_dict control_r $port_control_r


