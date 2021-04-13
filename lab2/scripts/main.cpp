#include <iostream>
#include <chrono>
#include <cstddef>

#include "dsp.hpp"

int main() {
    // read signal from file
    auto signal1 = dsp::readFromFile("./txt/signal1.txt");

    // task 1
    auto spectrum_slow = dsp::dft(signal1);
    auto recovered_signal_slow = dsp::idft(spectrum_slow);

    dsp::writeSignalToFile(spectrum_slow, "./txt/spectrum_slow.txt");

    // task 2
    auto spectrum_fast = dsp::fft(signal1);
    auto recovered_signal_fast = dsp::ifft(spectrum_fast);

    dsp::writeSignalToFile(spectrum_slow, "./txt/spectrum_fast.txt");

    // task 3
    std::cout << "mse of signal and slow recovered signal: " << dsp::mse(signal1, recovered_signal_slow) << std::endl;
    std::cout << "mse of signal and fast recovered signal: " << dsp::mse(signal1, recovered_signal_fast) << std::endl;
    std::cout << "mse of slow spectrum and fast spectrum: " << dsp::mse(spectrum_slow, spectrum_fast) << std::endl;

    // task 4
    auto begin = std::chrono::high_resolution_clock::now();
    auto end = std::chrono::high_resolution_clock::now();

    for (std::size_t i = 16; i < 5'000; i *= 2) {
        auto random_signal = dsp::getRandomSignal(i);

        begin = std::chrono::high_resolution_clock::now();
        dsp::dft(random_signal);
        end = std::chrono::high_resolution_clock::now();
        std::cout << "dft - i: " << i << " time: "<< std::chrono::duration_cast<std::chrono::microseconds>(end-begin).count() << " microseconds" << std::endl;

        begin = std::chrono::high_resolution_clock::now();
        dsp::fft(random_signal);
        end = std::chrono::high_resolution_clock::now();
        std::cout << "fft - i: " << i << " time: "<< std::chrono::duration_cast<std::chrono::microseconds>(end-begin).count() << " microseconds" << std::endl;
    }

    // task 5
    auto signal2 = dsp::readFromFile("./txt/signal2.txt");
    auto conv_slow = dsp::convolution_slow(signal1, signal2);
    dsp::writeSignalToFile(conv_slow, "./txt/convolution_slow.txt");

    // task 6
    auto conv_fast = dsp::convolution_fast(signal1, signal2);
    dsp::writeSignalToFile(conv_fast, "./txt/convolution_fast.txt");

    // task 7
    std::cout << "mse of conv_slow and conv_fast: " << dsp::mse(conv_slow, conv_fast) << std::endl;

    // task 8
    auto random_signal1 = dsp::getRandomSignal(1'024);
    for (std::size_t i = 16; i <= 5'000; i *= 2) {
        auto random_signal2 = dsp::getRandomSignal(i);
        auto random_signal3 = dsp::getRandomSignal(i);

        begin = std::chrono::high_resolution_clock::now();
        dsp::convolution_slow(random_signal1, random_signal2);
        end = std::chrono::high_resolution_clock::now();
        std::cout << "convolution_slow - (i, j): (" << 1024 << ", " << i << ") time: "<< std::chrono::duration_cast<std::chrono::microseconds>(end-begin).count() << " microseconds" << std::endl;

        begin = std::chrono::high_resolution_clock::now();
        dsp::convolution_fast(random_signal1, random_signal2);
        end = std::chrono::high_resolution_clock::now();
        std::cout << "convolution_fast - (i, j): (" << 1024 << ", " << i << ") time: "<< std::chrono::duration_cast<std::chrono::microseconds>(end-begin).count() << " microseconds" << std::endl;

        begin = std::chrono::high_resolution_clock::now();
        dsp::convolution_slow(random_signal2, random_signal3);
        end = std::chrono::high_resolution_clock::now();
        std::cout << "convolution_slow - (i, j): (" << i << ", " << i << ") time: "<< std::chrono::duration_cast<std::chrono::microseconds>(end-begin).count() << " microseconds" << std::endl;

        begin = std::chrono::high_resolution_clock::now();
        dsp::convolution_fast(random_signal2, random_signal3);
        end = std::chrono::high_resolution_clock::now();
        std::cout << "convolution_fast - (i, j): (" << i << ", " << i << ") time: "<< std::chrono::duration_cast<std::chrono::microseconds>(end-begin).count() << " microseconds" << std::endl;
    }

    return 0;
}
