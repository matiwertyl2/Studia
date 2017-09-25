% Definiujemy moduł zawierający rozwiązanie.
% Należy zmienić nazwę modułu na {imie}_{nazwisko} gdzie za
% {imie} i {nazwisko} należy podstawić odpowiednio swoje imię
% i nazwisko bez znaków diakrytycznych
:- module(kuba, [solve/2]).


% definiujemy operatory ~/1 oraz v/2
:- op(200, fx, ~).
:- op(500, xfy, v).

transform_clause(X v Y, Acc, List) :-
    member(X, Acc),
    !,
    transform_clause(Y, Acc, List).
transform_clause(X v Y, Acc, List) :-
    transform_clause(Y, [X | Acc], List),
    !.
transform_clause(X, Acc, Acc) :-
    member(X, Acc),
    !.
transform_clause(X, Acc, [X | Acc]).

transform_clause(Clause, List) :-
    transform_clause(Clause, [], List).

transform_clauses([], Acc, Acc).
transform_clauses([First | Rest], Acc, Clauses) :-
    transform_clause(First, FirstTrans),
    transform_clauses(Rest, [FirstTrans | Acc], Clauses).
transform_clauses(Raw, Clauses) :-
        transform_clauses(Raw, [], Clauses).

filter_clauses([], Acc, Acc).
filter_clauses([First | Rest], Acc, Clauses) :-
    member(~X, First),
    member(X, First),
    !,
    filter_clauses(Rest, Acc, Clauses).
filter_clauses([First | Rest], Acc, Clauses) :-
    filter_clauses(Rest, [First | Acc], Clauses).
filter_clauses(Clauses, Filtered) :-
    filter_clauses(Clauses, [], Filtered).

get_variables_from_list([], Acc, Acc).
get_variables_from_list([~First | Rest], Acc, Variables) :-
    member(First, Acc),
    !,
    get_variables_from_list(Rest, Acc, Variables).
get_variables_from_list([~First | Rest], Acc, Variables) :-
    get_variables_from_list(Rest, [First | Acc], Variables),
    !.
get_variables_from_list([First | Rest], Acc, Variables) :-
    member(First, Acc),
    !,
    get_variables_from_list(Rest, Acc, Variables).
get_variables_from_list([First | Rest], Acc, Variables) :-
    get_variables_from_list(Rest, [First | Acc], Variables).

get_variables([], Acc, Acc).
get_variables([First | Rest], Acc, Variables) :-
    get_variables_from_list(First, Acc, Acc1),
    get_variables(Rest, Acc1, Variables).

get_variables(List, Variables) :-
    get_variables(List, [], Variables).

already_done(Clause, Sigma) :-
    member(~X, Clause),
    member((X, f), Sigma),
    !.
already_done(Clause, Sigma) :-
    member(X, Clause),
    member((X, t), Sigma),
    !.

satisfy([~H | T], Acc, Sigma) :-
    member((H, t), Acc),
    !,
    satisfy(T, Acc, Sigma).
satisfy([H | T], Acc, Sigma) :-
    H \= ~_,
    member((H, f), Acc),
    !,
    satisfy(T, Acc, Sigma).

satisfy([~H | _], Acc, [(H, f) | Acc]).
satisfy([H | _], Acc, [(H, t) | Acc]) :- H \= ~_.

satisfy([~H | T], Acc, [(H, t) | Acc]) :-
    member(H, T),
    !.
satisfy([H | T], Acc, [(H, f) | Acc]) :-
    H \= ~_,
    member(~H, T),
    !.

satisfy([~H | T], Acc, Sigma) :-
    !,
    satisfy(T, [(H, t) | Acc], Sigma).
satisfy([H | T], Acc, Sigma) :-
    satisfy(T, [(H, f) | Acc], Sigma).

satisfy_clause(Clause, Acc, Acc) :-
    already_done(Clause, Acc),
    !.
satisfy_clause(Clause, Acc, Sigma) :-
    satisfy(Clause, Acc, Sigma).

generate_sigma([], Sigma, Sigma).
generate_sigma([First | Rest], Acc, Sigma) :-
    satisfy_clause(First, Acc, Acc1),
    generate_sigma(Rest, Acc1, Sigma).

generate_sigma(Clauses, Sigma) :-
    generate_sigma(Clauses, [], Sigma).

correct_sigma([], Sigma, Sigma).
correct_sigma([First | Rest], Sigma, Correct) :-
    member((First, _), Sigma),
    !,
    correct_sigma(Rest, Sigma, Correct).
correct_sigma([First | Rest], Sigma, Correct) :-
    correct_sigma(Rest, [(First, x) | Sigma], Correct).

% Główny predykat rozwiązujący zadanie.
% UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jego
% definicję.
solve(Raw, Solution) :-
    transform_clauses(Raw, Unfiltered),
    get_variables(Unfiltered, AllVariables),
    filter_clauses(Unfiltered, Clauses),
    generate_sigma(Clauses, Sigma),
    correct_sigma(AllVariables, Sigma, Solution).
