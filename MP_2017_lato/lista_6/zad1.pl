stack_put(E, S, [E|S]).
stack_get([E|S], E, S).
stack_empty([]).
stack_addall(X, G, S, Res) :- findall(X, G, L), stack_addall(L, S, Res).
stack_addall([E|T], S, Res) :- stack_addall(T, [E|S], Res).
stack_addall([], X, X).

queue_put(E, S-End, S-End1) :- End=[E|End1].
queue_get([E|S]-End, E, S-End).
queue_empty(X-X).
queue_addall([H|T], S, Res) :- queue_put(H, S, S1), queue_addall(T, S1, Res).
queue_addall([], X, X).
