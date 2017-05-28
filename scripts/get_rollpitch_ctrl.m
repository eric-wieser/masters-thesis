function s = get_rollpitch_ctrl(ctrl)
	f_i = ctrl.in_frame.i;
	f_o = ctrl.out_frame.i;
	p = ctrl.policy.p;
	p1 = get_line(...
		p.w(f_o.ct, f_i.pitch), ...
		p.w(f_o.ct, f_i.roll), ...
		p.b(f_o.ct));
	p2 = get_line(...
		p.w(f_o.cw, f_i.pitch), ...
		p.w(f_o.cw, f_i.roll), ...
		p.b(f_o.cw));
	s = strjoin(['% ct'; p1; '% cw'; p2], sprintf('\n'));
end

function e = get_line(kp, kr, b)
	if kr > 0
		red = '\drawge';
		green = '\drawle';
	else
		red = '\drawle';
		green = '\drawge';
	end
	e = {
		sprintf('\\addplot[domain=-pi:pi, samples=2] {x*%f + %f};', kp/kr, -b/kr);
		sprintf('\\addplot[domain=-pi:pi, samples=2, draw=none, fill=green!25] {x*%f + %f} %s;', kp/kr, -b/kr, green);
		sprintf('\\addplot[domain=-pi:pi, samples=2, draw=none, fill=red!25] {x*%f + %f} %s;', kp/kr, -b/kr, red);
	}
end