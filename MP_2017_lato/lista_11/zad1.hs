import Data.List

myscanr f  a = map ( foldr f  a). tails
