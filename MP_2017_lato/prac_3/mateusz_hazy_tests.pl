% Definiujemy moduł zawierający testy.
% Należy zmienić nazwę modułu na {imie}_{nazwisko}_tests gdzie za
% {imie} i {nazwisko} należy podstawić odpowiednio swoje imię
% i nazwisko bez wielkich liter oraz znaków diakrytycznych
:- module(mateusz_hazy_tests, [tests/3]).
% Zbiór faktów definiujących testy
% Należy zdefiniować swoje testy
tests(operators1, input("def operators(_)= 1+2-3*5/2^3"), program( [def(operators, wildcard(no), op(no, ^, op(no, -, op(no, +, num(no, 1), num(no, 2)), op(no, /, op(no, *, num(no, 3), num(no, 5)), num(no, 2))), num(no, 3)))])).
tests(operators2, input("def operators(_)= 1+A*3 @ 2 @ 3, 2+5*-1/A & B"), yes).
tests(operators3, input("def main(_)=~A & B ^ ~C"), yes).
tests(operators4, input("def main(_)=1+(2+3)"), yes).
tests(operators5, input("def main(_)= 1<2, 1<=2, 2>1, 2>=1, 2<>1"), yes).
tests(multi_def, input("def B(X)=X def A(X)= B(X)"), program([def('B', var(no, 'X'), var(no, 'X')), def('A', var(no, 'X'), call(no, 'B', var(no, 'X')))])).
tests(if_check, input("def main(A)= if A<B then A*-1 else A"), program([def(main, var(no, 'A'), if(no, op(no, <, var(no, 'A'), var(no, 'B')), op(no, *, var(no, 'A'), op(no, -, num(no, 1))), var(no, 'A')))])).
tests(comments1, input("def main(A)= (*cos(*123_#mp_patrzy*)*) A+1"), yes).
tests(comments2, input("def main(A)= (*cos*) A+1, (*coscos(*cos*)cos*) A * A"), yes).
tests(bitsel_check1, input("def main(A)= A[1][1..3]"), yes).
tests(bitsel_check2, input("def Id(X)=X def main_check(X)=X[X[Id(X)]]"), yes).
tests(bitsel_check3, input("def Id(X)=X def main(X)= X[X[X..Id(X)]]"), program([def('Id', var(no, 'X'), var(no, 'X')), def(main, var(no, 'X'), bitsel(no, var(no, 'X'), bitsel(no, var(no, 'X'), var(no, 'X'), call(no, 'Id', var(no, 'X')))))])).
tests(comma_check, input("def main(A, B, C, D)= A+B, C, D"), program( [def(main, pair(no, var(no, 'A'), pair(no, var(no, 'B'), pair(no, var(no, 'C'), var(no, 'D')))), pair(no, op(no, +, var(no, 'A'), var(no, 'B')), pair(no, var(no, 'C'), var(no, 'D'))))])).
tests(call_check, input("def f(A, B)=A+B def main(A, B)= f(f(A, B), f(A, B))"), program([def(f, pair(no, var(no, 'A'), var(no, 'B')), op(no, +, var(no, 'A'), var(no, 'B'))), def(main, pair(no, var(no, 'A'), var(no, 'B')), call(no, f, pair(no, call(no, f, pair(no, var(no, 'A'), var(no, 'B'))), call(no, f, pair(no, var(no, 'A'), var(no, 'B'))))))])).
tests(bit_check, input("def main(A, B)=[A+B-1]"), yes).
tests(let_check, input("def main(_)= (let X= A in B, A+B), (let A= C in D)"), yes).
tests(var_check, input("def main(a_123, b_123_c_11)= A_12_abcD"), program([def(main, pair(no, var(no, a_123), var(no, b_123_c_11)), var(no, 'A_12_abcD'))])).
tests(empty_check, input("def main(A)=[], []"), yes).
tests(pattern_check, input("def main((A, B, C), E, F, (X, Y, Z))=A+B"), program([def(main, pair(no, pair(no, var(no, 'A'), pair(no, var(no, 'B'), var(no, 'C'))), pair(no, var(no, 'E'), pair(no, var(no, 'F'), pair(no, var(no, 'X'), pair(no, var(no, 'Y'), var(no, 'Z')))))), op(no, +, var(no, 'A'), var(no, 'B')))])).
tests(nested_brackets, input("def main(_)=((A*(B+C))+(X*Y+(B/X)))+1"), program([def(main, wildcard(no), op(no, +, op(no, +, op(no, *, var(no, 'A'), op(no, +, var(no, 'B'), var(no, 'C'))), op(no, +, op(no, *, var(no, 'X'), var(no, 'Y')), op(no, /, var(no, 'B'), var(no, 'X')))), num(no, 1)))])).
tests(very_nested_brackets, input("def main(A)=(B, ((((A)))))"), yes).
tests(invalid1, input("def main([])=[]"), no).
tests(invalid2, input("def main(A,,B)=A"), no).
tests(invalid3, input("def main(_)=A, def B(C)=C"), no).
tests(invalid4, input("def main(A, B)=def main(A)"), no).
tests(invalid5, input("def def(A, B)=A"), no).
tests(invalid6, input("def main(let)=nonono"), no).
