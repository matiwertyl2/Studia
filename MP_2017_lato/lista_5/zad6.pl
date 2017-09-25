merge_sort(List, Res) :- singletons(List, L),
                        scal(L, [Res]).

singletons([],[]) :-!.
singletons([H|T], [[H]|S]) :- singletons(T, S).

scal([X], [X]) :- !.
scal([], []) :-!.


scal([L1, L2|T], Res) :- scal(T, Res1), merge(L1, L2, Lmerged),
                        scal([Lmerged|Res1], Res).

merge([H1|T1], [H2|T2], [H1|Res]) :- H1 =< H2, !, merge(T1, [H2|T2], Res).
merge([H1|T1], [H2|T2], [H2|Res]) :- H2 =< H1, !, merge([H1|T1], T2, Res).
merge([], X, X) :- !.
merge(X, [], X) :-!.
