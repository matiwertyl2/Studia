using PyPlot
using Polynomials

function fscalar(Pk, X, Y)
    return sum([polyval(Pk, X[i])*Y[i] for i in 1:length(X)])
end

function scalar(Pi, Pj, X)
    return sum( [polyval(Pi, X[i])*polyval(Pj, X[i]) for i in 1:length(X)] )
end

function ortPolyBase(X, Y, n)
    base = []
    push!(base, Poly([1]))
    c1 = scalar(base[1], Poly([0, 1]), X ) / scalar(base[1], base[1], X)
    push!(base, Poly([-c1, 1]))
    for i in 2:n
        c = scalar(Poly([0, 1])*base[i], base[i], X) / scalar(base[i], base[i], X)
        d = scalar(base[i], base[i], X) / scalar(base[i-1], base[i-1], X)
        P = Poly([-c, 1]) * base[i] - d*base[i-1]
        push!(base, P)
    end
    return base
end

function approx(X, Y, n)
    base = ortPolyBase(X, Y, n)
    polyapprox = Poly([0])
    for i in 1:(n+1)
        Pi = fscalar(base[i], X, Y) / scalar(base[i], base[i], X) * base[i]
        polyapprox += Pi
    end
    return polyapprox
end

function polydraw(P, a, b)
    dx = (b-a)/300
    x = a
    res = [[],[]]
    while x <= b
        push!(res[1], x)
        push!(res[2], polyval(P, x))
        x += dx
    end
    res
end

#=XX = [0.0, 10.0, 20.0, 30.0, 40.0, 80.0, 90.0, 95.0]
YY = [68.0, 67.1, 66.4, 65.6, 64.6, 61.8, 61.0, 60.0]
P = approx(XX, YY, 1)
println(P)

fig, ax = subplots()

Pdraw = polydraw(P, XX[1], XX[length(XX)])
x = Pdraw[1]
y = Pdraw[2]


ax[:plot](x, y, "-", color="blue", linewidth=1, alpha=1.0)
ax[:plot](XX, YY, ".", color="black", linewidth=1, alpha=1.0)
show() =#

#A = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
#B = [13, 7, 6, 5, 6, 15, 17, 12, 8, 2, 13, 14, 15, 16, 17, 19, 21, 23, 12, 1]
A= []
B = []

for i in 1:50
    x = 0.1 * (i-20)
    push!(A, x)
    push!(B, 4*(x + rand())^2)
end
P = approx(A, B, 2)
println(P)

fig, ax = subplots()

Pdraw = polydraw(P, A[1], A[length(A)])
x = Pdraw[1]
y = Pdraw[2]

ax[:plot](x, y, "-", color="blue", linewidth=1, alpha=1.0)
ax[:plot](A, B, ".", color="black", linewidth=1, alpha=1.0)
show()
