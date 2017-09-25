:- module(mateusz_hazy, [resolve/4, prove/2]).

:- op(200, fx, ~).
:- op(500, xfy, v).

prove(K, _) :- solve(K, _), !, false.
prove(K, Res) :- init(K, K1, 1),
                normalize(K1, K3),
                licz_d(K3, K4),
                length_sort(K4, K2),
                get_literals(K2, Literals),
                sort(Literals, Literals1),
                generate_clauses([], K2, Clauses, Literals1),
            %    all_clauses(Clauses, Res).
                create_proof(Clauses, Proof),
                end_result(Proof, Res).


%==============================================================================

end_result([], []) :- !.
end_result([K|T], [(Clause, axiom) |S]) :- K=(_, P, N, _, axiom), !,
                                          clause(P, N, Clause),
                                          end_result(T, S).
end_result([K|T], [(Clause, (A, B, C))|S] ) :- K=(_, P, N, _, r(A, B ,C)),
                                          clause(P, N, Clause),
                                          end_result(T, S).
% =============================================================================
% glowna petla generowania rezolwent % wymaga naprawienia
generate_clauses(X, _, X, _) :- member((_, [], [], _, _), X), !.
generate_clauses(X, [], X, _) :- !.
%generate_clauses(_,X, X).
%generate_clauses(A, [H|T], Res) :- rezolw_all(H, A, Res1), normalize(Res1, Res).
generate_clauses(A, [H|T], Res, Zmienne) :- H=(D, _, _, _, _),
                                    (D<3, !; Zmienne=[] ), !,
                                    rezolw_all(H, A, New),
                                    normalize(New, Newtmp),
                                    licz_d(Newtmp, New1),
                                    length_sort(New1, New2),
                                    subsumpcja([H], A, A1),
                                    append(A1, T, T1),
                                    length_sort(T1, T2),
                                    subsumpcja(New2, T2, B),
                                    normalize(B, A1, B1),
                                    get_literals_if_empty(Zmienne, B1,  Vars),
                                    generate_clauses(A1, B1, Res, Vars).
generate_clauses(A, Bold, Res, [P|Zmienne]) :- get_clause(P, Bold, H, T),!,
                                                rezolw_all(H, A, New),
                                                normalize(New, Newtmp),
                                                licz_d(Newtmp, New1),
                                                length_sort(New1, New2),
                                                subsumpcja([H], A, A1),
                                                append(A1, T, T1),
                                                length_sort(T1, T2),
                                                subsumpcja(New2, T2, B),
                                                normalize(B, A1, B1),
                                                generate_clauses(A1, B1, Res, [P|Zmienne] ).
generate_clauses(A, B, Res, [_|Zmienne])  :- generate_clauses(A, B, Res, Zmienne).
%================================================================================
get_clause(_, [], _, _)  :- !, false.
get_clause(Var, [H|T], H, T)    :- H=(_, P, N, _, _), (member(Var, P), !; member(Var, N) ), !.
get_clause(Var, [H|T], A, [H|S]) :- get_clause(Var, T, A, S).

get_literals(List, Res) :- get_literals(List, [], Res).
get_literals([], A, A):-!.
get_literals([H|T], A, Res) :- H=(_, P, N, _, _),
                              append(P, N, New),
                              append(New, A, A1),
                              get_literals(T, A1, Res).
get_literals_if_empty([], List, Res) :- !, get_literals(List, Res1), sort(Res1, Res).
get_literals_if_empty(X, _, X).
%==============================================================================
% wraca sie w dowodzie
create_proof(Clauses, Proof) :- empty_clause(Clauses, E),
                                E=(_, [], [], _, axiom), !,
                                Proof=[E].
create_proof(Clauses, Proof) :- empty_clause(Clauses, E),
                                E=(_, [], [], _, r(Var, K1, K2)),
                                sources(K1, Proof1, 1, Cnt),
                                sources(K2, Proof2, Cnt, Cnt1),
                                K1=(_, _, _, Nr1, _),
                                K2=(_, _,_, Nr2, _),
                               append(Proof1, Proof2, Proof3),
                               append(Proof3, [(_, [], [], Cnt1, r(Var, Nr1, Nr2))], Proof).


% rekurencyjnie idzie do tych z ktorych dana klauzula powstala
% cnt -licznik poczatkowy, cnt1/res - licznik koncowy
sources(K, [K], Cnt, Cnt1) :- K=(_, _, _, Nr, axiom), var(Nr),!, Nr=Cnt, Cnt1 is Cnt+1.
sources(K, [], Cnt,Cnt) :- K=(_, _, _, Nr, _), nonvar(Nr), !.
sources(K, Res, Cnt, CntRes) :- K=(_, P, N, Cnt2, r(Var, K1, K2)),
                    sources(K1, Res1, Cnt, Cnt1),
                    sources(K2, Res2, Cnt1, Cnt2),
                    append(Res1, Res2, Res3),
                    K1=(_, _, _, Nr1, _),
                    K2=(_, _, _, Nr2, _),
                    append(Res3, [(_, P, N, Cnt2, r(Var, Nr1, Nr2) )], Res),
                    CntRes is Cnt2+1.

