-- Wymagamy, by moduł zawierał tylko bezpieczne funkcje
{-# LANGUAGE Safe #-}
-- Definiujemy moduł zawierający rozwiązanie.
-- Należy zmienić nazwę modułu na {Imie}{Nazwisko} gdzie za {Imie}
-- i {Nazwisko} należy podstawić odpowiednio swoje imię i nazwisko
-- zaczynające się wielką literą oraz bez znaków diakrytycznych.
module MateuszHazy (typecheck, eval) where

-- Importujemy moduły z definicją języka oraz typami potrzebnymi w zadaniu
import AST
import DataTypes
import qualified Data.Map as Map
import Data.Maybe

-- Funkcja sprawdzająca typy
-- Dla wywołania typecheck vars e zakładamy, że zmienne występujące
-- w vars są już zdefiniowane i mają typ int, i oczekujemy by wyrażenia e
-- miało typ int
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.
typecheck ::  [Var] -> Expr p -> TypeCheckResult p
typecheck vars e = get_type_answer ( infer_type (init_env vars)  e) e

data Type p
  = TInt
  | TBool
  | TError p String
  | TErr
  deriving (Eq, Show)

get_type_answer (TError p err) e= Error p err
get_type_answer TInt e= Ok
get_type_answer TBool e= Error (get_position e) "Wrong Output"

get_position (ENum p x) =p
get_position (EVar p x )=p
get_position( EBool p x)= p
get_position(EUnary p op x)=p
get_position (EBinary p op x y) =p
get_position (ELet p x y z) =p
get_position (EIf p x y z)=p

init_env vars = Map.fromList(vars_with_type vars)

vars_with_type []= []
vars_with_type (x:xs)= ((x, TInt):vars_with_type(xs))

infer_type:: Environment (Type p) -> Expr p -> Type p

infer_type env (ENum _ _) = TInt
infer_type env (EBool _ _) = TBool
infer_type env (EVar p x) =
    let xtype= Map.lookup x env in
      if is_nothing xtype then TError p "Undefined Variable"
      else fromJust xtype

infer_type env (EUnary p UNot x ) =
  let xt= infer_type env x in
    if is_tbool xt then TBool
    else TError p "Types dont match"
infer_type env (EUnary p UNeg x) =
  let xt= infer_type env x in
    if is_tint xt then TInt
    else TError p "Types dont match"

infer_type env (EBinary p op e1 e2) =
  let e1t= infer_type env e1
      e2t= infer_type env e2 in
      if is_error e1t then e1t
      else if is_error e2t then e2t
      else
        if same_type (actual_type op e1t e2t) (expected_type op) then (expected_type op)
        else  TError p "Types dont match"

infer_type env (ELet p var e1 e2) =
  let e1t= infer_type env e1 in
    if is_error e1t then e1t
    else infer_type (Map.insert var e1t env) e2

infer_type env (EIf p e1 e2 e3) =
  let e1t= infer_type env e1 in
    if is_tbool e1t then
      let e2t= infer_type env e2
          e3t= infer_type env e3 in
          if is_error e2t then e2t
          else if is_error e3t then e3t
          else
            if same_type e2t e3t then e2t
            else TError p "Types dont match"
    else TError p "Types dont match"


is_error (TError p s)= True
is_error _ =False

is_nothing Nothing = True
is_nothing _ = False

is_tbool TBool =True
is_tbool _= False

is_tint TInt = True
is_tint _=  False

same_type TInt TInt = True
same_type TBool TBool =True
same_type _ _=False

expected_type:: BinaryOperator -> Type p
expected_type op
  | arithmetic_operator op = TInt
  | compare_operator op = TBool
  | bool_operator op = TBool

actual_type op t1 t2
  | arithmetic_operator op =
      if is_tint t1 && is_tint t2 then TInt else TErr
  | compare_operator op =
      if is_tint t1 && is_tint t2 then TBool else TErr
  | bool_operator op =
      if is_tbool t1 && is_tbool t2 then TBool else TErr

arithmetic_operator op = elem op [BAdd, BSub, BMul, BDiv, BMod]
compare_operator op = elem op [BEq, BNeq, BGt, BLt, BLe, BGe]
bool_operator op = elem op [BAnd, BOr]


-- Funkcja obliczająca wyrażenia
-- Dla wywołania eval input e przyjmujemy, że dla każdej pary (x, v)
-- znajdującej się w input, wartość zmiennej x wynosi v.
-- Możemy założyć, że wyrażenie e jest dobrze typowane, tzn.
-- typecheck (map fst input) e = Ok
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.
eval :: [(Var,Integer)] -> Expr p -> EvalResult
eval x y = get_answer(value (int_to_val x) y)

int_to_val [] =[]
int_to_val ((a, x):xs)= ((a, VInt x):int_to_val xs)

get_answer VError = RuntimeError
get_answer (VInt x) = (Value x)

value list e = get_value (Map.fromList list) e


data Val = VInt Integer | VBool Bool | VError deriving (Eq, Show)
type Environment t = Map.Map Var t

get_value:: Environment Val -> Expr p -> Val

get_value env (ENum _ x)= VInt x
get_value env (EBool _ x)=VBool x
get_value env (EVar _ x) = if value== Nothing then VError else fromJust value where value= Map.lookup x env

get_value env (EUnary _ op e)= let ve= get_value env e in
  if ve==VError then VError
  else unary_operation ve

get_value env (EBinary _ op e1 e2) =
  let ve1 = get_value env e1 in
    let ve2= get_value env e2 in
      if (ve1==VError || ve2==VError) then VError
      else binary_operation op ve1 ve2

get_value env (EIf _ e1 e2 e3)=
  let ve1= get_value env e1 in
    if ve1== VError then VError
    else if_operation env ve1 e2 e3

get_value env (ELet _ var e1 e2)=
  let ve1= get_value env e1 in
    if ve1== VError then VError
    else get_value (Map.insert var ve1 env) e2


unary_operation (VBool x)=  VBool (not x)
unary_operation (VInt x)= VInt (-x)

binary_operation BAnd (VBool a) (VBool b) = VBool (a && b)
binary_operation BOr (VBool a) (VBool b) = VBool (a || b)

binary_operation BEq (VInt a) (VInt b) = VBool (a==b)
binary_operation BNeq (VInt a) (VInt b) = VBool (a/=b)
binary_operation BLt (VInt a) (VInt b) = VBool (a<b)
binary_operation BGt (VInt a) (VInt b) = VBool (a>b)
binary_operation BLe (VInt a) (VInt b) = VBool (a<=b)
binary_operation BGe (VInt a) (VInt b) = VBool (a>=b)

binary_operation BAdd (VInt a) (VInt b) = VInt (a+b)
binary_operation BSub (VInt a) (VInt b) = VInt (a-b)
binary_operation BMul (VInt a) (VInt b) = VInt (a*b)
binary_operation BDiv (VInt a) (VInt b)
  | b==0 = VError
  | otherwise = VInt (div a b)
binary_operation BMod (VInt a) (VInt b)
  | b==0 = VError
  | otherwise =VInt (mod a b)

if_operation env (VBool condition) e1 e2 =
  if condition==True then get_value env e1
  else get_value env e2
