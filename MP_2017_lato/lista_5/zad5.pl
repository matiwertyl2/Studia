merge([H1|T1], [H2|T2], [H1|Res]) :- H1 =< H2, !, merge(T1, [H2|T2], Res).
merge([H1|T1], [H2|T2], [H2|Res]) :- H2 =< H1, !, merge([H1|T1], T2, Res).
merge([], X, X) :- !.
merge(X, [], X) :-!.

utnij(X, 0, X) :-!.
utnij([_|T], N, Res) :- N1 is N-1, utnij(T, N1, Res).

merge_sort([H|_], 1, [H]) :-!.
merge_sort(Lista, N, Res) :- N mod 2 =:= 0, !, N1 is N/2,
                            merge_sort(Lista, N1, Res1),
                            utnij(Lista, N1, Lista1),
                            merge_sort(Lista1, N1, Res2),
                            merge(Res1, Res2, Res).

merge_sort(Lista, N, Res) :- N1 is (N-1)/2, N2 is (N+1)/2,
                            merge_sort(Lista, N1, Res1),
                            utnij(Lista, N1, Lista1),
                            merge_sort(Lista1, N2, Res2),
                            merge(Res1, Res2, Res).
