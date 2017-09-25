class MyEnum a where
  from  :: a -> Int
  to :: Int -> a

instance (MyEnum x, MyEnum y) => MyEnum (x, y) where
  from (x, y)= (from x) + (from y)
  to n = ((to x), (to x))
