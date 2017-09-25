insert(H,T,[H|T]).
insert(X,[H|T], [H|S]) :- insert(X,T,S).

perm([],[]).
perm([H|T], P) :- perm(T,S),
                  insert(H,S,P).
