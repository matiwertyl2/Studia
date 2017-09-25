even([]).
even([_ | [_|T]]) :- even(T).

singleton([_]).

palindrom([]).
palindrom(X):- singleton(X).
palindrom([H|T]) :- last(H,T),
		   init(S, T),
		   palindrom(S).
		    
		    
head(X, [X|_]).

last(X,[X]).
last(X, [_|T]) :- last(X, T).

tail(T, [_|T]).

init([], [_]).
init([H|T], [H|S]) :- init(T, S).

prefix([], _).
prefix([H|T], [H|S]) :- prefix(T,S).

suffix([],[]).
suffix([H|L], [H|S]) :- suffix(L,S).
suffix([_|L], S) :- suffix(L,S).