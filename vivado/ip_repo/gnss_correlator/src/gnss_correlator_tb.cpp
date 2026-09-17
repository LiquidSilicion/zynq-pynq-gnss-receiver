#include "gnss_correlator.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <complex>
#include <cmath>

int main() {
    // 1. Open the simulated GPS data
    std::string file_path = "/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/gps-sdr-sim/gpssim_float.bin";
    std::ifstream infile(file_path, std::ios::binary);
    
    if (!infile) {
        std::cerr << "Error: Could not open " << file_path << "\n";
        return 1;
    }

    // We only need 1024 samples for the HLS testbench (just 8 KB of data!)
    int num_samples = 1024; 
    
    // Read only the first 1024 complex samples directly
    std::vector<std::complex<float>> signal_data(num_samples);
    infile.read(reinterpret_cast<char*>(signal_data.data()), num_samples * sizeof(std::complex<float>));
    infile.close();

    // Separate the complex data into explicit I and Q arrays for the HLS function
    std::vector<float> sig_I(num_samples), sig_Q(num_samples);
    for(int i = 0; i < num_samples; i++) {
        sig_I[i] = signal_data[i].real();
        sig_Q[i] = signal_data[i].imag();
    }

    // 2. Generate a dummy local code (For this test, we use a constant '1.0' to verify the math works)
    std::vector<float> code_I(num_samples, 1.0f);
    std::vector<float> code_Q(num_samples, 0.0f);

    // 3. Call the HLS function
    float out_I = 0.0f, out_Q = 0.0f;
    gnss_correlator(sig_I.data(), sig_Q.data(), code_I.data(), code_Q.data(), &out_I, &out_Q, num_samples);

    // 4. Print the results
    float magnitude = std::sqrt(out_I * out_I + out_Q * out_Q);
    std::cout << "--------------------------------------------------\n";
    std::cout << "GNSS Correlator HLS Testbench Results\n";
    std::cout << "--------------------------------------------------\n";
    std::cout << "Processed Samples: " << num_samples << "\n";
    std::cout << "Correlation Result (I, Q): " << out_I << ", " << out_Q << "\n";
    std::cout << "Magnitude: " << magnitude << "\n";
    std::cout << "--------------------------------------------------\n";

    return 0;
}