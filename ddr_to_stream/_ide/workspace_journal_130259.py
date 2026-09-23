# 2026-09-22T12:38:04.111877416
import vitis

client = vitis.create_client()
client.set_workspace(path="ddr_to_stream")

comp = client.get_component(name="ddr_to_stream")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="IMPLEMENTATION")

status = client.export_projects(components = ["ddr_to_stream"], system_projects = [], include_build_dir = False, dest = "/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/ddr_to_stream/archive.zip")

vitis.dispose()

