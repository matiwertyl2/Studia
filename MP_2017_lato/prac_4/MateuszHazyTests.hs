-- Wymagamy, by moduł zawierał tylko bezpieczne funkcje
{-# LANGUAGE Safe #-}
-- Definiujemy moduł zawierający testy.
-- Należy zmienić nazwę modułu na {Imie}{Nazwisko}Tests gdzie za {Imie}
-- i {Nazwisko} należy podstawić odpowiednio swoje imię i nazwisko
-- zaczynające się wielką literą oraz bez znaków diakrytycznych.
module MateuszHazyTests(tests) where
-- Importujemy moduł zawierający typy danych potrzebne w zadaniu
import DataTypes
-- Lista testów do zadania
-- Należy uzupełnić jej definicję swoimi testami
tests :: [Test]

tests =[ Test "operators1" (SrcString "input x in x+1") (Eval [1] (Value 2))
  , Test "operators2" (SrcString "input a b c in a+b*c") (Eval [1, 2, 3] (Value 7))
  , Test "operators3" (SrcString "input a b c d in (-a div b + b*c*d) mod 4") (Eval [6, 3, 2, 1] (Value 0))
  , Test "operatorAdd" (SrcString "input a b in a+b") (Eval [3, 4] (Value 7 ))
  , Test "operatorSub" (SrcString "input a b in a-b") (Eval [3, 4] (Value (-1)))
  , Test "operatorMult" (SrcString "input a b in a*b") (Eval [3, 4] (Value 12))
  , Test "operatorDiv" (SrcString "input a b in a div b") (Eval [100, 25] (Value 4 ))
  , Test "operatorsCmp1" (SrcString "input a in if 1<2 and 2>1 and 2=2 and 2<=2 then a else 0") (Eval [3] (Value 3))
  , Test "operatorsCmp2" (SrcString "input a in if 1>=2 then a else -a") (Eval [2] (Value (-2) ))
  , Test "operatorsLogic1" (SrcString "if true and true or false and false then 1 else 0") (Eval [] (Value 1 ))
  , Test "operatorsLogic2" (SrcString "if not true and false or false and not true then 1 else 0") (Eval [] (Value 0))
  , Test "RuntimeError1" (SrcString "input a in a div 0") (Eval [] RuntimeError)
  , Test "RuntimeError2" (SrcString "input a b in a mod b") (Eval [2, 0] RuntimeError)
  , Test "ifExpr1" (SrcString "input a b in if a < b then 1 else 0") (Eval [1, 2] (Value 1 ))
  , Test "ifExpr2" (SrcString "input a b in if a < b then 1 else 0") (Eval [2, 1] (Value 0 ))
  , Test "ifExpr3" (SrcString "input a in if a>1 and a<3 then 2 else 0") (Eval [2] (Value 2))
  , Test "ifExpr4" (SrcString "input a b in if a<b then if a=2 then 2 else 0 else if b=3 then 3 else 0") (Eval [2, 3] (Value 2 ))
  , Test "ifExpr5" (SrcString "input a b in if a<b then if a=2 then 2 else 0 else if b=3 then 3 else 0") (Eval [3, 3] (Value 3 ))
  , Test "ifExpr6" (SrcString "input a b in if a<b then if a=2 then 2 else 0 else if b=3 then 3 else 0") (Eval [1, 3] (Value 0 ))
  , Test "ifExpr7" (SrcString "input a in if true then a else a mod 0") (Eval [100] (Value 100 ))
  , Test "letExpr1" (SrcString "input a b in let x=b+1 in a+x") (Eval [10, 20] (Value 31 ))
  , Test "letExpr2" (SrcString "input a b in if a=0 then let x=a+1 in if b mod x = 0 then 1 else 0 else let x=a in if b mod x =0 then 1 else 0") (Eval [3, 4] (Value 0 ))
  , Test "letExpr3" (SrcString "input a in let a=true in let a=true in let a=1 in a") (Eval [2] (Value 1 ))
  , Test "delta1" (SrcString "input a b c in if a=0 and b=0 and c=0 then 1000 else if a=0 and b=0 then 0 else if a=0 then 1  else   let d= b*b -4*a*c in  if d<0 then 0  else if d=0 then 1 else 2") (Eval [1, 2, 1] (Value 1 ))
  , Test "delta2" (SrcString "input a b c in if a=0 and b=0 and c=0 then 1000 else if a=0 and b=0 then 0 else if a=0 then 1  else   let d= b*b -4*a*c in  if d<0 then 0  else if d=0 then 1 else 2") (Eval [1, -5, 6] (Value 2 ))
  , Test "ifletExpr" (SrcString "input x in if x < 4 then let x=3 in x+1 else let x=100 in x+1")       (Eval [1] (Value 4))
  , Test "TypeError1" (SrcString "input a b in if a<b then true else false") TypeError
  , Test "TypeError2" (SrcString "input a in let a=true in a") TypeError
  , Test "general1" (SrcString "if let x=1 in let y=2 in  x+y  < 4 then 1 else 0") (Eval [] (Value 1))
  , Test "general2" (SrcString "input a b in let x=a+b in if x mod 7 = 0 then  let x=a in  x*7 else let x=b in x*7") (Eval [3, 4] (Value 21 ))
  , Test "general3" (SrcString "input a b in let x=a+b in if x mod 7 = 0 then  let x=a in  x*7 else let x=b in x*7") (Eval [4, 5] (Value 35 ))
  ]





-- , Test "" (SrcString "") (Eval [] (Value ))
