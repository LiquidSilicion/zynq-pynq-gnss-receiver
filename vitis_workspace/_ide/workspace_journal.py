# 2026-09-16T17:13:33.413138866
import vitis

client = vitis.create_client()
client.set_workspace(path="vitis_workspace")

comp = client.create_hls_component(name = "gnss_correlator_hls",cfg_file = ["correlator_hls_config.cfg"],template = "empty_hls_component")

cfg = client.get_config_file(path="/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/vitis_workspace/gnss_correlator_hls/correlator_hls_config.cfg")

cfg.set_value(section="hls", key="syn.top", value="gnss_correlator")

cfg.set_value(key="part", value="xc7z020clg484-1")

comp = client.get_component(name="gnss_correlator_hls")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

cfg.set_value(section="hls", key="clock", value="25ns")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

cfg.set_value(section="hls", key="clock", value="10ns")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="IMPLEMENTATION")

vitis.dispose()

