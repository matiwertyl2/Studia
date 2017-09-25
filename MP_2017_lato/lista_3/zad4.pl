select_min([X], X, []) :- !.
select_min([H|Numlist], Min, Rest) :- select_min(Numlist, Min1, Rest1),
                                      H>=Min1,
                                      !,
                                      Min=Min1,
                                      Rest=[H|Rest1].
select_min([H|Numlist], Min, Rest) :- Min=H,
                                      Rest=Numlist.


sel_sort([X], [X]) :- !.
sel_sort(Numlist, Res) :- select_min(Numlist, Min, Rest),
                          sel_sort(Rest, Res1),
                          Res=[Min|Res1].

select(H,[H|T],T).
select(X,[H|T],[H|S]) :- select(X,T,S).

znajdz_min([],X,X).
znajdz_min([H|T],Min0, Min) :-
                          H<Min0,
                          !,
                          znajdz_min(T,H,Min).
znajdz_min([_|T], Min0, Min) :- znajdz_min(T,Min0,Min).

sel_min([H|T], Min, Rest) :- znajdz_min(T,H, Min),
                              select(Min, [H|T], Rest).
