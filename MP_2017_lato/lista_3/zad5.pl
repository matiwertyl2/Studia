insert([], Elem, [Elem]) :- !.
insert([H|T], Elem, Res) :- Elem<H,
                            !,
                            Res=[Elem, H|T].
insert([H|T], Elem, [H|S]) :- insert(T, Elem, S).

ins_sort([X],[X]) :- !.
ins_sort([H|T], Res) :- ins_sort(T, Res1),
                        insert(Res1,H,Res).
