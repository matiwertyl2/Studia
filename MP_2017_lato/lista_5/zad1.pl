append([],X, X).
append([H|T], S, [H|R]) :- append(T, S, R).

appn([],[]).
appn([H|T], Z) :- append(H, Y, Z), appn(T, Y).
