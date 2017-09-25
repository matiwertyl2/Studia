:- module(mateusz_hazy, [resolve/4, prove/2]).

:- op(200, fx, ~).
:- op(500, xfy, v).

prove(K, Res) :- init(K, K1, 1),
                normalize(K1, K3),
                subsumpcja(K3, [],  K4 ),
                length_sort(K4, K2),
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
generate_clauses(X, _, X) :- memb(([], [], _, _), X), !.
generate_clauses(X, [], X) :- !.
generate_clauses(A, [H|T], Res) :- rezolw_all(H, A, New),
                                    normalize(New, New1),
                                    append(T, New1, B1),
                                    normalize_small(B1, B2),
                                   length_sort(B2, B3), % normalizacja B posortowane po dlugosci i literaly tez
                                   subsumpcja(B3, [H|A], B4), % usuwa z B wszystkie nazdbiory (poczatkowo porownuje do A)
                                   normalize(B4, [H|A], B5), %  usuwa Z B elementy A
                                   length_sort(B5, B), % na wszelki wypadek jeszcze raz posortowac
                                    generate_clauses([H|A], B, Res ).

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
                        memb(X, P1), memb(X, N2), !,
                        select(X, P1, P1prim), select(X, N2, N2prim),
                        append(P1prim, P2, P), append(N1, N2prim, N),
                        K=(P, N, _, r(X, K1, K2)).
rezolw(X, K1, K2, K) :- K1=(P1, N1, _, _),
                        K2=(P2, N2, _, _),
                        memb(X, N1), memb(X, P2),
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

normalize_small(Res, Res).

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
sort_list([(P1, N1, Nr, Or)|T], [(P, N, Nr, Or)|S]) :- sort(P1, P),
                                                      sort(N1, N),
                                                      sort_list(T, S).

merge([H1|T1], [H2|T2], [H1|Res]) :- compare((<), H1, H2), !, merge(T1, [H2|T2], Res).
merge([H1|T1], [H2|T2], [H2|Res]) :- !, merge([H1|T1], T2, Res).
merge([], X, X) :- !.
merge(X, [], X) :-!.

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
nadzbior(X, [H|T]) :- memb(H, X), !, nadzbior(X, T).

jest_nadzbiorem(_, []) :- !, false.
jest_nadzbiorem(X, [H|_]) :- X=(P1, N1, _, _), H=(P2, N2, _, _),
                            nadzbior(P1, P2), nadzbior(N1, N2), !.
jest_nadzbiorem(X, [_|T]) :- jest_nadzbiorem(X, T).

subsumpcja([], X, X).
subsumpcja([H|T], A, Res) :- jest_nadzbiorem(H, A), !, subsumpcja(T, A, Res).
subsumpcja([H|T], A, Res) :- subsumpcja(T, [H|A], Res ).
