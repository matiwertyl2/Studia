function Steffensen(f)
    setprecision(BigFloat,4096)
    c = BigFloat(1)
    results =[c]
    for x in [1:10;]
        c = c - (f(c)*f(c))/(f(c + f(c))- f(c))
        push!(results, c)
    end
    println("Xo = ", Float64(c))
    return results
end

function checkQuadraticLim(results)
    setprecision(BigFloat, 4096)
    good = results[end]
    for i in 2:(length(results)-1)
         an = results[i] - good
         an_1 = results[i-1] -good
         println("Iter $i ", Float64(an / (an_1 * an_1)), " X$i = ", Float64(results[i]))
    end
end


function f(x)
    return e^(-x)- sin(x)
end

checkQuadraticLim(Steffensen(f))
