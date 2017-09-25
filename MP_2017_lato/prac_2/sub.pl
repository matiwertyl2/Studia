

nadzbior(_, []) :- !.
nadzbior(X, [H|T]) :- member(H, X), !, nadzbior(X, T).

rm_nadzbiory(_, [], []) :- !.
rm_nadzbiory(K, [H|T], S) :- is_nadzbior(H, K), !, rm_nadzbiory(K, T, S).
rm_nadzbiory(K, [H|T], [H|S]) :- rm_nadzbiory(K, T, S).

is_nadzbior(K1, K2) :- K1=(P1, N1, _, _), K2=(P2, N2, _, _),
                      nadzbior(P1, P2), nadzbior(N1, N2).

jest_nadzbiorem(K, [H|_]) :- is_nadzbior(K, H), !.
jest_nadzbiorem(K, [_|T]) :- jest_nadzbiorem(K, T).

dlugosc(K, D) :- K=(P, N, _, _), length(P, D1), length(N, D2), D is D1+D2.

sub(H, A, A) :- jest_nadzbiorem(H, A), !.
sub(H, A, A1) :- wstaw_usun(H, A, A1).

wstaw_usun(K, [], [K]):- !.
wstaw_usun(K, [H|T], [H|S]) :- dlugosc(K, D1), dlugosc(H, D2), D1>D2, !, wstaw_usun(K, T, S).
wstaw_usun(K, A, [K|Rest])  :- rm_nadzbiory(K, A, Rest).

subsumpcja([], X, X):-!.
subsumpcja([H|T], A, Res) :- sub(H, A, A1), subsumpcja(T, A1, Res).
