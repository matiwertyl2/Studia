plotdx = 100
plotMax = 10000

function squareSum(T, n)
    return T(1)/T(n)/T(n)
end

function linearSum(T, n)
    return T(1)/T(n)
end

function sum(T, arr, sumElement)
    s = sumElement(T, arr[1])
    results = []
    for i in 2:length(arr)
        k = T(arr[i])
        s += sumElement(T, k)
        if  i % plotdx == 0
            push!(results, T(s))
        end
    end
    return results
end

function sumWithCorrection(T, arr, sumElement)
    s = sumElement(T, arr[1])
    c = T(0)
    results=[]
    for i in 2:length(arr)
        k = T(arr[i])
        y = T(c + sumElement(T, k))
        t = T(s + y)
        c = (s - t) + y
        s = t
        if i % plotdx == 0
            push!(results, T(s))
        end
    end
    return results
end

function sumMistakes(T, arr, sumAlgorithm, sumElement)
    setprecision(BigFloat, 2048)
    good = sum(BigFloat, arr, sumElement)
    checked = sumAlgorithm(T, arr, sumElement)
    mistakes=[]
    for i in 1:length(good)
        push!(mistakes, Float64(abs(good[i]-checked[i])/good[i]))
    end
    return mistakes
end

function empiricComplexity(T, arr, exp)
    results = []
    t = precision(T)
    for i in 1:length(arr)
        ratio = BigFloat(arr[i])/(BigFloat(i * plotdx) * BigFloat(2.0 ^ (-exp*t)))
        push!(results, Float64(ratio))
    end
    return results
end

function getPlotX()
    res = [1:(plotMax/plotdx);] .* plotdx
    return res
end

function endResults(a, b, c)
    println("Końcowy błąd względny")
    println("Zwykłe sumowanie: ", a)
    println("Sumowanie z poprawkami: ", b)
    println("Sumowanie w odwrotnej kolejności: ", c)
end

function initPlot(t, x, y)
    title(t)
    ylabel(y)
    xlabel(x)
end
