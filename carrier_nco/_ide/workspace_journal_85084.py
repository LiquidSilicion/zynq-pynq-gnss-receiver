# 2026-09-21T16:54:16.764240442
import vitis

client = vitis.create_client()
client.set_workspace(path="carrier_nco")

comp = client.create_hls_component(name = "carrier_nco",cfg_file = ["carrier_nco_hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="carrier_nco")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="IMPLEMENTATION")

status = client.export_projects(components = ["carrier_nco"], system_projects = [], include_build_dir = False, dest = "/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/carrier_nco/archive.zip")

vitis.dispose()

