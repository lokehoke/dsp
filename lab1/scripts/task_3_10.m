close all;

mu = 10;
sigma = 1;
N = 100;

signal = normrnd(mu, sigma, [1, N]);

mse = zeros(2, 4);
snr = zeros(2, 4);
for (i = 1:4)
    [out, mse(1, i), snr(1, i)] = uniform_quantization(signal, min(signal), max(signal), i);
    [out, mse(2, i), snr(2, i)] = LloydMax_quantization(signal, mu, sigma, i);
end

figure;
grid on;
hold on;
title("MSE");
plot(mse(1, :));
plot(mse(2, :), 'm');
legend('uniform', 'LloydMax')
xlabel("n, бит");
ylabel("mse");

figure;
grid on;
hold on;
title("SNR");
plot(snr(1, :));
plot(snr(2, :), 'm');
legend('uniform', 'LloydMax')

