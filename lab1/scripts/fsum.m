function Sn = fsum(c, K, T0, T1, t, basis)
    % частичная сумма ряда Фурье
    % Использование:
    %   Sn = fsum(c, K, T0, T1, t, basis)
    %   c – вектор коэффициентов Фурье
    %   T0, T1 – начало и конец отрезка наблюдения функции
    %   t – вектор отсчетов времени
    %   basis – базис 'fourier' (поусолчанию), 'walsh',
    %   'rademacher'
    %   Sn–частичная сумма
    %
    % Пример:
    %   c = [0.4597, -0.2149, -0.1057, -0.0148];
    %   K = [0 : 3];
    %   >>plot(fsum(c, K, 0, 1, [0:0.01:1], 'walsh'))
    if (nargin< 6)
        basis = 'fourier';
    end

    Sn = zeros(1, length(t));

    switch lower(basis)
        case {'rademacher', 'walsh', 'haar'}
            basefun = inline([basis, '(t, k)'], 't', 'k');
            i = 1;
            for (k = K)
                w(i,:) = feval(basefun, (t - T0) / (T1 - T0), k);
                i = i + 1;
            end

            for (m = 1:length(t))
                Sn(m) = sum(c .* w(:,m)');
            end
        case 'fourier'
            for (k = 1:length(t))
                Sn(k) = sum(c .* exp(j * 2 * pi * K * t(k) / (T1 - T0)));
            end
    end
