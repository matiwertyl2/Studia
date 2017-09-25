drzewo(X) --> "*", !, {X=leaf}.
drzewo(X) --> "( ", drzewo(L), " ", drzewo(R), " )", {X=node(L, R)}.

drzewo(X, Y) :- string_to_list(X, X1), phrase(drzewo(Y), X1).

% nie wygeneruje wszystkich, bo bedzie rozbudowywal tylko prawego syna
