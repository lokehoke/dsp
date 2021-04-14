 function [out, mse, snr, mse_teor] = LloydMax_quantization(signal, mu, sigma, i)
    if (i == 1)
        t = [-inf 0.0 inf];
        d = [-0.7979 0.7979];
    elseif (i == 2)
        t = [-inf -0.9816 0.0 0.9816 inf];
        d = [-1.5104 -0.4528 0.4528 1.5104];
    elseif (i == 3)
        t = [-inf -1.7479 -1.0500 -0.5005 0.0 0.5005 1.0500 1.7479 inf];
        d = [-2.1519 -1.3439 -0.7560 -0.2451 0.2451 0.7560 1.3439 2.1519];
    elseif (i == 4)
        t = [-inf -2.4008 -1.8435 -1.4371 -1.0993 -0.7995 -0.5224 -0.2582 0.0 0.2582 0.5224 0.7995 1.0993 1.4371 1.8435 2.4008 inf];
        d = [-2.7326 -2.0690 -1.6180 -1.2562 -0.9423 -0.6568 -0.3880 -0.1284 0.1284 0.3880 0.6568 0.9423 1.2562 1.6180 2.0690 2.7326];
    end

    t = t*sigma + mu;
    d = d*sigma + mu;

    N = length(signal);
    out = zeros(1, N);
    for (j = 1:N)
        k = find(t >= signal(j))(1) - 1;
        out(j) = d(k);
    end

    mse = sum((signal - out).^2) / N;
    snr = 20 * log10(sqrt(sum((out).^2) / N) / sqrt(sum((signal - out).^2) / N));

    mse_teor = 0;
    for ( j = 1:(2^i) )
        f = @(x) (x - d(j)).^2 ./ sigma ./ sqrt(2 .* pi) .* exp( -1 .* (x - mu).^2 ./ 2 ./ (sigma.^2));
        mse_teor = mse_teor + integral(f, t(j), t(j+1));
    end
