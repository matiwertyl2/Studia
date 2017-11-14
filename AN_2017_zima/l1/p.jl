function foo(realType)
  x = realType(4.71)
  resGood = realType(-14.636489)
  res1 = realType(x*x*x - realType(6.0)*x*x + realType(3.0)*x - realType(0.149))
  res2 = realType((  (x-realType(6.0))*x + realType(3.0))*x - realType(0.149))
  d1 = realType((res1 - resGood)/res1)
  d2 = realType((res2 - resGood)/res2)
  println(realType, " ", d1, " ", d2)
end

foo(Float64)
foo(Float32)
foo(Float16)
