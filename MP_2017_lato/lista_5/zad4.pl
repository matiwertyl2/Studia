merge([H1|T1], [H2|T2], [H1|Res]) :- H1 =< H2, !, merge(T1, [H2|T2], Res).
merge([H1|T1], [H2|T2], [H2|Res]) :- H2 =< H1, !, merge([H1|T1], T2, Res).
merge([], X, X) :- !.
merge(X, [], X) :-!.


halve(X, L, R) :- halve(L, R, X, X).

halve([Y1|T], R, [Y1|S1], [_, _|S2]) :- !, halve(T, R, S1, S2).
halve([], R, R, _).

merge_sort([],[]) :- !.
merge_sort([X], [X]) :- !.
merge_sort(Lista, Res) :- halve(Lista, L, R),
                          merge_sort(L, L1),
                          merge_sort(R, R1),
                          merge(L1, R1, Res).
