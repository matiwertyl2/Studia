

merge (l:ls) (r:rs) = if l < r then (l:merge ls (r:rs) ) else if l > r  then (r: merge (l:ls) rs ) else (r:merge ls rs)


d235:: [Integer]

d235= 1:merge (map (2*) d235) (merge ( map (3*) d235) (map (5*) d235))
