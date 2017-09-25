:- module(mateusz_hazy, [parse/3]).

lexer(Tokens) --> white_sgn, !, lexer(Tokens).
lexer(Tokens) --> "(*", comment, "*)", !, lexer(Tokens).
lexer([Token|Tokens]) --> "_", !, {atom_codes(Token, `_`)}, lexer(Tokens).
lexer([Token|Tokens]) --> slowo(S), !,  {keyword(S), !, atom_codes(Token, S); Token=id(S1), atom_codes(S1, S)}, lexer(Tokens).
lexer([Token|Tokens]) --> operator(X), !, {Token=op(X1), atom_codes(X1, X)}, lexer(Tokens).
lexer([Token|Tokens]) --> number(X), !, {Token=int(X1), atom_codes(X1, X)}, lexer(Tokens).
lexer([]) --> [].

white_sgn --> [X], {member(X, [9, 10, 11, 12, 13, 32])}.

keyword(S) :- member(S, [`def`, `else`, `if`, `in`, `let`, `then`, '_']).

slowo(S) --> letter(H), char_list(T), {S=[H|T]}.

letter(X) --> [X], {code_type(X, alpha)}.

char_list([H|T]) --> [H], {code_type(H, alnum); H=95; H=39}, !, char_list(T).
char_list([]) --> [].

number(X) --> digit(H), digit_list(T), {X=[H|T]}.
digit_list([H|T]) --> digit(H), !, digit_list(T).
digit_list([]) --> [].
digit(X) --> [X], {code_type(X, digit)}.

comment --> [].
comment --> "(*", !, comment, "*)", comment.
comment --> [H], {code_type(H, ascii)}, !, comment.

operator(X) --> "+", !, {X="+"};
                "(", !, {X="("};
                ")", !, {X=")"};
                "[", !, {X="["};
                "]", !, {X="]"};
                "..", !, {X=".."};
                ",", !, {X=","};
                "=", !, {X="="};
                "<>", !, {X="<>"};
                "<=", !, {X="<="};
                ">=", !, {X=">="};
                "^", !, {X="^"};
                "<", !, {X="<"};
                ">", !, {X=">"};
                "|", !, {X="|"};
                "-", !, {X="-"};
                "&", !, {X="&"};
                "*", !, {X="*"};
                "/", !, {X="/"};
                "%", !, {X="%"};
                "@", !, {X="@"};
                "#", !, {X="#"};
                "~", !, {X="~"}.

%==================================================
parse(_, String, Res) :- string_to_list(String, X), phrase(lexer(Tokens), X), !,
                phrase(program(Res), Tokens), !.

