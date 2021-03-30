fd = double(imread('./../img/var9.png')); % считывание исходного изображения
[M, N] = size(fd); % размеры изображение fd

for (k = [2, 3, 4])
    figure;
    subplot(1, 2, 1);
    hold on;
    title(sprintf("Прореживание к = %i", k));
    Mk = floor(M / k); % строк в прореженном изображении
    Nk = floor(N / k); % столбцов в прореженном изображении
    ff = fd(1:k:(Mk * k), 1:k:(Nk * k)); % прореженное изображение
    % функции Котельникова задаем таблично в SincArray
    ColumnInd = [1:max(Mk, Nk)];
    for (j = 1:max(M,N))
        SincArray(j, ColumnInd) = sinc(j / k - ColumnInd);
    end

    % получаем интерполированное по формуле Котельникова изображение:
    F = SincArray(1:M, 1:Mk) * ff * SincArray(1:N, 1:Nk)';
    imshow(uint8(F));

    % figure;
    subplot(1, 2, 2);
    hold on;
    title(sprintf("Уменьшение изображения к = %i", k));
    % уменьшаем изображение в к раз
    F = zeros(Mk, Nk);
    for (i = 1:N)
        for (j = 1:M)
            if (mod(i + j, k) == 0) % оставляем левый верхний пиксель в каждом квадрате к * к
                F(floor(j / k) + 1, floor(i / k) + 1) = fd(j, i);
            end
        end
    end
    imshow(uint8(F));
end
