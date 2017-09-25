:- module(jarek, [solve/2]).

:- op(200, fx, ~).
:- op(500, xfy, v).

variable(X) :- X \= [], X \= _ v _, X \= ~_.

unique([], []).
unique([H, H | T], Z) :- !, unique([H | T], Z).
unique([H|T], [H|S]) :- unique(T, S).

vars(X, [(X,t)]) :- variable(X).
vars(~X, [(X,f)]).
vars(X v Y, [H|T]) :- vars(X, H), vars(Y, T).

any_value((X, _), (X, _)).

tautology([(X, f), (X, t)|_]) :- !.
tautology([_|T]) :- tautology(T).
tautology_pair(_-X) :- tautology(X).

clause_len(X v Y, K) :- !, clause_len(X, Kx), clause_len(Y, Ky), K is Kx + Ky.
clause_len(_, 1).

init(C, FC, S) :-
    maplist(vars, C, V),
    maplist(flatten, V, FV),
    maplist(sort, FV, SV),
    pairs_keys_values(P, C, SV),
    exclude(tautology_pair, P, FP),
    pairs_keys(FP, FC),
    flatten(V, T1), maplist(any_value, T1, T2), sort(T2, T3), unique(T3, S).

weak_member((X, V), [(X, Vp)|_]) :- !, nonvar(Vp), V = Vp.
weak_member(X, [_|T]) :- weak_member(X, T).

weak_satisfy(X, S) :- variable(X), weak_member((X, t), S).
weak_satisfy(~X, S) :- weak_member((X, f), S).
weak_satisfy(X v Y, S) :- weak_satisfy(X, S); weak_satisfy(Y, S).

satisfy(X, S) :- variable(X), member((X, t), S).
satisfy(~X, S) :- dissatisfy(X, S).
satisfy(X v _, S) :- satisfy(X, S).
satisfy(X v Y, S) :- dissatisfy(X, S), satisfy(Y, S).

dissatisfy(~X, S) :- satisfy(X, S).
dissatisfy(X, S) :- variable(X), member((X, f), S).
dissatisfy(X v Y, S) :- dissatisfy(X, S), dissatisfy(Y, S).

ensure_satisfy(X, Y) :- weak_satisfy(Y, X), !.
ensure_satisfy(X, Y) :- satisfy(Y, X).

has_value((_, x)) :- !.
has_value((_, t)).
has_value((_, f)).

solve(Clauses, Solution) :-
    init(Clauses, FilteredClauses, Solution),
    map_list_to_pairs(clause_len, FilteredClauses, Pairs),
    keysort(Pairs, Sorted),
    pairs_values(Sorted, SortedClauses),
    maplist(ensure_satisfy(Solution), SortedClauses),
    maplist(has_value, Solution).
