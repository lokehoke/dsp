fun = @(t) 8*sin(2*pi*t * 220) + 3*sin(2*pi*t * 240) + 4*sin(2*pi*t * 280) + 2*sin(2*pi*t * 300);

subplot(2, 1, 1);
hold on;
grid on;
frequency = 200;
plot(0:1:frequency, abs(fft(fun(0:1/frequency:1))));
title(sprintf('f = %i < f_{max}', frequency));
xlabel('\nu');

subplot(2, 1, 2);
hold on;
grid on;
frequency = 800;
plot(0:1:frequency, abs(fft(fun(0:1/frequency:1))));
title(sprintf('f = %i > f_{max}', frequency));
xlabel('\nu');
