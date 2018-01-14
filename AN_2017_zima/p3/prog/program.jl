using PyPlot

### evaluacja wielomianow Czebyszewa
function ChebEval(k, x)
    return cos(k*acos(x))
end

### ewaluacja funkcji Y w punkatch uk
### Y przedstawiona jako ciag wielomianow czebyszewa (trzymane wspolczynniki)
function YEval(coeffs, N)
    restmp = [ sum([coeffs[i]*ChebEval(i-1, cos((k-1)*pi/N)) for i=1:length(coeffs) ]) for k=1:(N+1) ]
    [ restmp[i] - coeffs[1]/2 for i=1:(N+1)] ### suma z primem
end

### ewaluacja funkcji F w punkatch uk F(y, x)
### Y - wartosci y w uk
function FEval(f, Y, N)
    [f(Y[i], cos((i-1)*pi/N)) for i=1:(N+1)]
end

function discreteCoeff(F, r, N)
    cr = sum( [ F[s]*cos( pi*r*(s-1)/N ) for s=1:(N+1)])
    cr -= (F[1] + F[N+1]*cos(pi*r)) /2 ### suma z 2 primami
    cr *= (2/N)
    if r == N
        cr /= 2
    end
    cr
end

### y - funkcja jako lista wspoczynnikow ciagu czebyszewa
function FApprox(f, y, N)
    Y = YEval(y, N)
    F = FEval(f, Y, N)
    println("Values ", F)
    Fapp = [discreteCoeff(F, i-1, N) for i=1:(N+1)]
    println(YEval(Fapp, N))
    Fapp
end

### calkowanie ciagu wieloamianow Czebyszewa
### f to aprkosymacja funkcji czebyszewami, lista wspolczynnikow
function ChebIntegral(f, x0, y0, N)
    A = zeros(N+2)
    for r=2:N
        A[r] = (f[r-1] - f[r+1]) /(2*(r-1))
    end
    A[N+1] = f[N]/(2*N)
    A[N+2] = f[N+1]/(2*(N+1))
    A[1] = 2*(y0 - sum([ A[i]*ChebEval(i-1, x0) for i=2:(N+2) ]))
    A
end

function PicardIter(f, x0, y0, N, R)
    Y = [2*y0]
    for i=1:R
        F = FApprox(f, Y, N)
        Y = ChebIntegral(F, x0, y0, N)
        println("IN X0 ", YSingleEval(Y, 0))
    end
    return Y
end

### utils
function YSingleEval(coeffs, x)
    sum([coeffs[i]*ChebEval(i-1, x) for i=1:length(coeffs)]) - coeffs[1]/2
end

function ChebDraw(Y, a, b, n)
    res = [[],[]]
    x = a
    dx = (b-a)/n
    while x <= b
        push!(res[1], x)
        push!(res[2], YSingleEval(Y, x))
        x+=dx
    end
    res
end

function FDraw(f, a, b, n)
    res = [[],[]]
    x = a
    dx = (b-a)/n
    while x <= b
        push!(res[1], x)
        push!(res[2], f(x))
        x+=dx
    end
    res
end

###

function myabs(x)
    if x < 0
        return 0
    end
    return x
end
function f(y, x)
    4*cos(4*x)
end


###
### x -> 2sin(x)/cos(x) -2*sin(x)^3/(3*cos(x)) + 1/cos(x)
###     2*(cos(x)^2) + y*tan(x)
### y(0) = 1

### x -> e^(-2x) + (e^(3x))/5
### e^(3x) - 2y
### y(0) = 1+ 1/5



Y = PicardIter(f, 0, 0,20, 3)

data = ChebDraw(Y, -1, 1, 500)
datae = FDraw(x -> sin(4*x), -1, 1, 500)
fig, ax = subplots()
ax[:plot](data[1], data[2], "-", color="red", label="approx", linewidth=1, alpha=1.0)
ax[:plot](datae[1], datae[2], "-", color="blue", label="real", linewidth=1, alpha=1.0)
#ax[:plot](data[1], data[2]-datae[2], "-", color="blue", linewidth=1, alpha=1.0)
show()
