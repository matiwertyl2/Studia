function create_array(n, m)
    arr = []
    for i in 1:n
        push!(arr, [])
        for j in 1:m
            push!(arr[i], 0.0)
        end
    end
    return arr
end

function Pk(arguments, k)
    if k == 0
        return [1.0]
    end
    Pprev = Pk(arguments, k-1)
    P= [0.0]
    append!(P, Pprev)
    for i in 1:length(Pprev)
        P[i]+= Pprev[i]*(Float64(-arguments[k]))
    end
    return P
end

function ArrC(arr, c)
    for i in 1:length(arr)
        arr[i]*=c;
    end
    return arr;
end

function ArrSum(arr1, arr2)  # assuming arr2 is shorter
    for i in 1:length(arr2)
        arr1[i]+=arr2[i]
    end
    return arr1
end

function Newton_Interpolation(arguments, values)
    n = length(arguments)
    factors = create_array(n, n)
    for i in 1:n
        factors[i][i]= Float64(values[i])
    end
    for k in 1:(n-1)
        for i in 1:(n-k)
            factors[i][i+k]= (factors[i+1][i+k]-factors[i][i+k-1])/(Float64(arguments[i+k]) - Float64(arguments[i]))
        end
    end
    B = []
    for i in 1:n
        push!(B, factors[1][i])
    end
    res = []
    for i in 1:n
        bk = B[i]
        pk = Pk(arguments, i-1)
        m = ArrC(pk, bk)
        res = ArrSum(m, res)
    end
    return res
end

function countP(P, x0)
    res=0.0;
    x = 1.0;
    for i in 1:length(P)
        res = res + P[i]*x
        x *= x0
    end
    return res
end

function check_Interpolation(arguments, values, P)
    res = []
    for i in 1:length(arguments)
        push!(res, countP(P, arguments[i]))
    end
    println("Points ", arguments)
    println("Polynomial ", P)
    println("Values ", values)
    println("empVal ", res)
end

P1 =Newton_Interpolation([-2, -1, 0, 1, 2, 3], [31, 5, 1, 1, 11, 61])
check_Interpolation([-2, -1, 0, 1, 2, 3], [31, 5, 1, 1, 11, 61], P1)
P2 = Newton_Interpolation([-2.0, -1.0, 0.0, 1.0, 2.0, 3.0], [31.0, 5.0, 1.0, 1.0, 11.0, 30.0])
check_Interpolation([-2.0, -1.0, 0.0, 1.0, 2.0, 3.0], [31.0, 5.0, 1.0, 1.0, 11.0, 30.0], P2)
