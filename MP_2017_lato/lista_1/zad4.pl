male(adam).
male(john).
male(mark).
male(joshua).
male(david).

female(eve).
female(helen).
female(ivonne).
female(anna).


parent(adam, helen).
parent(adam, ivonne).
parent(adam, anna).
parent(eve, helen).
parent(eve, ivonne).
parent(eve, anna).
parent(john, joshua).
parent(helen, joshua).
parent(ivonne, david).
parent(mark, david).

sibling(X,Y) :- parent(Z,X),
		parent(Z,Y),
		not(X==Y).
		
		
sister(X,Y) :- parent(Z,X),
	       parent(Z,Y),
	       female(X),
	       not(X==Y).
	 
grandson(X,Y) :- parent(Z,X),
		 parent(Y,Z),
		 male(X).
		 
cousin(X,Y) :- parent(A,X),
	       parent(B,Y),
	       sibling(A,B),
	       not(X==Y),
	       not(A==B).
	       
descendant(X,Y) :- parent(Y,X).

descendant(X,Y) :- parent(Y,Z),
		   descendant(X,Z).
		   
is_mother(X) :- female(X),
		parent(X,Y).
		
is_father(X) :- male(X),
		parent(X,Y).