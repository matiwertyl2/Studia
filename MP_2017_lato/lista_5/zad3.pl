
halve(X, L, R) :- halve(L, R, X, X).

halve([Y1|T], R, [Y1|S1], [_, _|S2]) :- !, halve(T, R, S1, S2).
halve([], R, R, _).
