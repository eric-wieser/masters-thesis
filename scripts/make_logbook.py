import pickle

with open('../../data.pickle', 'rb') as f:
	data = pickle.load(f)

with open('../logs.tex', 'w') as f:
	print(R'\begin{description}', file=f)
	for date, which, message in data:

		print('  \\item[{} -- {}] \\hfill \\'.format(date.date().isoformat(), which), file=f)
		print('\\begin{{lstlisting}}\n{}\\end{{lstlisting}}\n\n'.format(message), file=f)

	print(R'\end{description}', file=f)