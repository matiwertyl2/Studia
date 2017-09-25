exp(X) --> simp_exp(S), !, exp(X, S).
exp(X, Acc) --> "*", simp_exp(R), !, {Acc1=op(Acc, R)}, exp(X, Acc1).
exp(Acc, Acc) --> [], !.



simp_exp(X) --> "a",!, {X=a}.
simp_exp(X) --> "b",!, {X=b}.
simp_exp(X) --> "(",!, exp(X), ")".


parse(X, Y) :-string_to_list(X, X1), phrase(exp(Y), X1).
