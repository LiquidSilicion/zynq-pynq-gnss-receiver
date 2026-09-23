# 2026-09-21T17:42:24.784342019
import vitis

client = vitis.create_client()
client.set_workspace(path="peak_detector")

comp = client.create_hls_component(name = "peak_detector",cfg_file = ["peak_detector_hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="peak_detector")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="IMPLEMENTATION")

status = client.export_projects(components = ["peak_detector"], system_projects = [], include_build_dir = False, dest = "/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/peak_detector/archive.zip")

vitis.dispose()

