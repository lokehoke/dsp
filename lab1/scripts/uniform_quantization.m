function [out, mse, snr] = uniform_quantization(signal, min, max, i)
    lvlCount = 2^i;

    % определяем равные интервалы
    lvl = min:((max-min) / lvlCount):max;
    N = length(signal);

    % определяем уровни квантования
    d = zeros(1, lvlCount);
    for (j = 1:lvlCount)
        d(j) = (lvl(j) + lvl(j+1))/2;
        % plot([1:N], zeros(1, N) + d(j), 'm');
    end

    % квантуем
    out = zeros(1, N);
    for (j = 1:N)
        k = find(lvl >= signal(j))(1) - 1;
        if (k == 0)
            k = 1;
        end
        out(j) = d(k);
    end

    mse = sum((signal - out).^2) / N;
    snr = 20 * log10(sqrt(sum((out).^2) / N) / sqrt(sum((signal - out).^2) / N));
