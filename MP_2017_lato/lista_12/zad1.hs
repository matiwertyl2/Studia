import Control.Monad
import Data.List

perm [] = [[]]
perm (x:xs) =  concat (map (insert' x) (perm xs))

perm2 [] = [[]]
perm2 (x:xs) = [z | ys<-perm2 xs, z <- insert' x ys ]

perm3 [] = return []
perm3 (x:xs) = do
		ys <- perm3 xs
		zs <- insert' x ys
		return zs

insert' x [] = [[x]]
insert' x l@(y:ys) = [x:l] ++ (map (y:) $ insert' x ys)


f = [1, 2, 3]
g x = [4, 5, 6]

foo = do
		x <- f
		y <- g x
		return y
