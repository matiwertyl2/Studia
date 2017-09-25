e(1, 2).
e(1, 3).
e(2, 4).
e(4, 1).
e(4, 5).
e(3, 5).
e(3, 6).
e(6, 7).
e(7, 8).
e(8, 1).

e(a, b).

stack_put(E, S, [E|S]).
stack_get([E|S], E, S).
stack_empty([]).
stack_addall(From, X, G, S, Res) :- findall(X, G, L), stack_addall(From, L, S, Res).
stack_addall(From, [E|T], S, Res) :- stack_addall(From, T, [(E, From)|S], Res).
stack_addall(_, [], X, X).

queue_put(E, S-End, S-End1) :- End=[E|End1].
queue_get([E|S]-End, E, S-End).
queue_empty(X-X).
queue_is_empty(H-_) :- var(H), !.
queue_addall(X, G, S, Res) :- findall(X, G, L), queue_addall(L, S, Res).
queue_addall([H|T], S, Res) :- queue_put(H, S, S1), queue_addall(T, S1, Res).
queue_addall([], X, X).

get_path((V, start), [V]) :- !.
get_path((V, Origin), [V|T]) :- get_path(Origin, T).

dfs(V1, V2, Path) :- stack_empty(SE), stack_put((V1, start), SE, S), stack_empty(Used), dfs(V2, S, Used, Path).
dfs(_, S, _, _) :- stack_empty(S), !, false.
dfs(Vend,  S, _, Path) :- stack_get(S, (Vend, Origin), _),  get_path((Vend, Origin), Path1), reverse(Path1, Path).
dfs(Vend, S, Used, Path) :-  stack_get(S, (V, _), S1), member(V, Used), !, dfs(Vend, S1, Used, Path).
dfs(Vend, S, Used, Path) :- stack_get(S, (V, Orig), S1), stack_addall((V, Orig), U, e(V, U), S1, S2),
                            stack_put(V, Used, Used1), dfs(Vend, S2, Used1, Path).


bfs(V1, V2) :- queue_empty(Q), queue_put(V1, Q, Q1), stack_empty(Used), bfs(V2, Q1, Used).
bfs( _, Q, _) :- queue_is_empty(Q),!, false.
bfs(Vend, Q, _) :- queue_get(Q, V, _ ), nonvar(V), V=Vend, !.
bfs(Vend, Q, Used) :- queue_get(Q, V, Q1), member(V, Used), !, bfs(Vend, Q1, Used).
bfs(Vend, Q, Used) :- queue_get(Q, V, Q1), stack_put(V, Used, Used1),
                      queue_addall(U, e(V, U), Q1, Q2), bfs(Vend, Q2, Used1).
