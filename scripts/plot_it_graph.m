
function plot_it_graph(lengths, names)
	figure;
	hold on;
	xlabel('iteration number');
	ylabel('time upright / $\si{\second}$');
	for f = fields(names)', f = f{1};
		plot(lengths.(f), 'DisplayName', names.(f));
	end
	xlim([0.5, 50.5]);
	ylim([-0.1, 2.6]);
	l = legend('show', 'Location', 'northwest');
	l.Interpreter = 'latex';
end
