filter([],[]).
filter([H|T], [H|S]):- H>=0, !,
                       filter(T,S).
filter([_|T], S) :- filter(T,S).

count(_, [], 0).
count(Elem, [Elem|T], X) :- count(Elem, T, X1),
                            !,
                            X is X1+1.
count(Elem, [_|T], X) :- count(Elem, T, X).

exp(_,0,1) :- !.
exp(Base, Exp, Res) :- Exp1 is Exp-1,
                       exp(Base, Exp1, Res1),
                       Res is Res1*Base.
