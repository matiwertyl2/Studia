using QuadGK
using Polynomials
using PyPlot

### ------------------- utils -----------------###

function normInf(P, f, N, a, b)
    res = 0.0
    for k in 0:N
        x = a + (b-a)*k/N
        res = max(res, abs(polyval(P, x)-f(x)))
    end
    res
end

function fdraw(f, a, b)
    N = 1000
    res = [[],[]]
    for i in 0:N
        x = a + (b-a)*i / N
        push!(res[1], x)
        push!(res[2], f(x))
    end
    res
end

function polydraw(P, a, b)
    fdraw( x -> polyval(P, x), a, b)
end

### -------------------------------------------###

### ---------- APPROX ------------------------ ###

function fscalar(f, W, p, a, b)
    F = x -> f(x) * polyval(W, x) * p(x)
    quadgk(F, a, b)[1]
end

function scalar(W1, W2, p, a, b)
    F = x ->  p(x) * polyval(W1, x) * polyval(W2, x)
    quadgk(F, a, b)[1]
end

function ortPolyBase(p, n)
    base = []
    push!(base, Poly([1]))
    c1= scalar(base[1], Poly([0, 1]), p,-1, 1 ) / scalar(base[1], base[1], p, -1, 1)
    push!(base, Poly([-c1, 1]))
    for i in 2:n
        c = scalar(Poly([0, 1])*base[i], base[i], p, -1, 1) / scalar(base[i], base[i], p, -1, 1)
        d = scalar(base[i], base[i], p, -1, 1) / scalar(base[i-1], base[i-1], p, -1, 1)
        P = Poly([-c, 1]) * base[i] - d*base[i-1]
        push!(base, P)
    end
    return base
end

function approximate(f, p, n)
    Polys = ortPolyBase(p, n)
    A = Poly([0])
    for i in 1:(n+1)
        b = fscalar(f, Polys[i], p, -1, 1) / scalar(Polys[i], Polys[i], p, -1, 1)
        A = A + b*Polys[i]
    end
    A
end

### -------------------------------------------------###

### ---------------- Inter --------------------------###

function newton_diff(nodes, f)
    n = length(nodes)
    if n == 1
        return f(nodes[1])
    end
    return (newton_diff(nodes[2:n], f) - newton_diff(nodes[1:n-1], f) ) / (nodes[n] - nodes[1])
end

function CzebyszewZeros(n)
    [cos( (2k+1)*pi / (2*n )) for k in 0:(n-1)]
end

function CzebyszewEsktr(n)
    [cos((k*pi)/n) for k in 0:n]
end

function EqualNodes(n)
    [-1 + 2*k/(n-1) for k in 0:(n-1)]
end

function interpolate(nodes, f)
    L = Poly([0])
    P = Poly([1])
    for i in 1:length(nodes)
        L = L + P* newton_diff(nodes[1:i], f)
        P = P * Poly([-nodes[i], 1])
    end
    return L
end

### --------------------------------------------------####

function Runge(x)
    1 / (25x^2 + 1)
end

M = 10

A = interpolate( EqualNodes(M), Runge)
B = interpolate( CzebyszewZeros(M), Runge)
C = interpolate( CzebyszewEsktr(M-1), Runge)
D = approximate(Runge, x -> 1, M-1)
E = approximate(Runge, x ->  1/(0.00000001+ sqrt(1-x^2+0)), M-1)

println("A ", normInf(A, Runge, 1000, -1, 1))
println("B ", normInf(B, Runge, 1000, -1, 1))
println("C ", normInf(C, Runge, 1000, -1, 1))
println("D ", normInf(D, Runge, 1000, -1, 1))
println("E ", normInf(E, Runge, 1000, -1, 1))

#En = x -> (1/sqrt(1-x^2))(Runge(x)-polyval(D, x))^2
#e =sqrt( quadgk(En, -1, 1)[1])
#println("MISTAKE ", e)

dataA = polydraw(A, -1, 1)
dataB = polydraw(B, -1, 1)
dataC = polydraw(C, -1, 1)
dataD = polydraw(D, -1, 1)
dataE = polydraw(E, -1, 1)
dataR = fdraw(Runge, -1, 1)

fig, ax = subplots()
ax[:plot](dataR[1], dataR[2], "-", color="red", label="Runge", linewidth=1, alpha=1.0)
ax[:plot](dataA[1], dataA[2], "-", color="blue", label="A, inter, rownoodlegle", linewidth=1, alpha=1.0)
ax[:plot](dataB[1], dataB[2], "-", color="green", label="B, inter, zera Czebyszewa", linewidth=1, alpha=1.0)
ax[:plot](dataC[1], dataC[2], "-", color="yellow", label ="C, inter, ekstrema Czebyszewa", linewidth=1, alpha=1.0)
ax[:plot](dataD[1], dataD[2], "-", color="orange", label ="D, approx, p=1", linewidth=1, alpha=1.0)
ax[:plot](dataE[1], dataE[2], "-", color="black", label = "E, approx, p - czebyszew", linewidth=1, alpha=1.0)
ax[:legend](bbox_to_anchor=(1.05, 1), loc=1, borderaxespad=0)
show()