empty_clause([], _) :- !, false.
empty_clause([(_, [],[], Nr, Origin)|_], (_, [], [], Nr, Origin) ) :- !.
empty_clause([_|T], Res) :- empty_clause(T, Res).
%==============================================================================
% bazowa rezolwenta
rezolw(X, K1, K2, K) :- K1=(_, P1, N1, _, _),
                        K2=(_, P2, N2, _, _),
                        member(X, P1), member(X, N2), !,
                        select(X, P1, P1prim), select(X, N2, N2prim),
                        append(P1prim, P2, P), append(N1, N2prim, N),
                        K=(_, P, N, _, r(X, K1, K2)).
rezolw(X, K1, K2, K) :- K1=(_, P1, N1, _, _),
                        K2=(_, P2, N2, _, _),
                        member(X, N1), member(X, P2),
                        select(X, N1, N1prim), select(X, P2, P2prim),
                        append(N1prim, N2, N), append(P1, P2prim, P),
                        K=(_, P, N, _, r(X, K2, K1)).

% bierze 2 klauzule i produkuje wszystkie rezolwenty
rezolw1(K1, K2, Res) :- K1=(_, P1, N1, _, _), merge(P1, N1, L),
                        rezolw2(L, K1, K2, Res), !.

% pomocnicze do rezolw1
rezolw2([], _, _, []):- !.
rezolw2([X|_], K1, K2, [K]) :- rezolw(X, K1, K2, K),!. % rezolw2(T, K1, K2, Rest).
rezolw2([_|T], K1, K2, Rest):- rezolw2(T, K1, K2, Rest).


% wszystkie rezolwenty danej klauzuli z lista klauzul (pomocnicze)
rezolw_all1(_, [], X, X) :- !.
rezolw_all1(C, [K|T], A, Res):-  rezolw1(C, K, Res1),
                            append(Res1, A, A1), rezolw_all1(C, T, A1, Res).

% wszystkie rezolwenty klauzuli K z lista List
rezolw_all(K, List, Res) :- rezolw_all1(K, List, [],  Res).
%===============================================================================
% normalizacja

normalize(L, Res) :- sort_list(L, L1), rm_taut(L1, Res),!.

% usuwa te z B co sa w A
normalize(B, A, Res) :-rm_rep(B, A, Res).

rm_rep([], _, []) :-!.
rm_rep([K|T], A, S) :- K=(_, P, N, _, _), member((_, P, N, _, _), A), !, rm_rep(T, A, S).
rm_rep([K|T], A, [K|S]) :- rm_rep(T, A, S).


rm_taut([], []):- !.
rm_taut([H|T], S) :- H=(_, P, N, _, _), is_taut(P, N),! ,
                      rm_taut(T, S).
rm_taut([H|T], [H|S]) :- rm_taut(T, S).

is_taut([H|_], [H|_]) :- !.
is_taut([H1|T1], [H2|T2]) :- compare((<), H1, H2), !, is_taut(T1, [H2|T2]).
is_taut(L, [_|T]) :- is_taut(L, T).
%===============================================================================

% inicjalizacja klauzul wejsciowych
init([], [], _):- !.
init([H|T], [(_, P, N, _, axiom)|S], Nr) :- listuj(H, P, N), Nr1 is Nr+1, init(T,S, Nr1 ).

% zmienia klauzule na listy
listuj([], [], []) :- !.
listuj(~X v K, P, [X|N]) :- !, listuj(K, P, N).
listuj(X v K, [X|P], N) :- !, listuj(K, P, N).
listuj(~X, [], [X]) :- !.
listuj(X, [X], []) :- !.

% zmienia listy na klauzule
clause([],[], []) :- !.
clause([X], [], X) :- !.
clause([H|T], L, H v K) :- !, clause(T, L, K).
clause([], [X], ~X) :- !.
clause([], [H|T], ~H v K) :- !, clause([], T, K).

% czy jest elementem listy z odcieciem
memb(_, []) :- !, false.
memb(X, [X|_]):- !.
memb(X, [_|T]) :- memb(X, T).


% laczy listy bez wybranego elementu lista lista element wynik
merge([], [], _, []) :- !.
merge([], [H|T], H, S) :- !, merge([], T, H, S).
merge([], [H|T], X, [H|S]) :- !, merge([], T, X, S).
merge([H|T], L, H, S) :- !, merge(T, L, H, S).
merge([H|T], L, X, [H|S] ) :- !, merge(T, L, X, S).

