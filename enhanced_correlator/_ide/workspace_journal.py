# 2026-09-20T20:17:32.295940804
import vitis

client = vitis.create_client()
client.set_workspace(path="enhanced_correlator")

comp = client.create_hls_component(name = "enhanced_correlator",cfg_file = ["enhanced_correlator_hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="enhanced_correlator")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

cfg = client.get_config_file(path="/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/enhanced_correlator/enhanced_correlator/enhanced_correlator_hls_config.cfg")

cfg.set_value(section="hls", key="syn.top", value="enhanced_correlator")

comp.run(operation="SYNTHESIS")

comp.run(operation="IMPLEMENTATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="IMPLEMENTATION")

status = client.export_projects(components = ["enhanced_correlator"], system_projects = [], include_build_dir = False, dest = "/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/enhanced_correlator/archive.zip")

vitis.dispose()

