using Polynomials
using QuadGK

function coeff(X, k, a, b)
    P = Poly([1])
    for j in 1:length(X)
        if j != k
            P *= Poly([-X[j], 1])
            P /= (X[k]-X[j])
        end
    end
    res = quadgk(x -> polyval(P, x), a, b)[1]
    #println(res)
    res
end

function QNC(f, a, b, n)
    X = [a+ i*(b-a)/n for i=0:n]
    A = [coeff(X, k+1, a, b) for k =0:n]
    Ip = sum([ A[i]*f(X[i]) for i = 1:(n+1) ])
    Ip
end

function foo(x)
    1/(1+x^2)
end

function check(n)
    x = QNC(foo, -4, 4, n)
    println(n, " ", "VALUE ", x, " MISTAKE ", x - 2*atan(4))
end

check(2)
check(4)
check(6)
check(8)
check(10)
