flatten([], X, X) :- !.
flatten([H|T], H1, R) :- !, flatten(H, H1, P1), % flatten glowy i robi otwarta liste, P1 kocnowka H1
                         flatten(T, P1, R).
flatten(X, [X|P], P) :- !.


flatten(Lista, Res) :- flatten(Lista, Res, []).
