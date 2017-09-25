:- op(200, fx, ~).
:- op(500, xfy, v).

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

% czy jest jednym z elementow listy (Lista, element)
jeden_z([X], X) :- !.
jeden_z([H|_], H).
jeden_z([_|T], X):- jeden_z(T,X).

% generowanie wszystkich wartosciowan
wartosciuj([],[]).
wartosciuj([H|T], [(H, t)|S]) :- wartosciuj(T,S).
wartosciuj([H|T], [(H, f)|S]) :- wartosciuj(T,S).

% czy klauzula jest poprawna
poprawna([], _) :- false.
poprawna(~X v _, Wartosci) :- jeden_z(Wartosci,(X, f)), !.
poprawna(X v _, Wartosci) :- jeden_z(Wartosci, (X, t)), !.
poprawna(~X, Wartosci) :- jeden_z(Wartosci, (X, f)), !.
poprawna(X, Wartosci) :- jeden_z(Wartosci, (X, t)), !.
poprawna(_ v Klauzula, Wartosci) :- poprawna(Klauzula, Wartosci), !.
poprawna(_, _) :- false.

sprzeczna([],_) :-!.
sprzeczna(~X v Klauzule, Wartosci) :- jeden_z(Wartosci,(X, t)), !, sprzeczna(Klauzule, Wartosci).
sprzeczna(X v Klauzule, Wartosci) :- jeden_z(Wartosci, (X, f)), !, sprzeczna(Klauzule, Wartosci).
sprzeczna(~X, Wartosci) :- jeden_z(Wartosci, (X, t)), !.
sprzeczna(X, Wartosci) :- jeden_z(Wartosci, (X, f)), !.
sprzeczna(_, _) :- false.

% czy lista klauzul jest poprawna
valid_list([], _) :- true.
valid_list([H|T], Wartosci) :- poprawna(H, Wartosci), !,
                                valid_list(T, Wartosci).
valid_list(_,_) :- false.

% wyciaga zmienne z listy klauzul
zmienne_list([],[]).
zmienne_list([H|T], Zmienne) :- zmienne(H, ZmienneH),
                                zmienne_list(T, Pozostale),
                                append(ZmienneH, Pozostale, Zmienne1),
                                normalize(Zmienne1, Zmienne).

% generuje wartosciowania
solve(List, Wartosci) :- zmienne_list(List, Zmienne),
                        wartosciuj(Zmienne, Wartosci),
                        valid_list(List, Wartosci ).

gen_test(List, X) :- solve(List, Wartosci),
                    X=tests(val, validity, List, 500, solution(Wartosci)).
