
dirs = struct();
% dirs.sim_90 = 'P:\scenarios\unicycle\logs\nlds_7@aa982a8+ uniform_cost';
% dirs.sim_17 = 'P:\scenarios\unicycle\logs\nlds_8@9237313+ 17degree';
% dirs.sim_45 = 'P:\scenarios\unicycle\logs\nlds_15@c99a440+';
% dirs.sim = 'P:\scenarios\unicycle\logs\nlds_10@1e09a71 17 degree cost';
dirs.hardware1 =	'C:\Users\wiese\Documents\Courses\Project\mlg-ctrl\scenarios\unicycle\logs\nlds_55@dc9584f+ hardware';
dirs.hardware2 = 'C:\Users\wiese\Documents\Courses\Project\mlg-ctrl\scenarios\unicycle\logs\nlds_77@9a78f4e+';
dirs.sim_nocost_17 = 'P:\scenarios\unicycle\logs\limit_nocost_17_1@917ba0a+';
dirs.sim_nocost_45 = 'P:\scenarios\unicycle\logs\limit_nocost_45_1@917ba0a+';
dirs.sim_nocost_90 = 'P:\scenarios\unicycle\logs\limit_nocost_90_1@917ba0a+';

dirs.sim_cost_17 = 'P:\scenarios\unicycle\logs\limit_cost_17_1@917ba0a+';
dirs.sim_cost_45 = 'P:\scenarios\unicycle\logs\limit_cost_45_1@917ba0a+';
dirs.sim_cost_90 = 'P:\scenarios\unicycle\logs\limit_cost_90_1@917ba0a+';

N = struct();
N.hardware1 = 23;  % only 23 hardware runs
N.hardware2 = 40;
N.sim = 40;
N.sim_nocost_17 = 40;
N.sim_nocost_45 = 40;
N.sim_nocost_90 = 40;
N.sim_cost_17 = 40;
N.sim_cost_45 = 40;
N.sim_cost_90 = 40;


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
	lengths.(f) = arrayfun(@(t) t.dt * size(t.action, 2), data.(f).trajectories);
end
lengths.hardware1 = lengths.hardware1 - data.hardware1.trajectories(1).dt;
%%
names = struct();
names.hardware1 = 'experiment 1';
names.hardware2 = 'experiment 2';
names.sim_cost_17 = 'simulated';


plot_it_graph(lengths, names);
grid on;
savetikz('learning-progress-iteration', '5cm');

plot_time_graph(lengths, names);
grid on;
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