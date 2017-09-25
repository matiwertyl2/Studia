1, 2 :: (Num t) => t
(*) :: (Num a) => a -> a -> a
sin :: (Floating a) => a -> a
map :: (a -> b) -> [a] -> [b]


f x = map -1 x
