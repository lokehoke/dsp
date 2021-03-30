clear;
close all;

total_num = 50; % всего коэффициентов Фурье
basis = 'walsh'; % базис (walsh или haar)

T0 = 0; % начало отрезка
T1 = 1; % конец отрезка
points = 300; % число точек для вычисления функции
T = T1 - T0;
plot_time = linspace(T0, T1, points);

h = figure;
set(h, 'DoubleBuffer', 'on');

K = [0:total_num];

fun = @(t) sin(2 * pi * t);
C = fseries(fun, T0, T1, K, basis);

fvalues = fun(plot_time);
for (i = 3:2:length(K))
    ind = [1:i];
    S = real(fsum(C(ind), K(ind), T0, T1, plot_time, basis));

    plot(plot_time, fvalues, 'k', plot_time, S, 'r', 'LineWidth', 2);
    grid;
    axis([T0, T1, min(fvalues) - 0.1, max(fvalues) + 0.1]);
    title(sprintf('%i members of the %s Fourier series', total_num, basis));
    drawnow;
end
