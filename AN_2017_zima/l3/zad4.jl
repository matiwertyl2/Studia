function countPI(precision)
    setprecision(BigFloat, precision)
    s = BigFloat(1) # sin 2pi / 2^k
    c = BigFloat(0) # cos 2pi / 2^k
    p = BigFloat(2)
    for k in [3:precision;]
        println("K = ", k, " PI = ", p)
        s = sqrt((1-c)/2)
        c = sqrt((1+c)/2)
        p = 2^(k-1) * s
    end
end

# sin2x = 2 sinx cosx
# sinx = sin2x / 2cosx
# cos(x/2) = sqrt((1+cosx)/2)
# 2^(k-1)* sin (2pi / 2^k )= pk
# p(k+1) = pk * (2 / 2cos(2pi / 2^(k+1))) = 2^(k-1) * 2 * ( sin(2pi/2^k) / 2cos(2pi/2^(k+1))) =
# = 2^(k) * sin (2pi / 2^(k+1)) = pk / c(k+1)
function countPI2(precision)
    setprecision(BigFloat, precision)
    p = BigFloat(2)
    c = BigFloat(0)
    for k in [3:precision;]
        println("K = ", k, " PI = ", p)
        c = sqrt((1+c)/2)
        p = p/c
    end
end

countPI(256)
countPI2(256)
