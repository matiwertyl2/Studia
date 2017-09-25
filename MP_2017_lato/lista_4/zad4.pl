mirror(leaf, leaf) :- !.
mirror(node(Y, X, Z), node(Z1, X, Y1)) :- mirror(Z, Z1), mirror(Y, Y1).

flatten(Drzewo, Res) :- flatten(Drzewo, [], Res).
flatten(leaf, Res, Res).
flatten(node(X, Y, Z), A, Res) :- flatten(Z, A, Res1), flatten(X, [Y|Res1], Res).

append([], X, X).
append([H|T], S, [H|R]) :- append(T, S, R).
