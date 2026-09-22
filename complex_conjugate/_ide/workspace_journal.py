# 2026-09-21T21:29:23.717669101
import vitis

client = vitis.create_client()
client.set_workspace(path="complex_conjugate")

comp = client.create_hls_component(name = "complex_conjugate",cfg_file = ["complex_conjugate_hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="complex_conjugate")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="IMPLEMENTATION")

status = client.export_projects(components = ["complex_conjugate"], system_projects = [], include_build_dir = False, dest = "/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/complex_conjugate/archive.zip")

vitis.dispose()

