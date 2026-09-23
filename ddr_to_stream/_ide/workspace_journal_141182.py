# 2026-09-22T14:22:23.250946915
import vitis

client = vitis.create_client()
client.set_workspace(path="ddr_to_stream")

comp = client.get_component(name="ddr_to_stream")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="IMPLEMENTATION")

vitis.dispose()

