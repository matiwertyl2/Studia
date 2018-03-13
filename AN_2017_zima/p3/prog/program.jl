using PyPlot

### evaluacja wielomianow Czebyszewa
function ChebEval(k, x)
    return cos(k*acos(x))
end

### ewaluacja Y w punkcie x
function YSingleEval(coeffs, x)
    sum([coeffs[i]*ChebEval(i-1, x) for i=1:length(coeffs)]) - coeffs[1]/2
end

### ewaluacja funkcji Y w punkatch uk
### Y przedstawiona jako ciag wielomianow czebyszewa (trzymane wspolczynniki)
function YEval(coeffs, N)
    [ YSingleEval( coeffs, cos((k-1)*pi/N) ) for k=1:(N+1) ]
end

function YValues(Y, i)
    [Y[k][i] for k = 1:length(Y)]
end

### ewaluacja funkcji F w punkatch uk F(y, x)
### Y - wartosci y w uk
function FEval(f, Y, N)
    [f(YValues(Y, i), cos((i-1)*pi/N)) for i=1:(N+1)]
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
    Y = [YEval(y[i], N) for i=1:length(y)]
    F = FEval(f, Y, N)
    Fapp = [discreteCoeff(F, i-1, N) for i=1:(N+1)]
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


### szczegolny przypadek uogolnionej metody - rownanie pierwszego rzedu
function PicardIter(f, x0, y0, N, Y)
    function farr(arr, x)
        y = arr[1]
        f(y, x)
    end
    PicardIterG(farr, [x0], [y0], N, Y)
end

### x0, y0 - tablice warunkow poczatkowych
### y0[1] wartosc najwyzszej pochodnej w rownaniu w punkcie x0[1]
function PicardIterG(f, x0, y0, N, Y)
    F = FApprox(f, Y, N)
    Y[1] = ChebIntegral(F, x0[1], y0[1], N)
    for i = 2:length(Y)
        Y[i] = ChebIntegral(Y[i-1], x0[i], y0[i], N+i-1)
    end
    Y
end


### petla iteracji Picarda dla ustalonej liczby iteracji
function PicardLoopG(f, x0, y0, N, R)
    Y = [ [2*y0[i]] for i=1:length(y0)]
    iters = [Y[end]]
    for iter=1:R
        Y = PicardIterG(f, x0, y0, N, Y)
        push!(iters, Y[end])
    end
    iters
end

function PicardLoop(f, x0, y0, N, R)
    function farr(arr, x)
        y = arr[1]
        f(y, x)
    end
    PicardLoopG(farr, [x0], [y0], N, R)
end


### funkcja znajdujaca najwiekszy modul z roznicy
### wspolczynników kolejnych przyblizen funkcji w iteracji
function norminf(A, B)
    n = min(length(A), length(B))
    m = maximum([abs( A[i]-B[i] ) for i=1:n])
    for i=(n+1):length(A)
        m = max(m, abs(A[i]))
    end
    for i=(n+1):length(B)
        m = max(m, abs(B[i]))
    end
    m
end

### iteracja Picarda do momentu uzyskania wymaganej dokładnosci
function PicardLoopG_conv(f, x0, y0, N; e=0.001)
    Y = [ [2*y0[i]] for i=1:length(y0)]
    Yprev = []
    iters = 0
    while true
        iters += 1
        Yprev = copy(Y)
        Y = PicardIterG(f, x0, y0, N, Y)
        if (norminf(Y[end], Yprev[end]) < e)
            break
        end
    end
    Y[end], iters
end

function PicardLoop_conv(f, x0, y0, N; e=0.001)
    function farr(arr, x)
        y = arr[1]
        f(y, x)
    end
    PicardLoopG_conv(farr, [x0], [y0], N, e=e)
end



### utils

function ChebDraw(Y, a, b, n)
    FDraw(x -> YSingleEval(Y,x), a, b, n)
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
