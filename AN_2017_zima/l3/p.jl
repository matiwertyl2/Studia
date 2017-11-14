newtons = Dict()

function newton(n, k)
    if k == 0 || k == n
        newtons[(n, k)]= 1
        return BigInt(1)
    end
    res = BigInt(0)
    if haskey(newtons, (n, k))
        return newtons[(n, k)]
    end
    return newtons[(n, k)]= newton(n-1, k-1) + newton(n-1, k)

end


solve = BigInt(newton(26, 13) * ( newton(39, 13) * 16 - 72 ) + 72 )
println(solve)
omega = BigInt(newton(52, 13) * newton(39, 13) * newton(26, 13))
println(omega)
println(Float64(solve/omega))
