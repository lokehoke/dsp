#include <cmath>
#include <cstddef>
#include <limits>
#include <fstream>
#include <random>

#include "dsp.hpp"

dsp::TSignal dsp::dft(const dsp::TSignal& x, bool invert) {
    TSignal y(x.size(), 0);

    auto exp_m = (invert ? 1 : -1) * 2 * dsp::pi * dsp::i / static_cast<dsp::TDouble>(x.size());

    for (std::size_t k = 0; k < x.size(); ++k) {
        for (std::size_t j = 0; j < x.size(); ++j) {
            y[k] += x[j] * std::exp(exp_m * static_cast<dsp::TDouble>(k * j));
        }

        if (invert) {
            y[k] /= x.size();
        }
    }

    return y;
}

dsp::TSignal dsp::idft(const dsp::TSignal& y) {
    return dsp::dft(y, true);
}

dsp::TSignal dsp::fft(const dsp::TSignal& x, bool invert) {
    auto y = x;

    auto n = x.size();
    auto k = static_cast<std::size_t>(std::log2(n));

    auto t = x;

    for (std::size_t i = n, step = 1; i != 1; i /= 2, ++step) {
        dsp::TGeneral w = 1;
        dsp::TGeneral wn = std::exp((invert ? 1 : -1) * dsp::pi / (1 << (k - step)) * dsp::i);

        for (std::size_t l = 0, num = 0; l < ( 1 << (k - step)); ++l) {
            for (std::size_t j = 0; j < (1 << (step - 1)); ++j, ++num) {
                t[l * (1 << step) + j] = (y[num] + y[num + n/2]);
                t[l * (1 << step) + j + (1 << (step - 1))] = (y[num] - y[num + n/2]) * w;
            }
            w *= wn;
        }

        y = t;
    }

    if (invert) {
        for (auto& i : y) {
            i /= n;
        }
    }

    return y;
}

dsp::TSignal dsp::ifft(const dsp::TSignal& y) {
    return dsp::fft(y, true);
}

dsp::TSignal dsp::convolution_slow(const dsp::TSignal& x, const dsp::TSignal& y) {
    dsp::TSignal u(x.size() + y.size() - 1, 0);

    for (std::size_t n = 0; n < u.size(); ++n) {
        for(std::size_t k = 0; k < x.size() && (n - k) >= 0; ++k) {
            if (n - k < y.size()) {
                u[n] += x[k] * y[n - k];
            }
        }
    }

    return u;
}

dsp::TSignal dsp::convolution_fast(const dsp::TSignal& x, const dsp::TSignal& y) {
    auto x1(x);
    auto y1(y);

    auto M = x1.size();
    auto L = y1.size();

    std::size_t N = 2;

    while (N*2 < std::max({M*2, L*2})) {
        N <<= 1;
    }
    N <<= 1;

    auto norm = std::sqrt(N);

    x1.resize(N, 0);
    y1.resize(N, 0);

    x1 = dsp::fft(x1);
    y1 = dsp::fft(y1);

    dsp::TSignal u(N);

    for (std::size_t i = 0; i < N; ++i) {
        u[i] = x1[i] * y1[i];
    }

    u = dsp::ifft(u);

    u.resize(M + L - 1);

    return u;
}

dsp::TGeneral dsp::mse(const dsp::TSignal& a, const dsp::TSignal& b) {
    if (a.size() != b.size()) {
        return -1;
    }

    TGeneral mse = 0;

    for (std::size_t i = 0; i < a.size(); ++i) {
        mse += std::pow((a[i] - b[i]), 2);
    }

    return mse / static_cast<dsp::TDouble>(a.size());
}

void dsp::writeSignalToFile(const dsp::TSignal& a, const std::string& file) {
    std::ofstream fout(file);
    fout.precision(std::numeric_limits<dsp::TDouble>::max_digits10);
    for (const auto& i : a) {
        fout << i.real() << " " << i.imag() << std::endl;
    }
}

dsp::TSignal dsp::readFromFile(const std::string& file) {
    std::ifstream fin(file);
    dsp::TSignal signal;

    dsp::TDouble real, im;
    fin >> real >> im;

    while(!fin.eof()) {
        signal.push_back({real, im});
        fin >> real >> im;
    }

    return signal;
}

dsp::TSignal dsp::getRandomSignal(std::size_t n) {
    std::random_device rd;
    std::default_random_engine eng(rd());
    std::uniform_real_distribution<dsp::TDouble> distr(-1'000.0, 1'000.0);

    dsp::TSignal signal(n);

    for (auto& j : signal) {
        j = {distr(eng), distr(eng)};
    }

    return signal;
}
