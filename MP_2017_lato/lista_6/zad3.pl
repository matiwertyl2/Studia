insert(leaf, E, node(leaf, E, leaf)) :- !.
insert(node(L, X, R), E, node(L1, X, R)) :- E<X, !, insert(L, X, L1).
insert(node(L, X, R), E, node(L, X, R1)) :- E>X, !, insert(R, E, R1).


find(E, node(_, E, _)) :- !.
find(E, node(L, X, _)) :- E<X, !, find(E, L).
find(E, node(_, _, R)) :- find(E, R).

findMax(X, node(_, X, leaf)) :- !.
findMax(M, node(_, _, R)) :- findMax(M, R).


delMax(node(L, X, leaf), X, L) :- !.
delMax(node(L, X, R), M, node(L, X, R1)) :- delMax(R, M, R1).

delete(X, node(leaf, X, R), R) :- !.
delete(X, node(L, X, R), node(L1, Max, R)) :- delMax(L, Max, L1), !.
delete(E, node(L, X, R), node(L, X, R1)) :- E>X, !, delete(E, R, R1).
delete(E, node(L, X, R), node(L1, X, R)) :- delete(E, L, L1).

empty(leaf).
