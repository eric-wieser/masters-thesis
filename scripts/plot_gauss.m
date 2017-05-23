function plot_gauss
    percentile = 0.9

    set(0,'defaulttextinterpreter','latex');

    area_props = {[0.5, 0.5, 0.5], 'EdgeColor', 'none', 'FaceAlpha', 0.5};

    function savetikz(fname)
        set(gca,'xticklabel',[]);
        set(gca,'yticklabel',[]);
        matlab2tikz(...
            'filename', ['../figures/' fname '.tikz'], ...
            'width', '\linewidth', 'height', '3cm', ...
            'extraTikzpictureOptions', {'trim axis left', 'trim axis right'});
    end

    function plot_1d
        N = 10;
        mu1 = 2;
        sigma1 = 0.5;
        p = normrnd(mu1, sigma1, N, 1);
        e = sqrt(chi2inv(percentile, 1))
        x1 = linspace(0, 4);
        figure;
        hold on;
        center = linspace(-e, e);
        bounds = fill(...
            mu1 + [-e, center, e]*sigma1, ...
            [0, normpdf(center) / sigma1, 0], ...
            area_props{:});
        plot(x1, normpdf(x1, mu1, sigma1), 'Color', 'k');
        plot(p, zeros(size(p)), 'o', 'Color', NewColors.r);

        ylabel('$p(x; \mu, \sigma)$');
        xlabel('$x$');
        savetikz('gauss1d');
    end

    function plot_2d
        N = 50;
        L = [[0.5; 0.25] [-0.25; 0.25]];
        sigma2 = L'*L;
        g = gaussian([1; 2], sigma2);

        [x, y] = error_ellipse_path(g);

        figure;
        hold on;
        fill(x, y, area_props{:});

        p = g.sample(N);
        plot(p(1,:), p(2,:), 'o', 'Color', NewColors.r);

        ylabel('$x_2$');
        xlabel('$x_1$');
        xlim([-0.5, 2.5]);
        ylim([0.5, 3.5]);
        axis equal;
        xticks(-2:0.5:2);
        yticks(-1:0.5:3);


        savetikz('gauss2d');
    end

    function plot_gp
        N = 10;

        % addpath 'C:\Users\wiese\Repos\forks\gpml-matlab'
        % addpath 'C:\Users\wiese\Documents\Courses\4F13\cw1'

        figure;
        hold on;

        all_i = linspace(0, 4)';
        n = length(all_i);
        ell = 1;
        i_sample = [1, 3]';
        xi_sample = [0, 0.5]';

        mf = @(xi) 0*xi;
        Kf = @(xi, xj) exp(-maha(xi/ell,xj/ell)/2) + 0.025;


        m = mf(all_i) - (Kf(all_i, i_sample)/Kf(i_sample,i_sample)) * (xi_sample - mf(xi_sample));
        K = Kf(all_i, all_i) - (Kf(all_i, i_sample)/Kf(i_sample,i_sample))*Kf(i_sample, all_i);
        L = chol(K + eye(size(K))*0.0000001);


        sigma = sqrt(diag(K));
        e = sqrt(chi2inv(percentile, 1));

        x = [all_i; all_i(end:-1:1)];
        y = [m + e*sigma; m(end:-1:1) - e*sigma(end:-1:1)];
        fill(x, y, area_props{:});

        p = m + L'*randn(size(L, 1), N);
        plot(all_i, p, 'Color', NewColors.r);



        ylabel('$x(i)$');
        xlabel('$i$');
        savetikz('gaussproc');
    end

    plot_1d;
    plot_2d;
    plot_gp;
end

function [x, y] = error_ellipse_path(g)
    a = gca();
    f = figure;
    h = error_ellipse(g.s, g.m);
    x = get(h, 'xdata');
    y = get(h, 'ydata');
    delete(f);
    axes(a);
end

