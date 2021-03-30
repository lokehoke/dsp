close all;
N = 100;
signal = rand([1, N]);
figure;
grid on;
hold on;
title(sprintf("Сигнал до квантования."));
plot(signal);

mse = zeros(1, 8);
mse_teor = zeros(1, 8);
snr = zeros(1, 8);
for (i = 1:8)
    figure;
    hold on;
    grid on;
    title(sprintf("Квантование при %i бит", i));

    % количество интервалов
    [out, mse(i), snr(i)] = uniform_quantization(signal, 0, 1, i);

    plot(out);
    mse_teor(i) = (1 / 2^i)^2 / 12; % учебник стр 119
end

figure;
grid on;
hold on;
title("MSE");
plot(mse);
plot(mse_teor, 'm');
legend('mse', 'teor mse');
xlabel("n, бит");
ylabel("mse");

figure;
grid on;
hold on;
title("SNR");
plot(snr);

