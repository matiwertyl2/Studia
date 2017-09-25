split([], _, [], []).
split([H|T], Med, [H|Small], Big) :- H<Med, !, split(T, Med, Small, Big).
split([H|T], Med, Small, [H|Big]) :- split(T, Med, Small, Big).



qsort([H|T], Res) :- qsort([H|T], [], Res).

qsort([], Res, Res).

qsort([H|T], A, Res) :- split(T, H, Small, Big),
                        qsort(Big, A, Res1),
                        qsort(Small, [H|Res1], Res).
