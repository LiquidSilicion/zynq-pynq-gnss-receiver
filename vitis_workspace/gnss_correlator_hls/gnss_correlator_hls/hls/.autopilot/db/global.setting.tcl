
set TopModule "gnss_correlator"
set ClockPeriod 10
set ClockList ap_clk
set AxiliteClockList {}
set HasVivadoClockPeriod 0
set CombLogicFlag 0
set PipelineFlag 0
set DataflowTaskPipelineFlag 1
set TrivialPipelineFlag 0
set noPortSwitchingFlag 0
set FloatingPointFlag 1
set FftOrFirFlag 0
set NbRWValue 0
set intNbAccess 0
set NewDSPMapping 1
set HasDSPModule 1
set ResetLevelFlag 0
set ResetStyle control
set ResetSyncFlag 1
set ResetRegisterFlag 0
set ResetVariableFlag 0
set ResetRegisterNum 0
set FsmEncStyle onehot
set MaxFanout 0
set RtlPrefix {}
set RtlSubPrefix gnss_correlator_
set ExtraCCFlags {}
set ExtraCLdFlags {}
set SynCheckOptions {}
set PresynOptions {}
set PreprocOptions {}
set RtlWriterOptions {}
set CbcGenFlag 0
set CasGenFlag 0
set CasMonitorFlag 0
set AutoSimOptions {}
set ExportMCPathFlag 0
set SCTraceFileName mytrace
set SCTraceFileFormat vcd
set SCTraceOption all
set TargetInfo xc7z020:-clg484:-1
set SourceFiles {sc {} c /home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/vivado/ip_repo/gnss_correlator/src/gnss_correlator.cpp}
set SourceFlags {sc {} c {{}}}
set DirectiveFile {}
set TBFiles {verilog /home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/vivado/ip_repo/gnss_correlator/src/gnss_correlator_tb.cpp bc /home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/vivado/ip_repo/gnss_correlator/src/gnss_correlator_tb.cpp vhdl /home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/vivado/ip_repo/gnss_correlator/src/gnss_correlator_tb.cpp sc /home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/vivado/ip_repo/gnss_correlator/src/gnss_correlator_tb.cpp cas /home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/vivado/ip_repo/gnss_correlator/src/gnss_correlator_tb.cpp c {}}
set SpecLanguage C
set TVInFiles {bc {} c {} sc {} cas {} vhdl {} verilog {}}
set TVOutFiles {bc {} c {} sc {} cas {} vhdl {} verilog {}}
set TBTops {verilog {} bc {} vhdl {} sc {} cas {} c {}}
set TBInstNames {verilog {} bc {} vhdl {} sc {} cas {} c {}}
set XDCFiles {}
set ExtraGlobalOptions {"area_timing" 1 "clock_gate" 1 "impl_flow" map "power_gate" 0}
set TBTVFileNotFound {}
set AppFile {}
set ApsFile hls.aps
set AvePath ../../.
set DefaultPlatform DefaultPlatform
set multiClockList {}
set SCPortClockMap {}
set intNbAccess 0
set PlatformFiles {{DefaultPlatform {xilinx/zynq/zynq}}}
set HPFPO 0
