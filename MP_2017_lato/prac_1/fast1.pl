:- op(200, fx, ~).
:- op(500, xfy, v).

solve(Klauzule, Res) :- przygotuj_klauzule(Klauzule, Gotowe),
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

append([], X, X).
append([H|T], S, [H|W]) :- append(T,S,W).

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

% wybiera zmienna nie z listy wartosci i robi poprawnosc klauzuli, plus te co musza juz byc zle
% (klauzula, Wartosci, zmienna, zle) - jest poprawna dzieki temu ze zmienna jest dobra a wszystko przed nia - zle
%zrob_poprawna([], _, _, _):- false.
%zrob_poprawna(~X v Klauzula, Wartosci, Res, Zle) :- jeden_z(Wartosci, (X, t)), !, zrob_poprawna(Klauzula, Wartosci, Res, Zle).
%zrob_poprawna(X v Klauzula, Wartosci, Res, Zle) :- jeden_z(Wartosci, (X, f)), !, zrob_poprawna(Klauzula, Wartosci, Res, Zle).
%zrob_poprawna(~X v _, _, (X, f), []).
%zrob_poprawna(~X v Klauzule, Wartosci, Res, [(X, t)|Zle] ) :- !, zrob_poprawna(Klauzule, Wartosci, Res, Zle).
%zrob_poprawna(X v _, _, (X, t), []).
%zrob_poprawna(X v Klauzule, Wartosci, Res, [(X, f)|Zle]) :- !, zrob_poprawna(Klauzule, Wartosci, Res, Zle).
%zrob_poprawna(~X, Wartosci, _, _) :- jeden_z(Wartosci, (X, t)), !, false.
%zrob_poprawna(X, Wartosci, _,_) :- jeden_z(Wartosci, (X, f)), !, false.
%zrob_poprawna(~X, _, (X, f), []) :- !.
%zrob_poprawna(X, _, (X, t), []) :-!.

backtrack([], _, _) :- false.
backtrack([(X, t)|_], Wartosci, [(X, t)|Wartosci]).
backtrack([(X, f)|_], Wartosci, [(X, f)|Wartosci]).
backtrack([(X, t)|T], Wartosci, [(X, f) |Res]) :- backtrack(T, Wartosci, Res).
backtrack([(X, f)|T], Wartosci, [(X, t)|Res]) :- backtrack(T, Wartosci, Res).

zrob_poprawna(Klauzula, Wartosci, Res) :- listuj_klauzule(Klauzula, L1),
                                          usun_uzywane(L1, Wartosci, L),
                                          backtrack(L, Wartosci, Res).

wartosciuj([], X, X). % jak nie ma klauzul wiecej
wartosciuj([H|Klauzule], Wartosci, Res) :- poprawna(H, Wartosci), !, wartosciuj(Klauzule, Wartosci, Res).
wartosciuj([H|Klauzule], Wartosci, Res) :- zrob_poprawna(H, Wartosci, Wartoscinowe),
                                          wartosciuj(Klauzule, Wartoscinowe, Res).

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

%usuwa uzywane zmienne
usun_uzywane([], _, []).
usun_uzywane([H|T], Wartosci, Res) :- member(H, Wartosci), !, usun_uzywane(T, Wartosci, Res).
usun_uzywane([H|T], Wartosci, [H|Res]) :- usun_uzywane(T, Wartosci, Res).
