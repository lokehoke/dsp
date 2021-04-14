function res = haar_coef(f_int, K, T0, T1)
    i = 1;
    for (n = K)
        if (n < 0)
            res(i) = 0;
        elseif (n == 0)
            res(i) = quadl(f_int, T0, T1);
        else
            k = floor(log2(n));
            m = n - 2^k;

            step_width = 1 / 2 ^ (k + 1);

            support(1) = step_width * 2 * m;
            support(2) = step_width * (2 * m + 1);
            support(3) = step_width * (2 * m + 2);
            support = support * (T1 - T0) + T0;

            res(i) = quadl(f_int, support(1), support(2));
            res(i) = res(i) - quadl(f_int, support(2), support(3));
            res(i) = res(i) * sqrt(2 ^ k);
        end
        i = i + 1;
    end
    res = res / (T1 - T0);
