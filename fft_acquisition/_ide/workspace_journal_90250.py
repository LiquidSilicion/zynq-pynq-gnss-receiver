# 2026-09-21T13:42:39.100288448
import vitis

client = vitis.create_client()
client.set_workspace(path="fft_acquisition")

comp = client.create_hls_component(name = "fft_acquisition",cfg_file = ["fft_acquisition_hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="fft_acquisition")
status = comp.remove_cfg_files(cfg_files=["fft_acquisition_hls_config.cfg"])

status = comp.add_cfg_files(cfg_files=["/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/vivado/ip_repo/fft_acquisition/fft_acquisition_hls_config.cfg"])

comp.run(operation="C_SIMULATION")

status = comp.remove_cfg_files(cfg_files=["/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/vivado/ip_repo/fft_acquisition/fft_acquisition_hls_config.cfg"])

status = comp.add_cfg_files(cfg_files=["fft_acquisition_hls_config.cfg"])

comp.run(operation="C_SIMULATION")

cfg = client.get_config_file(path="/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/fft_acquisition/fft_acquisition/fft_acquisition_hls_config.cfg")

cfg.set_value(key="part", value="xc7z020clg484-1")

cfg.set_value(section="hls", key="tb.cflags", value="")

cfg.set_value(section="hls", key="syn.csimflags", value="")

cfg.set_values(key="tb.file", values=["/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/vivado/ip_repo/fft_acquisition/src/fft_acquisition_tb.cpp"])

cfg.set_values(key="tb.file_cflags", values=[])

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

vitis.dispose()

