import numpy as np
import matplotlib.pyplot as plt
import random
from matplotlib.patches import Ellipse
import time
import timeit
import matplotlib.animation as animation

from Geometry import Polyline, Line, Point
from Car import Car
from Track import Track
from AI import Brain

def simulation_movie(track, cars, title='simulation', frames_limit=100, show_demo=False, save=True):

    N = len(cars)

    angles = []
    positions = []

    for car in cars:
        f, p, a = car.drive(track, frames_limit)
        print "FITNESS ", f
        angles.append(a)
        positions.append(p)

    fig = plt.figure()
    plt.axis('equal')
    plt.axis('off')

    lines = [plt.plot([], [], linewidth = 2)[0] for _ in range(N)]
    sensors = [plt.plot([], [], color="black", linewidth=0.5)[0] for _  in range(N*5)]

    def init():
        track.draw()
        for line in lines:
            line.set_data([], [])
        for sensor in sensors:
            sensor.set_data([], [])
        return lines + sensors

    def animate(i):
        #print "frame ", i
        for j,line in enumerate(lines):
            cars[j].set_position(positions[j][i], angles[j][i])
            s = cars[j].get_sensors(track)
            for k in range(5):
                sx, sy = s[k].plot_data()
                sensors[5*j+k].set_data(sx, sy)
            X, Y = cars[j].get_polyline().plot_data()
            line.set_data(X, Y)
        return sensors + lines

    Writer = animation.writers['ffmpeg']
    writer = Writer(fps=10, metadata=dict(artist='Me'), bitrate=1800)

    anim = animation.FuncAnimation(fig, animate, init_func=init,
                                   frames=frames_limit, interval=50, blit=False, repeat=False)
    if save:
        anim.save(title +'.mp4', writer=writer)

    if show_demo:
        plt.show()
    plt.close()
