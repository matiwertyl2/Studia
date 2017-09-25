import Control.Monad
import Data.List

perms [] = [[]]
perms xs = concatMap (\x -> map (x:) (perms $ delete x xs) ) xs
-- bierze kazdy element z listy, wyszczegolnia go jako x (dodaje x na poczatek spermutowanych ogonow) laczy poszczegolne wyniki


perms2 [] = [[]]
perms2 xs = [y:ys | y <- xs, ys <- perms2 $ delete y xs]

perms3 [] = return []
perms3 xs = do
	y <- xs
	ys <- perms3 $ delete y xs
	return (y:ys)
