
dirs = struct();
dirs.sim_pre = 'P:\scenarios\unicycle\logs\nlds_7@aa982a8+ uniform_cost';
dirs.sim = 'P:\scenarios\unicycle\logs\nlds_10@1e09a71 17 degree cost';
dirs.hardware =	'C:\Users\wiese\Documents\Courses\Project\mlg-ctrl\scenarios\unicycle\logs\nlds_55@dc9584f+';

N = struct();
N.hardware = 23;  % only 23 hardware runs
N.sim = 40;
N.sim_pre = 40;

for f = fields(dirs)', f = f{1};
	fname = fullfile(dirs.(f), sprintf('%03d_H050.mat', N.(f)));
	this_data = load(fname);
	close(this_data.figures.policy_train);
	close(this_data.figures.policy_prev);
	close(this_data.figures.rollout);
	close(this_data.figures.dynamics);
	this_data.figures.loss.Name = sprintf('loss for %s', f);
	this_data.figures.states.Name = sprintf('states for %s', f);
	data.(f) = this_data;
end

%%
names = struct();
names.hardware = 'experimental';
names.sim = 'simulated';
names.sim_pre = 'simulated, before roll';

figure;
hold on;
xlabel('iteration number');
ylabel('time upright / $\si{\second}$');
for f = fields(dirs)', f = f{1};
	lengths = arrayfun(@(t) t.dt * size(t.observed, 2), data.(f).trajectories);
	plot(lengths, 'DisplayName', names.(f));
end
xlim([0.5, 50.5]);
ylim([-0.1, 2.6]);
legend('show', 'Location', 'northwest');
matlab2tikz(...
    'filename', ['../figures/learning-progress.tikz'], ...
    'width', '\linewidth', 'height', '5cm', ...
    'extraTikzpictureOptions', {'trim axis left', 'trim axis right'});

%{
hardware = load('C:\Users\wiese\Documents\Courses\Project\mlg-ctrl\scenarios\unicycle\logs\nlds_55@dc9584f+\023_H050.mat');
sim_pre_roll = load()
sim
%}