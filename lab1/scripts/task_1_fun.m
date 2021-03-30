function y = task_1_fun(x)
    for (i = 1:length(x))
        if (x(i) >= 1/4 && x(i) < 1/2)
            y(i) = 1;
        else if (x(i) >= 1/2 && x(i) < 3/4)
            y(i) = 2;
        else
            y(i) = 0;
        end
    end
end
