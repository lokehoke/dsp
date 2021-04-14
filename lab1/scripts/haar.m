function y = haar(t, n)
    % k-я функцияХаара
    L = length(t);
    if (n == 0)
        y(1:L) = 1;
        return;
    end

    k = floor(log2(n));
    m = n - 2^k;

    y = zeros(1, L);
    step_width = L / 2^(k+1);

    support_start = floor(step_width * 2 * m) + 1;
    support_middle = floor(step_width * (2*m+1));
    support_end = floor(step_width * (2*m+2));
    if (support_end > L)
        support_end = L;
    end

    y(support_start:support_middle) = sqrt(2^k);
    y(support_middle + 1 : support_end) = -sqrt(2^k);
