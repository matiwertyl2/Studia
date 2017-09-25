import Control.Monad
import Data.List

prod xs = foldM (\t a -> if a == 0 then Nothing else Just (a*t)) 1 xs

prod2 xs = foldr (\n p -> if n==0 then 0 else p*n) 1 xs
