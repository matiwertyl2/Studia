class Monoid a where
  (***) :: a -> a -> a
  e :: a
  infixl 6 ***

instance Monoid Integer where
    x***y= (x*y) `mod` 9876543210
    e=1

infixr 7 ^^^
(^^^) :: Monoid a => a -> Integer -> a
a^^^0 = e
a ^^^n= if n `mod` 2 == 0 then x***x else a***x***x where x=a^^^(div n 2)


data Mtx2x2 a = Mtx2x2 a a a a deriving Show

instance Num a =>  Monoid (Mtx2x2 a) where
  e= Mtx2x2 1 0 0 1
  Mtx2x2 a11 a12 a21 a22 *** Mtx2x2 b11 b12 b21 b22 = Mtx2x2 (a11*b11+a12*b21) (a11*b12+a12*b22) (a21*b11+a22*b21) (a21*b12+a22*b22)

class Klasa a where
    (****) :: a -> a
