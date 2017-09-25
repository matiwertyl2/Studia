select(H, [H|T], T).
select(X, [H|T], [H|S]) :-select(X, T,S).

variable(X) :- not(X=dziwnanazwaatomu), !,false.
variable(_) :- true.

permutacja(L,S) :- variable(L), !, perm(L,S).
permutacja(L,S) :- perm(S,L).

perm([],[]).
perm(L, [H|S]) :-perm(A, S), select(H,L,A).
