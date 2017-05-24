load('bad-encoder.mat')

traj = trajectories(1);

t = make_times(traj.dt, traj.observed);
o = traj.observed;

[~,i] = max(diff(o(plant.out_frame.i.xc,:)));

figure;
hold on;
plot(t, o(plant.out_frame.i.xc,:));
plot(t, o(plant.out_frame.i.yc,:));
ylabel('position / $\si{\meter}$');
xlabel('time / $\si{\second}$')
matlab2tikz(...
    'filename', ['../figures/bad-encoder-pos.tikz'], ...
    'width', '\linewidth', 'height', '0.75\linewidth', ...
    'extraTikzpictureOptions', {'trim axis left', 'trim axis right'}, ...
    'extraAxisOptions', {});

figure;
hold on;

x = o(plant.out_frame.i.xc,:);
y = o(plant.out_frame.i.yc,:);
xf = [x(1:i) nan x(i+1:end)];
yf = [y(1:i) nan y(i+1:end)];
xb = [x(i) x(i+1)];
yb = [y(i) y(i+1)];
h = plot(xf, yf);
plot(xb, yb, ':', 'Color', h.Color);
ylabel('y / $\si{\meter}$');
xlabel('x / $\si{\meter}$');
axis equal;
matlab2tikz(...
    'filename', ['../figures/bad-encoder-2d.tikz'], ...
    'width', '\linewidth', 'height', '0.75\linewidth', ...
    'extraTikzpictureOptions', {'trim axis left', 'trim axis right'}, ...
    'extraAxisOptions', {'axis equal'});

figure;
hold on;
plot(t, o(plant.out_frame.i.dwheel,:));
ylabel('wheel $\omega$ / $\si{\radian\per\second}$');
xlabel('time / $\si{\second}$')
matlab2tikz(...
    'filename', ['../figures/bad-encoder-dpos.tikz'], ...
    'width', '\linewidth', 'height', '0.75\linewidth', ...
    'extraTikzpictureOptions', {'trim axis left', 'trim axis right'}, ...
    'extraAxisOptions', {});