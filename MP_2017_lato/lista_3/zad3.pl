factorial(0,1) :- !.
factorial(N, M):- N1 is N-1,
                  factorial(N1, M1),
                  M is M1*N.

dlugosc([], 0).
dlugosc([_|T],N) :-dlugosc(T,N1),
                  N is N1+1.

exp(_,0,1) :- !.
exp(Base, Exp, Res) :-Exp1 is Exp-1,
                      exp(Base, Exp1, Res1),
                      Res is Res1*Base.

concat_numbers([], 0).
concat_numbers([H|T], Num) :-concat_numbers(T, Num1),
                            dlugosc(T, L),
                            exp(10, L, Pot),
                            Num is Num1+H*Pot.

reverse([], X, X).
reverse([H|T], S, W) :- reverse(T, [H|S], W).

reverse(X,Y) :- reverse(X,[],Y).

decimal(Num, Digits) :- decim(Num, L),
                        reverse(L,Digits).

decim(0,[]) :- !.
decim(Num, [H|T]):- H is Num mod 10,
                      Num1 is (Num-H)/10,
                      decim(Num1,T).
