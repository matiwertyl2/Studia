{-# LANGUAGE Safe #-}
module MateuszHazy (typecheck, eval) where

import AST
import DataTypes
import qualified Data.Map as Map
import Data.Maybe

-- sprawdzanie typow

typecheck :: [FunctionDef p] -> [Var] -> Expr p -> TypeCheckResult p
typecheck  functions vars e =
  let fcheck= check_functions functions (init_fun_env functions) in
    if is_ok fcheck then get_type_answer ( infer_type (init_env vars) (init_fun_env functions)  e) e
    else get_funerror_answer fcheck

data Typ p
  = TypInt
  | TypBool
  | TypError p String
  | TypErr
  | TypUnit
  | TypPair (Typ p) (Typ p)
  | TypList (Typ p)
  | TypFun (Typ p) (Typ p)
  deriving (Eq, Show)

data Fcheck p
  = Oks
  | FError p

is_ok Oks = True
is_ok _ = False

get_funerror_answer (FError p) = Error p "Wrong function type"

get_type_answer (TypError p err) e= Error p err
get_type_answer TypInt e= Ok
get_type_answer _ e= Error (get_position e) "Wrong Output"

check_functions [] functions = Oks
check_functions (f:fs) functions = let fcheck= check_function f functions in
  if is_ok fcheck then check_functions fs functions
  else fcheck

check_function f functions=
  let argtype= funcArgType f
      restype = funcResType f
      e = funcBody f
      var = funcArg f in
      let env= Map.fromList ([(var, convert_type(argtype))]) in
        let etype = infer_type env functions  e in
          if same_type (convert_type restype) etype then Oks
          else FError (funcPos f)

get_position (ENum p x) =p
get_position (EVar p x )=p
get_position( EBool p x)= p
get_position(EUnary p op x)=p
get_position (EBinary p op x y) =p
get_position (ELet p x y z) =p
get_position (EIf p x y z)=p
get_position (EApp p x y)=p
get_position (EUnit p)=p
get_position (EPair p x y)=p
get_position (EFst p x)= p
get_position (ESnd p x)=p
get_position (ENil p x)=p
get_position (ECons p x y)=p
get_position (EMatchL p x y z)=p

fun_with_names []= []
fun_with_names (f:fs) = (funcName f, f):(fun_with_names fs)

init_fun_env functions = Map.fromList (fun_with_names functions)

init_env vars = Map.fromList(vars_with_type vars)

vars_with_type []= []
vars_with_type (x:xs)= ((x, TypInt):vars_with_type(xs))


infer_type env functions (ENum _ _) = TypInt
infer_type env functions (EBool _ _) = TypBool
infer_type env functions (EVar p x) =
    let xtype= Map.lookup x env in
      if is_nothing xtype then TypError p "Undefined Variable"
      else fromJust xtype
infer_type env functions (EUnit p)= TypUnit

infer_type env functions (EPair p e1 e2)=
  let t1= infer_type env functions e1
      t2= infer_type env functions e2 in
      if (is_error t1) then t1
      else if (is_error t2) then t2
      else (TypPair t1 t2)

infer_type env functions (EFst p e)=
  let t= infer_type env functions e in
    if is_error t then t
    else if (is_pair t) then get_type_first t
    else TypError p "Not a pair"

infer_type env functions (ESnd p e) =
  let t = infer_type env functions e in
    if is_error t then t
    else if (is_pair t) then get_type_second t
    else TypError p "Not a pair"

infer_type env functions (ENil p t) =  let  typ= (convert_type t) in
  if is_list typ then typ
  else TypError p "types dont match"

infer_type env functions (ECons p e1 e2) =
  let t1= infer_type env functions e1
      t2= infer_type env functions e2 in
      if is_error t1 then t1
      else if not (is_list t2) then TypError p "Not a List"
      else if same_type t1 (get_type_list t2) then (TypList t1)
      else (TypError p ("Types dont match"))

infer_type env functions (EMatchL p e nil cons) =
  let t0= infer_type env functions e in
    if not( is_list t0) then TypError p "Not a List"
    else
      let t1 = nilClause_type env functions nil
          t2 = consClause_type env functions cons (get_type_list t0) in
          if is_error t1 then t1
          else if is_error t2 then t2
          else if (same_type t1 t2) then t1
          else TypError p "Types Dont match"

infer_type env functions (EApp p name arg) =
  let targ= infer_type env functions arg
      tin = get_fun_in_type functions name
      tout = get_fun_out_type functions name in
      if is_error targ then targ
      else if (isNothing tin) || (isNothing tout) then TypError p "Undefined function"
      else
        if same_type targ (fromJust tin) then fromJust(tout)
        else TypError p "Types dont match"

infer_type env functions (EUnary p UNot x ) =
  let xt= infer_type env functions  x in
    if is_tbool xt then TypBool
    else TypError p "Types dont match"
infer_type env functions (EUnary p UNeg x) =
  let xt= infer_type env functions x in
    if is_tint xt then TypInt
    else TypError p "Types dont match"

infer_type env functions (EBinary p op e1 e2) =
  let e1t= infer_type env functions e1
      e2t= infer_type env functions e2 in
      if is_error e1t then e1t
      else if is_error e2t then e2t
      else
        if same_type (actual_type op e1t e2t) (expected_type op) then (expected_type op)
        else  TypError p "Types dont match"

infer_type env functions (ELet p var e1 e2) =
  let e1t= infer_type env functions e1 in
    if is_error e1t then e1t
    else infer_type (Map.insert var e1t env) functions e2

infer_type env functions (EIf p e1 e2 e3) =
  let e1t= infer_type env functions e1 in
    if is_tbool e1t then
      let e2t= infer_type env functions e2
          e3t= infer_type env functions e3 in
          if is_error e2t then e2t
          else if is_error e3t then e3t
          else
            if same_type e2t e3t then e2t
            else TypError p "Types dont match"
    else TypError p "Types dont match"

get_fun_in_type functions f =
  let x= (Map.lookup f functions) in
    if isNothing x then Nothing
    else Just (convert_type (funcArgType (fromJust x)))

get_fun_out_type functions f=
  let x= (Map.lookup f functions) in
    if isNothing x then Nothing
    else Just (convert_type (funcResType (fromJust x)))

nilClause_type env functions e= infer_type env functions e

consClause_type env functions (x, y , e) typ =
  let envnew = Map.insert x typ (Map.insert y (TypList typ) env) in
    infer_type envnew functions e

convert_type TInt= TypInt
convert_type TBool = TypBool
convert_type TUnit = TypUnit
convert_type (TPair a b)= TypPair (convert_type a) (convert_type b)
convert_type (TList t) = TypList (convert_type t)

wypisz_typ (TypError p s)  = " ERROR "
wypisz_typ TypInt = " INT "
wypisz_typ (TypList t) = " LIST " ++  (wypisz_typ t)

is_error (TypError p s)= True
is_error _ =False

is_nothing Nothing = True
is_nothing _ = False

is_tbool TypBool =True
is_tbool _= False

is_tint TypInt = True
is_tint _=  False

is_pair (TypPair t1 t2)= True
is_pair _=False

is_list (TypList _) = True
is_list _= False

get_type_first (TypPair t1 t2) = t1
get_type_second (TypPair t1 t2) =t2

get_type_list (TypList t)=t

same_type TypInt TypInt = True
same_type TypBool TypBool =True
same_type TypUnit TypUnit = True
same_type (TypList t1) (TypList t2) =
    if same_type t1 t2 then True
    else False
same_type (TypPair a1 a2) (TypPair b1 b2) =
  if (same_type a1 b1) && (same_type a2 b2) then True
  else False
same_type (TypFun a1 a2) (TypFun b1 b2) =
  if (same_type a1 b1) && (same_type a2 b2) then True
  else False
same_type _ _=False

expected_type op
  | arithmetic_operator op = TypInt
  | compare_operator op = TypBool
  | bool_operator op = TypBool

actual_type op t1 t2
  | arithmetic_operator op =
      if is_tint t1 && is_tint t2 then TypInt else TypErr
  | compare_operator op =
      if is_tint t1 && is_tint t2 then TypBool else TypErr
  | bool_operator op =
      if is_tbool t1 && is_tbool t2 then TypBool else TypErr

arithmetic_operator op = elem op [BAdd, BSub, BMul, BDiv, BMod]
compare_operator op = elem op [BEq, BNeq, BGt, BLt, BLe, BGe]
bool_operator op = elem op [BAnd, BOr]

-- wyliczanie wartosci

data Val
  = VInt Integer
  | VBool Bool
  | VUnit
  | VList [Val]
  | VPair (Val, Val)
  | VError deriving (Eq, Show)

eval :: [FunctionDef p] -> [(Var,Integer)] -> Expr p -> EvalResult
eval functions x y = get_answer(value (int_to_val x) (func_init functions) y)

int_to_val [] =[]
int_to_val ((a, x):xs)= ((a, VInt x):int_to_val xs)

func_init [] = []
func_init (x:xs) = (funcName x, (funcArg x, funcBody x)):(func_init xs)

get_answer VError = RuntimeError
get_answer (VInt x) = (Value x)

value list functions e = get_value (Map.fromList list) (Map.fromList functions) e

get_value env functions (ENum _ x)= VInt x
get_value env functions (EBool _ x)=VBool x
get_value env functions (EVar _ x) = if value== Nothing then VError else fromJust value where value= Map.lookup x env
get_value env functions (EPair _ e1 e2) =
    let f=get_value env functions e1
        s=get_value env functions e2 in
        if (f==VError) || (s==VError) then VError
        else VPair (f, s)

get_value env functions (EUnit _) = VUnit

get_value env functions (EFst _ e) = let v= get_value env functions e in
  if v==VError then VError
    else get_first v
get_value env functions (ESnd _ e) = let  v= get_value env functions e in
  if v== VError then VError
    else get_second v

get_value env functions (EUnary _ op e)= let ve= get_value env functions e in
  if ve==VError then VError
  else unary_operation ve

get_value env functions (EBinary _ op e1 e2) =
  let ve1 = get_value env functions e1 in
    let ve2= get_value env functions e2 in
      if (ve1==VError || ve2==VError) then VError
      else binary_operation op ve1 ve2

get_value env functions (EIf _ e1 e2 e3)=
  let ve1= get_value env functions  e1 in
    if ve1== VError then VError
    else if_operation env functions ve1 e2 e3

get_value env functions (ELet _ var e1 e2)=
  let ve1= get_value env functions e1 in
    if ve1== VError then VError
    else get_value (Map.insert var ve1 env) functions e2

get_value env functions (EApp _ name arg) =
  let argvalue= get_value env functions arg in
    if argvalue== VError then VError
    else
      let envf= (create_function_environment functions name argvalue) in
          let fBody = get_function_body functions name in
          if (isNothing fBody) then VError
            else get_value (fromJust envf) functions (fromJust fBody)

get_value env functions (ENil _ _) = VList []

get_value env functions (ECons _ e1 e2) =
    let v1= get_value env functions e1 in
      let v2= get_value env functions e2 in
        if (v1 == VError) || (v2== VError) then VError
          else VList (v1:(get_value_list v2))

get_value env functions (EMatchL _ e nil cons) =
  let v= get_value env functions e in
    if v==VError then VError
      else
         if empty_list v then nilClause_case env functions nil
           else consClause_case env functions cons v

consClause_case env functions (x, y, e) (VList (v0:vs)) =
  get_value newenv functions  e where
    newenv= Map.insert x v0 (Map.insert y (VList vs) env)

nilClause_case env functions e = get_value env functions e

empty_list (VList []) = True
empty_list _ = False

get_value_list (VList x)=x

get_function_body functions f =
  let p= Map.lookup f functions in
  if (isNothing p) then Nothing
    else Just ( snd (fromJust p) )

create_function_environment functions f argV =
  let x=Map.lookup f functions in
    if (isNothing x) then Nothing
      else Just (Map.fromList [(fst (fromJust x) , argV)])

get_first (VPair (v1, _))= v1
get_second (VPair (_, v2))=v2

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

if_operation env functions (VBool condition) e1 e2 =
  if condition==True then get_value env functions e1
  else get_value env functions e2
