# 2026-09-21T15:58:56.378533331
import vitis

client = vitis.create_client()
client.set_workspace(path="fft_acquisition")

vitis.dispose()

