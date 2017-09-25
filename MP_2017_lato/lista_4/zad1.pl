dlugosc(List, Res) :- dlugosc(List, Res, 0, Res).

dlugosc([],X, X, X) :-!.
dlugosc([_|T], Dpocz, Ile,  Res) :- Ile1 is Ile+1, dlugosc(T, Dpocz, Ile1, Res).


d([], 0).
d([_|T], D) :- d(T, D1), D is D1+1.


dlug(L, D) :- var(D), !, d(L, D).
dlug(L, D) :- dlugosc(L, D, 0, D).
