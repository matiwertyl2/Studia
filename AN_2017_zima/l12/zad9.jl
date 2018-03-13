using PyPlot
using PyCall

# y' = z = f
# y'' = dz/dx = g(x, y, z)
function RungeKutta(f0, fp0, x0, xend, f, g, N)
    res = [[x0], [f0]]
    h = (xend-x0)/N
    x = x0
    y = f0
    z = fp0
    for i=1:N
        k0 = h * f(x, y, z)
        l0 = h * g(x, y, z)
        k1 = h * f(x + h/2, y + k0/2, z + l0/2)
        l1 = h * g(x + h/2, y + k0/2, z + l0/2)
        k2 = h * f(x + h/2, y + k1/2, z + l1/2)
        l2 = h * g(x + h/2, y + k1/2, z + l1/2)
        k3 = h * f(x + h,   y + k2,   z + l2  )
        l3 = h * g(x + h,   y + k2,   z + l2  )
        y = y + (k0 + 2*k1 + 2*k2 + k3)/6
        z = z + (l0 + 2*l1 + 2*l2 + l3)/6
        x += h
        push!(res[1], x)
        push!(res[2], y)
    end
    res
end

L = 10
G = pi^2
f0 = pi/3
fp0 = 0

function f(x, y, z)
    return z
end

function g(x, y, z)
    return - G/L *sin(y)
end

@pyimport matplotlib as mat_pl
@pyimport matplotlib.animation as anim

data = RungeKutta(f0, fp0, 0, 40, f, g, 1000)

fig = figure()
ax = axes(xlim=(-15, 15), ylim=(-15, 15))

line = ax[:plot]([], [], lw=4, alpha=0.2)[1]
ball = ax[:plot]([],[], "ro", markersize=10)[1]
angle_text = ax[:text](-10,10 , "")
time_text = ax[:text](-10, 8, "")


function init()
    line[:set_data]([], [])
    ball[:set_data]([], [])
    angle_text[:set_text]("")
    time_text[:set_text]("")
end

function animate(i)
    a = data[2][i]
    ball_x = L * sin(a)
    ball_y = L * cos(a)
    line[:set_data]([0,ball_x], [0,-ball_y])
    ball[:set_data]( [ball_x], [-ball_y] )
    d = sqrt(ball_x^2 + ball_y^2)

    angle_text[:set_text](@sprintf("Kąt : %f",a*180/pi))
    time_text[:set_text](@sprintf("t : %.2f s", i/25))
end

myanim = anim.FuncAnimation(fig, animate, 1:1000, init_func=init, interval=1000/25)
show()

#fig, ax = subplots()
#ax[:plot](data[1], data[2], "-", color="red", label="Wahadlo", linewidth=1, alpha=1.0)
#show()
