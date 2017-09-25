pary(X, Y, Acc) :- Y is Acc,
		between(0, Y, X).

pary(X, Y, Acc) :- Acc1 is Acc +1,
		pary(X, Y, Acc1).

pairs(M, N) :- pary(M, N, 0).
