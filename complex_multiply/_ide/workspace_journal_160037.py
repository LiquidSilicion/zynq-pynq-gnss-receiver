# 2026-09-21T17:26:27.441060624
import vitis

client = vitis.create_client()
client.set_workspace(path="complex_multiply")

comp = client.get_component(name="complex_multiply")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="IMPLEMENTATION")

status = client.export_projects(components = ["complex_multiply"], system_projects = [], include_build_dir = False, dest = "/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/complex_multiply/archive.zip")

vitis.dispose()

