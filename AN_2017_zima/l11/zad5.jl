function Simpson(f, a, b, n)
    X = [a+i*(b-a)/n for i=0:n]
    F = [f(X[i]) for i=1:(n+1)]
    for i in 1:(n+1)
        if i != 1 && i !=(n+1)
            if i % 2 == 0
                F[i] *= 4
            else
                F[i] *= 2
            end
        end
    end
    sum(F)*(b-a)/(3*n)
end

println(-cos(pi)+cos(0))
println(Simpson(sin, 0, pi, 1000))
