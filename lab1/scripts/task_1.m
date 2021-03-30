% N - Количество получаемых коэфицентов
N = 3;

c = fseries('task_1_fun', 0, 1, [0:N], 'haar')

sum = 0;
for (i = 0:N)
    sum = sum + c(i+1)^2;
end

sum
