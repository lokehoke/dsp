fun = @(t) sin(2*pi*t * 30) + sin(2*pi*t * 40);

% fmax = 40 * 2
% 60 < 80
frequency = 60;
imposter = @(t) (-sin(2*pi*t * 30)-sin(2*pi*t * 20));

x = 0:1/frequency:0.1;
subplot(2, 2, 1);
grid on;
plot(x, fun(x));
title('Original discrete function f < fmax')

subplot(2, 2, 2);
grid on;
plot(x, imposter(x));
title('Imposter function f < fmax')

frequency = 200;
x = 0:1/frequency:0.1;
subplot(2, 2, 3);
grid on;
plot(x, fun(x));
title('Original discrete function f > fmax')

subplot(2, 2, 4);
grid on;
plot(x, imposter(x));
title('Imposter function f > fmax')
