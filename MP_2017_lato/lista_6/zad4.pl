odd(1).
odd(3).
odd(5).
odd(7).
odd(9).
even(0).
even(2).
even(4).
even(6).
even(8).

number([], X, X).
number([H|T], A, Res) :- H=c, odd(X1), A1 is X1 + 10*A, number(T, A1, Res).
number([H|T], A, Res) :- H=s, even(X1), A1 is X1 + 10*A, number(T, A1, Res).



solve([A, B|T], [X, Y|Res]) :- number(A, 0, X), number(B, 0, Y), validate(X, Y, Y,  T, Res).

validate(X, Y0, _, [L], [Res]) :- Res is X * Y0, valid_number(Res, L).
validate(X, Y0, Y, [H|T], [Product|Res]) :- Mult is Y mod 10, Product is X * Mult, valid_number(Product, H),
                                            Y1 is (Y-Mult)/10, validate(X, Y0, Y1, T, Res).


valid_number(X, List) :-reverse(List, List1), val_number(X, List1).
val_number(0, []) :- !.
val_number(X, [H|T]) :- H=c, !, Mod is X mod 10, odd(Mod), X1 is (X-Mod)/10, val_number(X1, T).
val_number(X, [H|T]) :- H=s, !, Mod is X mod 10, even(Mod), X1 is (X-Mod)/10, val_number(X1, T).
