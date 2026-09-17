# Open a new HLS project
open_project gnss_correlator_hls_prj

# Set the top function
set_top gnss_correlator

# Add source files
add_files gnss_correlator.cpp
add_files -tb gnss_correlator_tb.cpp

# Open a solution and configure it
open_solution "solution1" -flow_target vivado

# Target the ZedBoard (Zynq-7020)
set_part {xc7z020clg484-1}

# Set clock period to 10ns (100 MHz)
create_clock -period 10 -name default

# Run C Simulation
csim_design

# Run C Synthesis
csynth_design

# Exit
exit