op_1(X) --> [op(X)], {member(X, [','])}.
op_2(X) --> [op(X)], {member(X, [=, <=, >=, <>, >, <])}.
op_3(X) --> [op(X)], {member(X, [@])}.
op_4(X) --> [op(X)], {member(X, ['|', ^, +, -])}.
op_5(X) --> [op(X)], {member(X, [&, *, /, '%'])}.
op_6(X) --> [op(X)], {member(X, [-, #, ~])}.

program(X) -->  definicje(X).
definicje([]) --> puste.
definicje([H|T]) -->  definicja(H),  definicje(T).
definicja(Def) --> [def], [id(Id)], [op('(')], wzorzec(Wzorzec), [op(')')], [op(=)], wyrazenie(Wyr),
                    {Def=def(Id, Wzorzec, Wyr)}.

wzorzec(Wzorzec) --> wzorzec_prosty(Wzorzec).
wzorzec(Wzorzec) --> wzorzec_prosty(First), [op(',')], wzorzec(Second), {Wzorzec=pair(no, First, Second)}.

wzorzec_prosty(Wzorzec) --> ['_'], {Wzorzec=wildcard(no)}.
wzorzec_prosty(Wzorzec) --> [id(Var)], {Wzorzec=var(no, Var)}.
wzorzec_prosty(Wzorzec) --> [op('(')], wzorzec(Wzorzec), [op(')')].


wyrazenie(Wyr) --> [if], wyrazenie(Wyr1), [then], wyrazenie(Wyr2), [else], wyrazenie(Wyr3),
                    {Wyr=if(no, Wyr1, Wyr2, Wyr3)}.
wyrazenie(Wyr) --> [let], wzorzec(Wzorzec), [op(=)], wyrazenie(Wyr1), [in], wyrazenie(Wyr2),
                    {Wyr=let(no, Wzorzec, Wyr1, Wyr2)}.
wyrazenie(Wyr) -->wyrazenie_op1(Wyr).

wyrazenie_op1(Wyr)--> wyrazenie_op2(Wyr1), op_1(_), wyrazenie_op1(Wyr2),
                      {Wyr= pair(no, Wyr1, Wyr2)}.
wyrazenie_op1(Wyr) --> wyrazenie_op2(Wyr).

wyrazenie_op2(Wyr) --> wyrazenie_op3(Wyr1), op_2(Op), wyrazenie_op3(Wyr2),
                      {Wyr=op(no, Op, Wyr1, Wyr2)}.
wyrazenie_op2(Wyr) --> wyrazenie_op3(Wyr).

wyrazenie_op3(Wyr) --> wyrazenie_op4(Wyr1), op_3(Op), wyrazenie_op3(Wyr2),
                      {Wyr=op(no, Op, Wyr1, Wyr2)}.
wyrazenie_op3(Wyr) --> wyrazenie_op4(Wyr).

wyrazenie_op4(Wyr) --> wyrazenie_op5(Skladnik), wyrazenie_op4(Skladnik, Wyr).
wyrazenie_op4(Acc, Wyr) --> op_4(Op), !, wyrazenie_op5(Skladnik), {Acc1= op(no, Op, Acc, Skladnik)},
                            wyrazenie_op4(Acc1, Wyr).
wyrazenie_op4(Acc, Acc) --> [].

wyrazenie_op5(Wyr) --> wyrazenie_op6(Czynnik), wyrazenie_op5(Czynnik, Wyr).
wyrazenie_op5(Acc, Wyr) --> op_5(Op), !, wyrazenie_op6(Czynnik), {Acc1=op(no, Op, Acc, Czynnik)},
                            wyrazenie_op5(Acc1, Wyr).
wyrazenie_op5(Acc, Acc) --> [].

wyrazenie_op6(Wyr) --> op_6(Op), !, wyrazenie_op6(Wyr1), {Wyr=op(no, Op, Wyr1)}.
wyrazenie_op6(Wyr) --> wyrazenie_proste(Wyr).

wyrazenie_proste(Wyr)--> [op('(')] , wyrazenie(Wyr1) , [op(')')], ciag_wyborow(Wyr1, Wyr).
wyrazenie_proste(Wyr) --> wyrazenie_atomowe(Wyr1), ciag_wyborow(Wyr1, Wyr).

ciag_wyborow(Acc, Wyr) --> [op('[')], wyrazenie(Wyr1), [op(']')],
                          {Acc1=bitsel(no, Acc, Wyr1)}, ciag_wyborow(Acc1, Wyr).
ciag_wyborow(Acc, Wyr) --> [op('[')], wyrazenie(Wyr1), [op(..)], wyrazenie(Wyr2), [op(']')],
                          {Acc1=bitsel(no, Acc, Wyr1, Wyr2)}, ciag_wyborow(Acc1, Wyr).
ciag_wyborow(Acc, Acc) --> [].

wyrazenie_atomowe(Wyr) --> [id(Var)], {Wyr=var(no, Var)}.
wyrazenie_atomowe(Wyr) --> wywolanie_funkcji(Wyr).
wyrazenie_atomowe(Wyr) --> [int(N)], {atom_number(N, N1), Wyr=num(no, N1)}.
wyrazenie_atomowe(Wyr) --> pusty_wektor(Wyr).
wyrazenie_atomowe(Wyr) --> single_bit(Wyr).

wywolanie_funkcji(Wyr) --> [id(Name)], [op('(')], wyrazenie(Wyr1), [op(')')],
                            {Wyr=call(no, Name, Wyr1 )}.

pusty_wektor(Wyr) --> [op('[')], [op(']')], {Wyr=empty(no)}.

single_bit(Wyr) --> [op('[')], wyrazenie(Wyr1), [op(']')], {Wyr=bit(no, Wyr1)}.

puste --> [].























%==
