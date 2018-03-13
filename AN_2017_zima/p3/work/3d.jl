using PyPlot

using QuantEcon: meshgrid

println("loaded")

n = 50
x = linspace(-3, 3, n)
y = x

z = Array{Float64}(n, n)
f(x, y) = cos(x^2 + y^2) / (1 + x^2 + y^2)
for i in 1:n
    for j in 1:n
        z[j, i] = f(x[i], y[j])
    end
end

println(1)
xgrid, ygrid = meshgrid(x, y)
println(2)
surf(xgrid, ygrid, z', cmap=ColorMap("jet"), alpha=0.7)
println(3)
zlim(-0.5, 1.0)
println(4)
show()
