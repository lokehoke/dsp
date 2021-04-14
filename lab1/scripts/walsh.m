function res = walsh(x, k)
    % Walsh function system
    % x: vector of argument values
    % k: basis function number
    res = ones(1, length(x));
    bin = dec2bin(k);

    for (i = 1:length(bin))
        if (bin(i) == '1')
            res = rademacher(x,length(bin)-i).*res;
        end
    end
