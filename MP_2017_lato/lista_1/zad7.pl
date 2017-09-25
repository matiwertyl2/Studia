jeden_z(D, D1, D2, D3, D4, D5) :- D=D1; D=D2; D=D3; D=D4; D=D5.

sasiad(A, B, D1, D2, D3, D4, D5) :- (A=D1, B=D2); (A=D2, B=D3); (A=D3, B=D4); (A=D4, B=D5).

sasiad(B, A, D1, D2, D3, D4, D5) :- (A=D1, B=D2); (A=D2, B=D3); (A=D3, B=D4); (A=D4, B=D5).

zas_1(D1, D2, D3, D4, D5) :- jeden_z(D, D1, D2, D3, D4, D5), D=dom(anglik, czerwony, _, _, _).
zas_2(D1, D2, D3, D4, D5) :- jeden_z(D, D1, D2, D3, D4, D5), D=dom(hiszpan, _, pies, _, _).
zas_3(D1, D2, D3, D4, D5) :- jeden_z(D,D1, D2, D3, D4, D5), D=dom(_, zielony, _, _, kawa).
zas_4(D1, D2, D3, D4, D5) :- jeden_z(D,D1, D2, D3, D4, D5), D=dom(ukrainiec, _, _, _, herbata).
zas_5(D1, D2, D3, D4, D5) :- sasiad(A, B, D1, D2, D3, D4, D5), A=dom(_, zielony, _, _, _), B=dom(_,bialy, _, _, _).
zas_6(D1, D2, D3, D4, D5) :- jeden_z(D, D1, D2, D3, D4, D5), D=dom(_, _, waz, winstony, _).
zas_7(D1, D2, D3, D4, D5) :- jeden_z(D, D1, D2, D3, D4, D5), D=dom(_, zolty, _, koole, _).
zas_8(_, _, D3, _, _) :- D3=dom(_,_,_,_,mleko).
zas_9(D1, _, _, _, _) :- D1=dom(norweg,_, _, _, _).
zas_10(D1, D2, D3, D4, D5) :- sasiad(A, B, D1, D2, D3, D4, D5), A=dom(_,_,_,chesterfield,_), B=dom(_,_,lis,_,_).
zas_11(D1, D2, D3, D4, D5) :- sasiad(A, B, D1, D2, D3, D4, D5), A=dom(_,_,kon,_,_), B=dom(_,_,_,koole,_).
zas_12(D1, D2, D3, D4, D5) :- jeden_z(D, D1, D2, D3, D4, D5), D=dom(_,_,_,luckystrike,sok).
zas_13(D1, D2, D3, D4, D5) :- jeden_z(D, D1, D2, D3, D4, D5),D=dom(japonczyk,_,_,kenty,_).
zas_14(D1, D2, D3, D4, D5) :- sasiad(A,B, D1, D2, D3, D4, D5), A=dom(norweg,_,_,_,_), B=dom(_,niebieski,_,_,_).

zagadka(D1, D2, D3, D4, D5):- zas_1(D1,D2,D3,D4,D5), zas_2(D1,D2,D3,D4,D5), zas_3(D1,D2,D3,D4,D5), zas_4(D1,D2,D3,D4,D5),
			      zas_5(D1,D2,D3,D4,D5), zas_6(D1,D2,D3,D4,D5), zas_7(D1,D2,D3,D4,D5), zas_8(D1,D2,D3,D4,D5),
			      zas_9(D1,D2,D3,D4,D5), zas_10(D1,D2,D3,D4,D5), zas_11(D1,D2,D3,D4,D5), zas_12(D1,D2,D3,D4,D5),
			      zas_13(D1,D2,D3,D4,D5), zas_14(D1,D2,D3,D4,D5).
			      
zwierze(X,Y) :- zagadka(D1, D2, D3, D4, D5), 
		jeden_z(D, D1,D2,D3,D4,D5),
		D=dom(A,_,Y,_,_),
		X=A.

napoj(X,Y) :- zagadka(D1,D2,D3,D4,D5),
	      jeden_z(D,D1, D2,D3, D4, D5),
	      D=dom(A,_,_,_,Y),
	      X=A.