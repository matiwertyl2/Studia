:- op(200, fx, ~).
:- op(500, xfy, v).

% znajduje  dana zmienna w klauzuli
znajdz(X v _, X):- !.
znajdz(X, X) :- !.
znajdz(_ v Klauzula, X):- znajdz(Klauzula, X).

% usuwa powtorzenia w klauzuli
usun_rep(~X v Klauzula, Res) :- znajdz(Klauzula, ~X), !, usun_rep(Klauzula, Res ).
usun_rep(~X v Klauzula, ~X v Res) :- !, usun_rep(Klauzula, Res).
usun_rep(X v Klauzula, Res) :- znajdz(Klauzula, X), !, usun_rep(Klauzula, Res).
usun_rep(X v Klauzula, X v Res) :- !, usun_rep(Klauzula, Res).
usun_rep(~X, ~X):- !.
usun_rep(X, X) :- !.

% czy klauzula jest tautologia
taut(Klauzula) :- znajdz(Klauzula, ~X),
                  znajdz(Klauzula, X),
                  !.

% usuwa powtorzenia z klauzul z listy
bez_powtorzen([],[]) :- !.
bez_powtorzen([A|T], [B|S]) :- usun_rep(A, B),
                                bez_powtorzen(T,S).

% usuwa tautologie z listy
bez_taut([],[]) :- !.
bez_taut([H|T], Res) :- taut(H), !, bez_taut(T,Res).
bez_taut([H|T], [H|Res]) :- bez_taut(T,Res).

% usuwa pwotorzenia i tautologie
przygotuj_klauzule(Klauzule, Res) :- bez_powtorzen(Klauzule, Res1),
                                    bez_taut(Res1, Res).

listuj_klauzule([],[]) :- !.
listuj_klauzule(~X v Klauzula, [(X, f)|Rest]) :- !, listuj_klauzule(Klauzula, Rest).
listuj_klauzule(X v Klauzula, [(X, t)|Rest]) :- !, listuj_klauzule(Klauzula, Rest).
listuj_klauzule(~X, [(X, f)]) :- !.
listuj_klauzule(X, [(X, t)]):- !.

%usuwa uzywane zmienne
usun_uzywane([], _, []).
usun_uzywane([H|T], Wartosci, Res) :- member(H, Wartosci), !, usun_uzywane(T, Wartosci, Res).
usun_uzywane([H|T], Wartosci, [H|Res]) :- usun_uzywane(T, Wartosci, Res).

dlugosc(Klauzula, Res) :- dlugosc(Klauzula, 0, Res).
dlugosc([],Res, Res) :-!.
dlugosc(~_ v Klauzula, A, Res) :- !, A1 is A+1, dlugosc(Klauzula, A1, Res).
dlugosc(_ v Klauzula, A, Res) :- !, A1 is A+1, dlugosc(Klauzula, A1, Res).
dlugosc(~_, A, Res) :- !,Res is A+1.
dlugosc(_, A, Res) :- !, Res is A+1.

dlugosci([],[]).
dlugosci([H|T], [(H, D)|S]) :- dlugosc(H, D), dlugosci(T, S).

select_min([X], X,[]) :- !.
select_min([(K, D)|Klauzule], Min, Rest) :- select_min(Klauzule, (K1, D1), Rest1),
                                            D1<D, !,
                                            Min=(K1, D1), Rest=[(K, D)|Rest1].
select_min([H|Klauzule], H, Klauzule) :- !.

select_sort([], []) :- !.
select_sort(L, [Min|S]) :- select_min(L, Min, Rest),
                            select_sort(Rest, S).

wynik_sort([],[]).
wynik_sort([(H, _)|T], [H|S]) :- wynik_sort(T, S).

sortuj(Klauzule, Res) :- dlugosci(Klauzule, KzD),
                        select_sort(KzD, Res1),
                        wynik_sort(Res1, Res).
