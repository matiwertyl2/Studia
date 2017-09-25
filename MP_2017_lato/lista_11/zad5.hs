length1 = foldr (\ _ x -> x+1) 0

length2 = foldl (\ x _ -> x+1) 0

(+++) = flip $ foldr (:)
-- [1, 2, 3] ++ [2, 3, 4] - startujemy od 2 3 4 ( po to flip) potem doklejamy na przod od prawej do lewej 1 2 3

concat1 = foldr (++) []

reverse1 = foldl (flip  (:) ) []

sum1 = foldl (+) 0
