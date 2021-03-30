function c = fseries(target_fun, T0, T1, K, basis)
    % НахождениекоэффициентовФурье.
    % Использование:
    %   c = fseries(target_fun, T0, T1, K, basis)
    %   target_fun – исходнаяфункция
    %   basis – 'fourier' (по умолчанию), 'walsh', 'rademacher'
    %   T0, T1 – начало и конец интервала анализа функции 
    %   K – вектор номеров искомых коэффициентов
    %   c – вектор коэффициентов Фурье
    % 
    % Пример:
    %   >> c = fseries(@(x) sin(x), 0, 1, [0:3], 'walsh')
    %   c =
    %      0.4597   -0.2149   -0.1057   -0.0148
    if (nargin < 5)
        basis = 'fourier';
    end
    
    switch lower(basis)
        case 'fourier'
            f_int =  @(t, k) target_fun(t) .* exp(-i * 2 * pi * k * t / (T1 - T0));
            fromZero = 0;
        case 'rademacher'
            f_int = @(t, k) target_fun(t) .* rademacher((t - T0) / (T1 - T0), k);
            fromZero = 1;
        case 'walsh'
            f_int = @(t, k) target_fun(t) .* walsh((t - T0) / (T1 - T0), k);
            fromZero = 1;
        case 'haar'
            c = haar_coef(target_fun, K, T0, T1);
        return;
    end
    
    l = 1;
    for (k = K)
        if (fromZero && k < 0)
            c(l) = 0;
        else
            c(l) = 1 / (T1 - T0) * quadl(@(t) f_int(t, k), T0, T1);
        end
        l = l + 1;
    end
