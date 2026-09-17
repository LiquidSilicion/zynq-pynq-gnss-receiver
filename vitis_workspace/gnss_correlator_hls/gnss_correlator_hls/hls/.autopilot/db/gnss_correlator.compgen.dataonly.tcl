# This script segment is generated automatically by AutoPilot

set axilite_register_dict [dict create]
set port_control {
corr_I { 
	dir O
	width 32
	depth 1
	mode ap_vld
	offset 16
	offset_end 23
}
corr_Q { 
	dir O
	width 32
	depth 1
	mode ap_vld
	offset 32
	offset_end 39
}
num_samples { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 48
	offset_end 55
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
code_I { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 40
	offset_end 51
}
code_Q { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 52
	offset_end 63
}
}
dict set axilite_register_dict control_r $port_control_r


