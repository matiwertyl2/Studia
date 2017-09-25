:- module(mateusz_hazy_semi_fast, [resolve/4, prove/2]).

:- op(200, fx, ~).
:- op(500, xfy, v).

prove(K, Res) :- init(K, K1, 1),
                normalize(K1, K3),
                length_sort(K3, K2),
                generate_clauses([], K2, Clauses),
                create_proof(Clauses, Proof),
                end_result(Proof, Res).
%==============================================================================
end_result([], []) :- !.
end_result([K|T], [(Clause, axiom) |S]) :- K=(P, N, _, axiom), !,
                                          clause(P, N, Clause),
                                          end_result(T, S).
end_result([K|T], [(Clause, (A, B, C))|S] ) :- K=(P, N, _, r(A, B ,C)),
                                          clause(P, N, Clause),
                                          end_result(T, S).
% =============================================================================
% glowna petla generowania rezolwent % wymaga naprawienia
generate_clauses(X, _, X) :- member(([], [], _, _), X), !.
generate_clauses(X, [], X) :- !.
generate_clauses(A, [H|T], Res) :- rezolw_all(H, A, New),
                                    normalize(New, New1),
                                    length_sort(New1, New2),
                                    subsumpcja([H], A, A1),
                                    append(A1, T, T1),
                                    length_sort(T1, T2),
                                    subsumpcja(New2, T2, B),
                                    normalize(B, A1, B1),
                                    generate_clauses(A1, B1, Res ).
%==============================================================================
% wraca sie w dowodzie
create_proof(Clauses, Proof) :- empty_clause(Clauses, E),
                                E=([], [], _, axiom), !,
                                Proof=[E].
create_proof(Clauses, Proof) :- empty_clause(Clauses, E),
                                E=([], [], _, r(Var, K1, K2)),
                                sources(K1, Proof1, 1, Cnt),
                                sources(K2, Proof2, Cnt, Cnt1),
                                K1=(_, _, Nr1, _),
                                K2=(_,_, Nr2, _),
                               append(Proof1, Proof2, Proof3),
                               append(Proof3, [([], [], Cnt1, r(Var, Nr1, Nr2))], Proof).

% rekurencyjnie idzie do tych z ktorych dana klauzula powstala
% cnt -licznik poczatkowy, cnt1/res - licznik koncowy
sources(K, [K], Cnt, Cnt1) :- K=(_, _, Nr, axiom), var(Nr),!, Nr=Cnt, Cnt1 is Cnt+1.
sources(K, [], Cnt,Cnt) :- K=(_, _, Nr, _), nonvar(Nr), !.
sources(K, Res, Cnt, CntRes) :- K=(P, N, Cnt2, r(Var, K1, K2)),
                    sources(K1, Res1, Cnt, Cnt1),
                    sources(K2, Res2, Cnt1, Cnt2),
                    append(Res1, Res2, Res3),
                    K1=(_, _, Nr1, _),
                    K2=(_, _, Nr2, _),
                    append(Res3, [(P, N, Cnt2, r(Var, Nr1, Nr2) )], Res),
                    CntRes is Cnt2+1.

empty_clause([], _) :- !, false.
empty_clause([([],[], Nr, Origin)|_], ([], [], Nr, Origin) ) :- !.
empty_clause([_|T], Res) :- empty_clause(T, Res).
%==============================================================================
% bazowa rezolwenta
rezolw(X, K1, K2, K) :- K1=(P1, N1, _, _),
                        K2=(P2, N2, _, _),
                        member(X, P1), member(X, N2), !,
                        select(X, P1, P1prim), select(X, N2, N2prim),
                        append(P1prim, P2, P), append(N1, N2prim, N),
                        K=(P, N, _, r(X, K1, K2)).
rezolw(X, K1, K2, K) :- K1=(P1, N1, _, _),
                        K2=(P2, N2, _, _),
                        member(X, N1), member(X, P2),
                        select(X, N1, N1prim), select(X, P2, P2prim),
                        append(N1prim, N2, N), append(P1, P2prim, P),
                        K=(P, N, _, r(X, K2, K1)).

% bierze 2 klauzule i produkuje wszystkie rezolwenty
rezolw1(K1, K2, Res) :- K1=(P1, N1, _, _), merge(P1, N1, L),
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
normalize(B, A, Res) :- sort_list(B, B1), sort_list(A, A1),
                        rm_rep(B1, A1, Res).

rm_rep([], _, []) :-!.
rm_rep([K|T], A, S) :- K=(P, N, _, _), member((P, N, _, _), A), !, rm_rep(T, A, S).
rm_rep([K|T], A, [K|S]) :- rm_rep(T, A, S).

rm_taut([], []):- !.
rm_taut([H|T], S) :- H=(P, N, _, _), member(X, P), member(X, N),! ,
                      rm_taut(T, S).
rm_taut([H|T], [H|S]) :- rm_taut(T, S).

%===============================================================================
% inicjalizacja klauzul wejsciowych
init([], [], _):- !.
init([H|T], [(P, N, _, axiom)|S], Nr) :- listuj(H, P, N), Nr1 is Nr+1, init(T,S, Nr1 ).

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

%===============================================================================
% sortowanie

sort_list([], []):- !.
sort_list([(P1, N1, Nr, Or)|T], [(P, N, Nr, Or)|S]) :- sort(P1, P),
                                                      sort(N1, N),
                                                      sort_list(T, S).

length_sort(List, Res) :- pair_length(List, List1),
                          sort(List1, List2),
                          lsort_res(List2, Res).

 pair_length([], []) :-!.
 pair_length([H|T], [H1|S]) :- H=(P, N, _, _), length(P, X1), length(N, X2), X is X1 + X2,
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
%================================================================================
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
