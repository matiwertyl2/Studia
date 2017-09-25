fib:: Integer -> Integer
fib n = fst (fib2 n)

fib2:: Integer -> (Integer, Integer)
fib2 0= (0, 1)
fib2 n = (snd w, fst w + snd w) where
        w= fib2 (n-1)
