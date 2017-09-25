
lexer([]) --> [].
lexer([white|T]) --> whitespace, {write("jebane\n")}, !, lexer(T).
lexer([word(X1)|T]) --> slowo(X), {write("kurwa\n")}, {atom_codes(X1, X)} , lexer(T).


whitespace --> [H], {member(H, [32])}.

slowo([A|T]) --> {write("gowno\n")}, letter(A), !, slowo(T).
slowo([])--> whitespace, !.
slowo([]) --> [], !.

letter(A) --> [A], {member(A, [97, 98])}.
