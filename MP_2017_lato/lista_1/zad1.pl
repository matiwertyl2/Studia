lubi(my_cat,ryby).
przyjaciel(my_cat,me).
lubi(X, Y) :- przyjaciel(X,Y).
jada(my_cat, X) :- lubi(my_cat, X).
