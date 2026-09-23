# 2026-09-21T18:46:58.052792234
import vitis

client = vitis.create_client()
client.set_workspace(path="complex_scale")

comp = client.create_hls_component(name = "complex_scale",cfg_file = ["complex_scale_hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="complex_scale")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="IMPLEMENTATION")

status = client.export_projects(components = ["complex_scale"], system_projects = [], include_build_dir = False, dest = "/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/complex_scale/archive.zip")

vitis.dispose()

