x= Float64(1)
while true
  x= nextfloat(x)
  if x * (1/x) != 1
    println(x)
    println(bits(x))
    println(bits(1/x))
    println(x*(1/x))
    println(bits(x*(1/x)))
    break
  end
end
