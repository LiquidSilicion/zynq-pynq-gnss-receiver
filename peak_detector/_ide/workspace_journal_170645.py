# 2026-09-23T17:28:35.942127105
import vitis

client = vitis.create_client()
client.set_workspace(path="peak_detector")

comp = client.get_component(name="peak_detector")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="IMPLEMENTATION")

status = client.export_projects(components = ["peak_detector"], system_projects = [], include_build_dir = False, dest = "/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/peak_detector/archive.zip")

vitis.dispose()

