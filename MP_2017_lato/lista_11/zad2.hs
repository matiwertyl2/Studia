ssm :: [Integer] -> [Integer]
ssm x = reverse (foldl aux [] x)

aux :: [Integer] -> Integer -> [Integer]
aux [] a = [a]
aux (x:xs) a
	|	a < x			=	x:xs
  |	otherwise =	a:x:xs


foldr f e xs = foldl (flip f) e (reverse xs)
