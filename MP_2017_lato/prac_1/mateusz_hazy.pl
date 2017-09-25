:- module(mateusz_hazy, [solve/2]).


:- op(200, fx, ~).
:- op(500, xfy, v).


solve(Klauzule, Res) :- przygotuj_klauzule(Klauzule, Gotowane),
                        sortuj(Gotowane, Gotowe),
                        wartosciuj(Gotowe, [], Res1),
                        zmienne_list(Klauzule, Zmienne),
                        usun_uzyte(Zmienne, Res1, Zmienne_nowe),
                       dolacz_x(Zmienne_nowe, Zmienne_niewazne),
                        append(Res1, Zmienne_niewazne, Res).

% pomocnicze
% ==============================================================================
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

%==============================================================================

% wyciaga zmienne
zmienne(~X v Klauzula, [X|Res]) :- !, zmienne(Klauzula, Res).
zmienne(X v Klauzula, [X|Res]) :- !, zmienne(Klauzula, Res).
zmienne(~X,[X]) :-!.
zmienne(X,[X]) :- !.

% usuwa powtorzenia
normalize([],[]) :- !.
normalize([H|T], S) :- jeden_z(T, H),
                        normalize(T,S), !.
normalize([H|T],[H|S]) :- normalize(T,S).

dolacz_x([],[]).
dolacz_x([H|T],[(H, x)|S]) :- dolacz_x(T,S).

% wyciaga zmienne z listy klauzul
zmienne_list([],[]).
zmienne_list([H|T], Zmienne) :- zmienne(H, ZmienneH),
                                zmienne_list(T, Pozostale),
                                append(ZmienneH, Pozostale, Zmienne1),
                                normalize(Zmienne1, Zmienne).


wartosciuj([], X, X). % jak nie ma klauzul wiecej
wartosciuj([[]|_], _,_):- !, false.
wartosciuj([~X v _|Klauzule], Wartosci, Res) :- propaguj((X, f), Klauzule, Klauzule1),
                                                  wartosciuj(Klauzule1, [(X, f)|Wartosci], Res).
wartosciuj([~X v Ogon|Klauzule], Wartosci, Res) :- !, propaguj((X, t), [Ogon|Klauzule], Klauzule1),
                                                  wartosciuj(Klauzule1, [(X, t)|Wartosci], Res).
wartosciuj([X v _|Klauzule], Wartosci, Res) :- propaguj((X, t), Klauzule, Klauzule1),
                                              wartosciuj(Klauzule1, [(X, t)|Wartosci], Res).
wartosciuj([X v Ogon|Klauzule], Wartosci, Res) :- !, propaguj((X, f), [Ogon|Klauzule], Klauzule1),
                                            wartosciuj(Klauzule1, [(X, f)|Wartosci], Res).
wartosciuj([~X|Klauzule], Wartosci, Res) :- !, propaguj((X, f), Klauzule, Klauzule1),
                                            wartosciuj(Klauzule1, [(X, f)|Wartosci], Res).
wartosciuj([X|Klauzule], Wartosci, Res) :- !, propaguj((X, t), Klauzule, Klauzule1),
                                            wartosciuj(Klauzule1, [(X, t)|Wartosci], Res).

propaguj(_, [], []) :- !.
propaguj(X, [H|T], Res) :- poprawna(H, [X]), !, propaguj(X, T, Res).
propaguj(X, [H|T], [H1|Res]) :- usun_elem(X, H, H1), propaguj(X, T, Res).

usun_ten_element([],_, []) :- !.
usun_ten_element([(X, _)|T], (X, Y), Res) :- !, usun_ten_element(T, (X, Y), Res ).
usun_ten_element([(X, Y)|T], E, [(X, Y)|Res]) :- !, usun_ten_element(T, E, Res).

usun_elem(X, Klauzula, Res) :- listuj_klauzule(Klauzula, L),
                                  usun_ten_element(L, X, Nowa),
                                  klauzuluj_liste(Nowa, Res).

klauzuluj_liste([], _) :- !, false.
klauzuluj_liste([(X, t)], X) :- !.
klauzuluj_liste([(X, f)], ~X) :-!.
klauzuluj_liste([(X, t)|T], X v Rest) :- !, klauzuluj_liste(T, Rest).
klauzuluj_liste([(X, f)|T], ~X v Rest) :- !, klauzuluj_liste(T, Rest).

% usuwa uzywane zmienne
usun_uzyte([],_,[]).
usun_uzyte([H|T], Uzyte, Res) :- jeden_z(Uzyte, (H, _)), !, usun_uzyte(T, Uzyte, Res).
usun_uzyte([H|T], Uzyte, [H|Res]) :- usun_uzyte(T, Uzyte, Res).

% czy jest jednym z elementow listy (Lista, element)
jeden_z(L, X) :- member(X,L).

% czy klauzula jest poprawna
poprawna(Klauzula, Wartosci) :- listuj_klauzule(Klauzula, L), member(X, L), member(X, Wartosci), !.

% robi liste z klauzuli
listuj_klauzule([],[]) :- !.
listuj_klauzule(~X v Klauzula, [(X, f)|Rest]) :- !, listuj_klauzule(Klauzula, Rest).
listuj_klauzule(X v Klauzula, [(X, t)|Rest]) :- !, listuj_klauzule(Klauzula, Rest).
listuj_klauzule(~X, [(X, f)]) :- !.
listuj_klauzule(X, [(X, t)]):- !.

% =================================================================
% sortowanie po dlugosci

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
% =========================================================
