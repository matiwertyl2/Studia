using PyPlot;  fps = 25;
using PyCall;

L  = 2.0;   # długość sprężyny (stan swobodny)
g  = 9.81;  # przyspieszenie ziemskie

m = 5.0;    # masa kulki

ΔL = 4.0;   # przyrost długości sprężyny po zawieszeniu kulki
k  = m*g/ΔL;# współczynnik sprężystości sprężyny

r = 0.3;    # współczynnik oporu wiatru

#### Zagadnienie początkowe
y_0 = [ L+ΔL+3, 0.0 ]; # umieszczamy kulkę w pozycji y_0[1] oraz nadajemy jej prędkość y_0[2]

# m*y'' + k*y = 0
# y1 = y
# y2 = y'

f(x,y::Vector{Float64}) = [ y[2] , -k*(y[1]-L-ΔL) - r*y[2] ]

function method_step_Euler(x, y::Vector{Float64}, h, f::Function)
    K1 = f(x, y)
	#K2 = f(x+h, y+h*K1)
    return y + h*K1;
end

function method_step_RK(x, y::Vector{Float64}, h, f::Function)
    K1 = f(x, y)
    K2 = f(x+h/2  , y+h*K1/2)
    K3 = f(x+h/2  , y+h*K2/2)
    K4 = f(x+h    , y+h*K3  )
    return y + h/6*(K1+2*(K2+K3)+K4);
end
method_step = method_step_RK;

a, b = 0.0,  23.0   #  b-a = czas (w sekundach)
x_0 = 0.0
N = convert(Int, (b-a)*fps );
x = linspace(a,b,N);
global y = zeros(2,N)
y[:,1] = y_0


for i=1:N-1
    y[:,i+1] = method_step(x[i],y[:,i],x[i+1]-x[i],f);
    # @printf("y(%6.2f) = %19.16f\n", x[i+1], y[1,i+1]);
end

y[1,:] = - y[1,:];

# plot(y[1,:])



@pyimport matplotlib as mat_pl
# mat_pl.rc("font", family="Arial")

fig = figure()
ax = axes(xlim=(-1, 1), ylim=(-1.6*(y_0[1]), 0.5))

plot( 0.7, -(L+ΔL), "ko", markersize=5)
text(-0.9, -1.5, "Analiza numeryczna\nZawieszona kulka na sprężynie (z oporem powietrza)")
text(-0.9, -4.5, "Masa kulki 4kg\nDługość sprężyny 2m\nDługość sprężyny po zawieszeniu kulki 6m\nZagadnienie początkowe [ 9m, 0m/s ]")
text(0.6, -13, "Rafał Nowak")
line = ax[:plot]([], [], lw=4, alpha=0.2)[1]
vel  = ax[:plot]([], [], lw=1)[1]
ball = ax[:plot]([],[], "ro", markersize=10)[1]
text(0.2, -0.1, "Czas ")
time_text = ax[:text](0.4, -0.1, "")
text(0.6, -0.1, "s")

# initialization function: plot the background of each frame

function init()
    # global line, time_text
    line[:set_data]([], [])
    vel[:set_data]([], [])
    time_text[:set_text]("");
    ball[:set_data]([], [])
    return (line,time_text)
end
# animation function.  This is called sequentially
function animate(i)
    # global line, time_text, y
    line[:set_data]([0.7,0.7], [0,y[1,i]])
    vel[:set_data]( [0.7,0.7], [y[1,i],y[1,i]-y[2,i]])
    time_text[:set_text](@sprintf("%.2f",i/fps));
    ball[:set_data]( [0.7], [y[1,i]] )
    return (line,time_text)
end

@pyimport matplotlib.animation as anim

myanim = anim.FuncAnimation(fig, animate, 1:N, init_func=init, interval=1000.0/fps)
show()
#myanim[:save]("spring_damping.mp4", extra_args=["-vcodec", "libx264", "-pix_fmt", "yuv420p"],fps=fps)
