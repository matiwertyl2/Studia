
merge (x1, x2) = reverse (aux [] (x1, x2))
  where
    aux l ([], (x:xs)) = aux (x:l) ([], xs)
    aux l ((x:xs), []) = aux (x:l) (xs, [])
    aux l ([], []) = l
    aux acc ((l:ls), (r:rs))= if l < r then aux (l:acc) (ls, (r:rs)) else aux (r:acc) ((l:ls), rs)



msortn (x:xs) n
  | n==0 = []
  | n==1 = [x]
  | otherwise =
    merge ( msortn (x:xs) (div n 2), msortn (drop (div n 2) (x:xs)) (n- (div n 2)))


msort x = msortn x ( length x)