append([], X, X).
append([H|T], S, [H|R]) :- append(T, S, R).

%===============================================================================
% sortowanie

sort_list([], []):- !.
sort_list([(D, P1, N1, Nr, Or)|T], [(D, P, N, Nr, Or)|S]) :- sort(P1, P),
                                                      sort(N1, N),
                                                      sort_list(T, S).

merge([H1|T1], [H2|T2], [H1|Res]) :- compare((<), H1, H2), !, merge(T1, [H2|T2], Res).
merge([H1|T1], [H2|T2], [H2|Res]) :- !, merge([H1|T1], T2, Res).
merge([], X, X) :- !.
merge(X, [], X) :-!.

length_sort(List, Res) :- sort(List, Res).


 pair_length([], []) :-!.
 pair_length([H|T], [H1|S]) :- H=(_, P, N, _, _), length(P, X1), length(N, X2), X is X1 + X2,
                              H1=(X, H), pair_length(T, S).

 lsort_res([], []) :- !.
 lsort_res([(_, H)|T], [H|S]) :- lsort_res(T, S).
%===============================================================================

% resolve

resolve(X, K1, K2, Res) :- listuj(K1, P1s, N1s), listuj(K2, P2s, N2s),
                            sort(P1s, P1), sort(P2s, P2), sort(N1s, N1), sort(N2s, N2),
                            member(X, P1), member(X, N2), !,
                            select(X, P1, P1prim), select(X, N2, N2prim),
                            merge(P1prim, P2, P), merge(N1, N2prim, N),
                            clause(P, N, Res).

select(X, [X|T], T) :- !.
select(X, [H|T], [H|S]) :- select(X, T, S).


all_clauses([], []) :- !.
all_clauses([H|T], [H1|S]) :- H=(P, N, _, _), clause(P, N, H1), all_clauses(T, S).

licz_d([], []) :-!.
licz_d([H|T], [H|S]) :- H=(D, P, N, _, _),
                        length(P, D1), length(N, D2),
                        D is D1+D2, licz_d(T, S).

%================================================================================

nadzbior(_, []) :- !.
nadzbior([H1|T1], [H1|T2]) :- !, nadzbior(T1, T2).
nadzbior([H1|T1], [H2|T2]) :- compare((<), H1, H2), !, nadzbior(T1, [H2|T2]).
nadzbior(_, _) :- !, false.

rm_nadzbiory(_, [], []) :- !.
rm_nadzbiory(K, [H|T], S) :- is_nadzbior(H, K), !, rm_nadzbiory(K, T, S).
rm_nadzbiory(K, [H|T], [H|S]) :- rm_nadzbiory(K, T, S).

is_nadzbior(K1, K2) :- K1=(_, P1, N1, _, _), K2=(_, P2, N2, _, _),
                      nadzbior(P1, P2), nadzbior(N1, N2).

jest_nadzbiorem(K, [H|_]) :- is_nadzbior(K, H), !.
jest_nadzbiorem(K, [_|T]) :- jest_nadzbiorem(K, T).


%sub(H, A, A) :- jest_nadzbiorem(H, A), !.
%sub(H, A, A1) :- wstaw_usun(H, A, A1).

sub(H, [H1|T], [H1|T]) :- H=(D1, _, _, _, _), H1=(D2, _, _, _, _),D1>D2,
                            is_nadzbior(H, H1), !.
sub(H, [H1|T], [H1|S]) :- H=(D1, _, _, _, _), H1=(D2, _, _, _, _),D1>D2, !,
                            sub(H, T, S).
sub(H, A, A1) :- wstaw_usun(H, A, A1).



wstaw_usun(K, [], [K]):- !.
wstaw_usun(K, [H|T], [H|S]) :- K=(D1, _, _, _, _), H=(D2, _, _, _, _), D1>D2, !, wstaw_usun(K, T, S).
wstaw_usun(K, A, [K|Rest])  :- rm_nadzbiory(K, A, Rest).

subsumpcja([], X, X):-!.
subsumpcja([H|T], A, Res) :- sub(H, A, A1), subsumpcja(T, A1, Res).
%==================================================================================
% poprzednie zadanie

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
normalizee([],[]) :- !.
normalizee([H|T], S) :- jeden_z(T, H),
                        normalizee(T,S), !.
normalizee([H|T],[H|S]) :- normalizee(T,S).

dolacz_x([],[]).
dolacz_x([H|T],[(H, x)|S]) :- dolacz_x(T,S).

% wyciaga zmienne z listy klauzul
zmienne_list([],[]).
zmienne_list([H|T], Zmienne) :- zmienne(H, ZmienneH),
                                zmienne_list(T, Pozostale),
                                append(ZmienneH, Pozostale, Zmienne1),
                                normalizee(Zmienne1, Zmienne).


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
