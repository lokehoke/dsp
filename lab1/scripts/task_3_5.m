mu = 10;
sigma = 5;
N = 100;

signal = normrnd(mu, sigma, [1, N]);
figure;
grid on;
hold on;
plot(signal);
title(sprintf("N(%i, %i)", mu, sigma));

calc_mu = sum(signal) / N
calc_sigma = sqrt(sum((signal - calc_mu).^2)/(N-1))
