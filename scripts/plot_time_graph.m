
function plot_time_graph(lengths, names)
	figure;
	hold on;
	xlabel('total experience / $\si{\second}$');
	ylabel('time upright / $\si{\second}$');
	for f = fields(names)', f = f{1};
		plot(cumsum(lengths.(f)), lengths.(f), 'DisplayName', names.(f));
	end
	ylim([-0.1, 2.6]);
	xlim([0, 40]);
	l = legend('show', 'Location', 'northwest'); %,'Interpreter','latex');
	l.Interpreter = 'latex';
end