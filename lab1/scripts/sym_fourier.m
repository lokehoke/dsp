% Построение спектра Фурье в символьном виде
function sym_fourier
    % Отрезок, на котором будет строиться график
    xmin = -3;
    xmax = 3;
    syms t v w f

    close all;
    f = -heaviside(t-1-0.5) + heaviside(t-0.5);
    Sw = fourier(f);
    S = subs(Sw, w, 2*pi*v);

    % ЧХ
    subplot(3, 1, 1);
    hold on;
    h = ezplot(real(S), [xmin, xmax]);
    set_pretty(h, [xmin, xmax, -1, 1.5]);
    h = ezplot(imag(S), [xmin, xmax]);
    hold off;
    set_pretty(h, [xmin, xmax, -1, 1.5], 'r');
    title('real and imag of S');
    xlabel('\nu');
    grid;

    subplot(3, 1, 2);
    h = ezplot(abs(S), [xmin, xmax]);
    set_pretty(h, [xmin, xmax, -1, 1.5]);
    title('Frequency response');
    xlabel('\nu');

    subplot(3, 1, 3);
    h = ezplot(atan(real(S) / imag(S)), [xmin, xmax]);
    set_pretty(h, [xmin, xmax, -1, 1.5]);
    title('angle(S)');
    xlabel('\nu');


    return;

function set_pretty(h, axis_xy, color)
    if (nargin < 3)
        color = 'b';
    end

    grid;
    set(h, 'LineWidth',2.5, 'Color', color);
    title('');
    xlabel('');
    % xmin xmax ymin ymax
    axis(axis_xy);
