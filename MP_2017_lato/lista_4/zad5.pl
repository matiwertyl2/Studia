insert(E, leaf, node(leaf, E, leaf)) :- !.
insert(E, node(L, V, P), node(L1, V, P) ) :- E<V, !, insert(E, L, L1).
insert(E, node(L, V, P), node(L, V, P1)) :- insert(E, P, P1).

flatten(leaf, []) :- !.
flatten(node(X, Y, Z), Res) :- flatten(X, Res1), flatten(Z, Res2),
                              append(Res1, [Y|Res2], Res).

treesort(L, Res) :- wstaw_wszystkie(L, leaf, Drzewo),
                    flatten(Drzewo, Res).


wstaw_wszystkie([], Res, Res) :- !.
wstaw_wszystkie([H|T], Drzewo, Res) :- insert(H, Drzewo, Drzewo1),
                                      wstaw_wszystkie(T, Drzewo1, Res).
