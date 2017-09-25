data Cyclist a= Elem (Cyclist a) a (Cyclist a) deriving (Show)


fromList:: [a] -> Cyclist a

fromList (x:xs) = res
  where
      res = Elem last x next
      (next, last) = aux res xs res

aux prev [] first = (first, prev)
aux prev (x:xs) first = (this, last)
  where
      this = Elem prev x next
      (next, last) = aux this xs first


forward:: Cyclist a -> Cyclist a
forward ( Elem _ _ x) =x


backward:: Cyclist a -> Cyclist a
backward (Elem x _ _) = x

label:: Cyclist a -> a
label (Elem _ x _) =x


enumInts :: Cyclist Integer

enumInts = Elem neg 0 pos where
    pos= positive enumInts 1
    neg = negative enumInts (-1)

positive :: (Num a) => Cyclist a -> a -> Cyclist a
positive prev curr = this where
    this= Elem prev curr (positive this (curr+1))

negative :: (Num a) => Cyclist a -> a -> Cyclist a
negative next curr = this where
    this = Elem (negative this (curr-1)) curr next
