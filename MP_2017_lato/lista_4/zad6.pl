usun(L1, L) :- usun(L1, L, 3).
usun(L, L, 0) :-!.
usun([], _, _) :- false.
usun([_|T], S, X) :- X1 is X-1, usun(T, S, X1 ).
usun([H|T], [H|S], X) :- usun(T, S, X).

zagadka(A, C, E, P, R, S, U) :- L1=[0,1,2,3,4,5,6,7,8,9],
                                usun(L1, L ),
                                permutation(L, [A,C,E,P,R,S,U]),
                                X1 is (A+R) mod 10,
                                proba(X1,E),
                                A2 is (A+R-E)/10,
                                (S+S+A2) mod 10 =:=C,
                                A3 is (A2+S+S-C)/10,
                                (U+S+A3) mod 10 =:= A,
                                A4=(U+S+A3-A)/10,
                               (U+A4) mod 10=:=E,
                                (U+A4)/10=:=P.


proba(X, X) :- !.
proba(_, _) :-false.
