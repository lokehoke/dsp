close all;

mu = 10;
sigma = 1;
N = 100;

signal = normrnd(mu, sigma, [1, N]);

figure;
grid on;
hold on;
title(sprintf("Сигнал до квантования."));
plot(signal);

mse = zeros(1, 4);
mse_teor = zeros(1, 4);
snr = zeros(1, 4);
for (i = 1:4)
    figure;
    hold on;
    grid on;
    title(sprintf("Квантование при %i бит", i));

    % количество интервалов
    [out, mse(i), snr(i), mse_teor(i)] = LloydMax_quantization(signal, mu, sigma, i);

    stairs(out);
end

figure;
grid on;
hold on;
title("MSE");
plot(mse);
plot(mse_teor);
legend('mse', 'teor mse');
xlabel("n, бит");
ylabel("mse");

figure;
grid on;
hold on;
title("SNR");
plot(snr);

