--roots :: (Double, Double, Double) -> [Double]

--roots (0, 0, 0) = error "Infinite roots"
--roots (0, 0, _) = []
--roots (0, b, c) = [-b/c]
--roots (a, b, c) =
--  let d= b*b - 4*a*c in
--    case compare d 0 of
--      LT -> []
--      EQ -> [-b/(2*a)]
--      GT -> [(-b - sqrt(d))/(2*a), (-b + sqrt(d))/(2*a)]


data Roots = No
            | One Double
            | Two (Double, Double)
            deriving Show

roots:: (Double, Double, Double) -> Roots
roots(0, 0, 0) = error "Infinite Roots"
roots(0, 0, _) = No
roots(0, b, c) = One (-b/c)
roots(a, b, c) =
  let d = b*b - 4*a*c in
    case compare d 0 of
      LT -> No
      EQ -> One (-b/2*a)
      GT -> Two ((-b-sqrt(d))/(2*a), (-b+sqrt(d))/(2*a))
