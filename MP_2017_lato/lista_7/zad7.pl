:- use_module(library(arithmetic)).
:- arithmetic_function(!/1).
:- arithmetic_function('!!'/1).
:- op(150, yf, !).
:- op(150, yf, '!!').

!(0, 1) :- !.
!(N, Res) :- N1 is N-1, !(N1, Res1), Res is Res1*N.


'!!'(0, 1):- !.
'!!'(N, Res) :- N mod 2 =:= 1, !,  N1 is N-1, '!!'(N1, Res1), Res is Res1*N.
'!!'(N, Res) :- N1 is N-1, '!!'(N1, Res).
