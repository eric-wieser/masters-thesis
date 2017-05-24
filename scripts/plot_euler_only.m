% load('bad_euler.mat')

t = make_times(traj.dt, traj.observed);

figure;
hold on;
h = [];
h(end+1) = plot(t, traj.observed(plant.out_frame.i.yaw,:), 'DisplayName', 'yaw');
h(end+1) = plot(t, traj.observed(plant.out_frame.i.pitch,:), 'DisplayName', 'pitch');
h(end+1) = plot(t, traj.observed(plant.out_frame.i.roll,:), 'DisplayName', 'roll');
legend(h, 'Orientation', 'horizontal', 'Location', 'southoutside');
yticks([-pi, -pi/2, 0, pi/2, pi]);
xlim([2, 5])
xticklabels([])
yticklabels({'$-\pi$', '$-\frac{\pi}{2}$', '$0$', '$\frac{\pi}{2}$', '$\pi$'})
ylabel('angle / \si{\degree}')
xlabel('time')
matlab2tikz(...
    'filename', ['../figures/bad-euler.tikz'], ...
    'width', '\linewidth', 'height', '3cm', ...
    'extraTikzpictureOptions', {'trim axis left', 'trim axis right'});

%%
try
	i = 56; unicycle.draw(struct('m', traj.observed(:,i)), traj.action(:,i), cost, [], [], [], [], Reference);
catch
end
delete(gca);
xlabel('');
ylabel('');
zlabel('');
xticklabels({});
yticklabels({});
zticklabels({});
matlab2tikz(...
    'filename', ['../figures/bad-euler-frame1.tikz'], ...
    'width', '\linewidth', 'height', '0.75\linewidth', ...
    'extraTikzpictureOptions', {'trim axis left', 'trim axis right'}, ...
    'extraAxisOptions', {'axis equal'});

try
	i = 58; unicycle.draw(struct('m', traj.observed(:,i)), traj.action(:,i), cost, [], [], [], [], Reference);
catch
end
delete(gca);
xlabel('');
ylabel('');
zlabel('');
xticklabels({});
yticklabels({});
zticklabels({});
matlab2tikz(...
    'filename', ['../figures/bad-euler-frame2.tikz'], ...
    'width', '\linewidth', 'height', '0.75\linewidth', ...
    'extraTikzpictureOptions', {'trim axis left', 'trim axis right'}, ...
    'extraAxisOptions', {'axis equal'});
