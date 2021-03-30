function res = rademacher(x, k)
% Rademacher function system
% x: number vector of argument values
% k: basis function number

    res = sign(sin(2 * pi * 2^k * x));
    res(find(res == 0)) = -1;
