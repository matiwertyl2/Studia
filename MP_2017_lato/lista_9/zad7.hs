import Data.List
import Data.Char

data FSet a= FSet (a -> Bool)

empty :: FSet a
empty = FSet (\_ -> False)

singleton :: Ord a => a -> FSet a
singleton a = FSet (\x -> x == a)

fromList :: Ord a => [a] -> FSet a
fromList l = FSet (\x -> x `elem` l)

union' :: Ord a => FSet a -> FSet a -> FSet a
union' (FSet f) (FSet g) = FSet (\x -> f x || g x)

intersection :: Ord a => FSet a -> FSet a -> FSet a
intersection (FSet f) (FSet g) = FSet (\x -> f x && g x)

member :: Ord a => a -> FSet a -> Bool
member a (FSet f) = f a
