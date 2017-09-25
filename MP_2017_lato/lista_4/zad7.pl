reverse(L, Res) :- reverse(L, [], Res).

reverse([], Res, Res).
reverse([H|T], A, Res) :- reverse(T, [H|A], Res).

revall([], []) :- !.
revall(List, Res) :- reverse(List, RevList),
                    odwroc_w_srodku(RevList, Res).

odwroc_w_srodku([],[]) :- !.
odwroc_w_srodku([[H|T]| Ogon], [Hrev|Ogonrev]) :- !,revall([H|T], Hrev),
                                                  odwroc_w_srodku(Ogon, Ogonrev).
odwroc_w_srodku([X|Ogon], [X|Ogonrev]) :- odwroc_w_srodku(Ogon, Ogonrev).
