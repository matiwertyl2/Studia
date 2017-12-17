c = 299792458.0

function fsingle(x, sat)
    a = (x - sat) .^ 2
    a[4] *= -c^2
    sum(a)
end

function fvect(x, sats)
    [fsingle(x, sats[i]) for i = 1:length(sats)]
end

function getcoeffs(x, sats)
    A = [x - sats[i] for i = 1:length(sats)]
    println(typeof(A))
    A = hcat(A...)'
    A[:, 4] *= -c^2
    A
end

function newton(sats; maxiter::Int64=15)
    x = [0, 0, 6370, 0]
    for i = 1:maxiter
        A = getcoeffs(x, sats)
        B = fvect(x, sats)
        h = -0.5 * (A \ B)
        x = x + h
    end
    x
end;

sat = Array{Array{Float64}}(4)
sat[1] = [15600,7540,20140, 0.07074e-3]
sat[2] = [18760,2750,18610, 0.07220e-3]
sat[3] = [17610,14630,13480, 0.07690e-3]
sat[4] = [19170,610,18390, 0.07242e-3]

println(newton(sat))
