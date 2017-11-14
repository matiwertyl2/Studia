function rev(c)
    x = BigFloat(0.66)
    for i in [1:20;]
        x = x*(2 - c*x)
        println(c," ", x," " ,c*x)
    end
end


rev(BigFloat(3.0))
