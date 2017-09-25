variable(X) :- not(X=dziwnanazwaatomu), !,false.
variable(_) :- true.

rev(X,Y) :- rev(X,[],Y).

rev([],A,A).
rev([H|T],A,Y) :- rev(T,[H|A],Y).

reverse(X,Y) :- variable(X), !,rev(Y,X).
reverse(X,Y) :- rev(X,Y).
