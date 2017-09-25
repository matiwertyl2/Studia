
is_prime(_, [H|_]) :- var(H), !.
is_prime(X, [H|T]) :- X mod H > 0, !,
                      is_prime(X, T).
is_prime(_, _) :- false.



prime(X) :- prime(X, 2, P, P).

prime(X, Current, Pierwsze, _) :- not(var(X)), Current > X, !, false.
prime(X, Current, Pierwsze, _) :- not(var(X)), Current is X, is_prime(Current, Pierwsze), !.

prime(X, Current, Pierwsze, _) :- is_prime(Current, Pierwsze),
                                  X=Current.
prime(X, Current,  Pierwsze, P) :-  is_prime(Current, Pierwsze), !,
                                    Next is Current+1,
                                    P=[Current|P1],
                                    prime(X, Next, Pierwsze, P1 ).
prime(X, Current, Pierwsze, P) :- Next is Current+1,
                                  prime(X, Next, Pierwsze, P).
