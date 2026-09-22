# 2026-09-21T16:27:01.338103204
import vitis

client = vitis.create_client()
client.set_workspace(path="complex_multiply")

comp = client.create_hls_component(name = "complex_multiply",cfg_file = ["complex_multiply_hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="complex_multiply")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="IMPLEMENTATION")

vitis.dispose()

