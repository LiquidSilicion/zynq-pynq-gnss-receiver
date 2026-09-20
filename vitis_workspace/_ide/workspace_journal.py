# 2026-09-19T17:32:54.341918538
import vitis

client = vitis.create_client()
client.set_workspace(path="vitis_workspace")

comp = client.get_component(name="gnss_correlator_hls")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="IMPLEMENTATION")

status = client.export_projects(components = ["gnss_correlator_hls"], system_projects = [], include_build_dir = False, dest = "/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/vitis_workspace/archive.zip")

vitis.dispose()

