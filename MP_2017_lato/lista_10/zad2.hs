halve :: [a] -> ([a], [a])

halve = aux ([], [])
  where
    aux (l1, l2) []= (l1, l2)
    aux (l1, l2) (x1:x2:xs)= aux ((x1:l1), (x2:l2)) xs
    aux (l1, l2) [x]= ((x:l1), l2)


merge :: Ord a => ([a], [a]) -> [a]

merge (x1, x2) = reverse (aux [] (x1, x2))
  where
    aux l ([], (x:xs)) = aux (x:l) ([], xs)
    aux l ((x:xs), []) = aux (x:l) (xs, [])
    aux l ([], []) = l
    aux acc ((l:ls), (r:rs))= if l < r then aux (l:acc) (ls, (r:rs)) else aux (r:acc) ((l:ls), rs)


msort [] = []
msort [x] = [x]
msort xs =
    merge . cross (msort,msort) . halve $ xs

cross :: (a -> c, b-> d) -> (a, b) -> (c, d)
cross (f, g) = pair (f . fst, g . snd)
pair :: (a -> b, a->c) -> a -> (b, c)
pair (f, g) x = (f x, g x)
