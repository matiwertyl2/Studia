pol(wroclaw,warszawa).
pol(wroclaw,krakow).
pol(wroclaw,szczecin).
pol(szczecin,lublin).
pol(szczecin,gniezno).
pol(warszawa,katowice).
pol(gniezno,gliwice).
pol(lublin,gliwice).


jedna_przesiadka(X,Y) :- pol(X,Z), 
			 pol(Z,Y).
			 
dwie_przesiadki(X,Y) :- pol(X,Y).

dwie_przesiadki(X,Y) :- jedna_przesiadka(X,Y).

dwie_przesiadki(X,Y) :- jedna_przesiadka(X,Z),
			pol(Z,Y).
			
connection(X,Y) :- pol(X,Y).

connection(X,Y) :- pol(X,Z),
		   connection(Z,Y).