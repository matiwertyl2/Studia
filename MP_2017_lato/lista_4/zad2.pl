connection(a, b).
connection(b, c).
connection(c, d).
connection(b, d).
connection(a, d).
connection(e, a).
connection(b, e).
connection(e, c).

trip(Pocz, Kon, Res) :- trip(Kon, Pocz,[], Res).

trip(Pocz, Pocz, A, [Pocz|A]).
trip(Pocz, Kon, A, Res) :- connection(X, Pocz),
                            not(member(X, A)),
                            trip(X, Kon, [Pocz|A], Res).
