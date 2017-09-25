rbin(X) :- revbin([0], X).

revbin(X, X).
revbin(X, Res) :- next(X, Y), revbin(Y, Res).

next([0|T], [1|T]).
next([1], [0,1]) :- !.
next([1|T], [0|S]) :- next(T, S).


generuj_d(D, [1|Res]) :- D1  is D-1, generuj_dlugosc(D1, Res).

generuj_dlugosc(0, []) :- !.
generuj_dlugosc(D, [0|Rest]) :- D1 is D-1, generuj_dlugosc(D1, Rest).
generuj_dlugosc(D, [1|Rest]) :- D1 is D-1, generuj_dlugosc(D1, Rest).

generuj_rozne_dlugosci(D, Res) :- generuj_d(D, Res).
generuj_rozne_dlugosci(D, Res)    :- D1 is D+1, generuj_rozne_dlugosci(D1, Res).

bin([0]).
bin([1]).
bin(X) :- generuj_rozne_dlugosci(2, X).
