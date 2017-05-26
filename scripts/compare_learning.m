
dirs = struct();
% dirs.sim_90 = 'P:\scenarios\unicycle\logs\nlds_7@aa982a8+ uniform_cost';
% dirs.sim_17 = 'P:\scenarios\unicycle\logs\nlds_8@9237313+ 17degree';
% dirs.sim_45 = 'P:\scenarios\unicycle\logs\nlds_15@c99a440+';
dirs.sim = 'P:\scenarios\unicycle\logs\nlds_10@1e09a71 17 degree cost';
dirs.hardware =	'C:\Users\wiese\Documents\Courses\Project\mlg-ctrl\scenarios\unicycle\logs\nlds_55@dc9584f+';

dirs.sim_nocost_17 = 'P:\scenarios\unicycle\logs\limit_nocost_17_1@917ba0a+';
dirs.sim_nocost_45 = 'P:\scenarios\unicycle\logs\limit_nocost_45_1@917ba0a+';
dirs.sim_nocost_90 = 'P:\scenarios\unicycle\logs\limit_nocost_90_1@917ba0a+';

dirs.sim_cost_17 = 'P:\scenarios\unicycle\logs\limit_cost_17_1@917ba0a+';
dirs.sim_cost_45 = 'P:\scenarios\unicycle\logs\limit_cost_45_1@917ba0a+';
dirs.sim_cost_90 = 'P:\scenarios\unicycle\logs\limit_cost_90_1@917ba0a+';

N = struct();
N.hardware = 23;  % only 23 hardware runs
N.sim = 40;
N.sim_nocost_17 = 40;
N.sim_nocost_45 = 40;
N.sim_nocost_90 = 40;
N.sim_cost_17 = 35;
N.sim_cost_45 = 35;
N.sim_cost_90 = 32;


for f = fields(dirs)', f = f{1};
	fname = fullfile(dirs.(f), sprintf('%03d_H050.mat', N.(f)));
	this_data = load(fname);
	% close(this_data.figures.policy_train);
	% close(this_data.figures.policy_prev);
	% close(this_data.figures.rollout);
	% close(this_data.figures.dynamics);
	close all;
	% this_data.figures.loss.Name = sprintf('loss for %s', f);
	% this_data.figures.states.Name = sprintf('states for %s', f);
	data.(f) = this_data;
end

%%
lengths = struct();
for f = fields(dirs)', f = f{1};
	lengths.(f) = arrayfun(@(t) t.dt * size(t.observed, 2), data.(f).trajectories);
end
%%
names = struct();
names.hardware = 'experimental';
names.sim = 'simulated';


plot_it_graph(lengths, names);
savetikz('learning-progress-iteration', '5cm');

plot_time_graph(lengths, names);
savetikz('learning-progress-time', '5cm');
%%
names = struct();
names.sim_nocost_90 = '\SI{90}{\degree}';
names.sim_nocost_45 = '\SI{45}{\degree}';
names.sim_nocost_17 = '\SI{17}{\degree}';

plot_time_graph(lengths, names);
savetikz('sim-lp-no-cost-time', '3cm');

plot_it_graph(lengths, names);
savetikz('sim-lp-no-cost-iteration', '3cm');
%%
names = struct();
names.sim_cost_90 = '\SI{90}{\degree}';
names.sim_cost_45 = '\SI{45}{\degree}';
names.sim_cost_17 = '\SI{17}{\degree}';

plot_time_graph(lengths, names);
savetikz('sim-lp-cost-time', '3cm');

plot_it_graph(lengths, names);
savetikz('sim-lp-cost-iteration', '3cm');
%%