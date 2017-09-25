import Control.Monad
import Data.List

sublist [] = [[]]
sublist (x:xs) =  (map (x:) (sublist xs) )  ++ (sublist xs)

sublist2 [] = [[]]
sublist2 (x:xs) = [ z | ys <- sublist xs, z <- [x:ys, ys]]

sublist3 [] = return []
sublist3 (x:xs) = do
    ys <- sublist xs
    res <- headOrNot x ys
    return res

headOrNot x ys = [x:ys, ys]
