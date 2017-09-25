even([]).
even([_, _ | T]) :- even(T).

singleton([_]).

last([X], X).
last([_ | T], X) :- last(T, X).

init(X, []) :- singleton(X).
init([H | T], [H | S]) :- init(T, S).

palindrom([]).
palindrom(X) :- singleton(X).
palindrom([H | T]) :-
    last(T, H),
    init(T, S),
    palindrom(S).