select(H, [H|T], T).
select(X, [H|T], [H|S]) :-select(X, T,S).


perm([],[]).
perm(L, [H|S]) :- perm(A, S), select(H,L,A).
