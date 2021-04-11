clear;
close all;

% total_num = 50; % всего коэффициентов Фурье


mse = zeros(2, 20);
for (total_num = 1:20)
    T0 = 0; % начало отрезка
    T1 = 1; % конец отрезка
    points = 300; % число точек для вычисления функции
    T = T1 - T0;
    plot_time = linspace(T0, T1, points);


    K = [0:total_num];
    fun = @(t) sin(2 * pi * t);
    fvalues = fun(plot_time);

    basis = 'walsh'; % базис (walsh или haar)
    C = fseries(fun, T0, T1, K, basis);

    S = real(fsum(C, K, T0, T1, plot_time, basis));

    mse(1, total_num) = sum((fvalues - S).^2) / length(S);

    basis = 'haar'; % базис (walsh или haar)
    C = fseries(fun, T0, T1, K, basis);
    S = real(fsum(C, K, T0, T1, plot_time, basis));

    mse(2, total_num) = sum((fvalues - S).^2) / length(S);
end

grid on;
hold on;
plot(mse(1, :));
plot(mse(2, :));
legend("mse walsh", "mse haar");


% axis([T0, T1, min(fvalues) - 0.1, max(fvalues) + 0.1]);
% title(sprintf('%i members of the %s Fourier series', total_num, basis));
% drawnow;

% sum((signal - out).^2) / N;
