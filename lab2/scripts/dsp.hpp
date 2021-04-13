#pragma once

#include <complex>
#include <vector>
#include <string>
#include <cstddef>

namespace dsp {
    using TGeneral = std::complex<double>;
    using TSignal = std::vector<TGeneral>;

    constexpr TGeneral i(0, 1);

    TSignal dft(const TSignal& x, bool invert = false);
    TSignal idft(const TSignal& x);

    TSignal fft(const TSignal& x, bool invert = false);
    TSignal ifft(const TSignal& x);

    TSignal convolution_slow(const TSignal& x, const TSignal& y);
    TSignal convolution_fast(const TSignal& x, const TSignal& y);

    TGeneral mse(const TSignal& a, const TSignal& b);

    void writeSignalToFile(const TSignal& a, const std::string& file);
    TSignal readFromFile(const std::string& file);

    TSignal getRandomSignal(std::size_t n);
};
