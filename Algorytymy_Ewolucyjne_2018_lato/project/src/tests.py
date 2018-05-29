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
from AI import Brain, Network
import Simulation as sim


M = np.random.randn(6, 2)
print M


track = Track(30)
track.draw()
plt.show()
brains = []
N = 200
for i in range(N):
    M = np.random.randn(6, 4)
    M1 = np.random.randn(4, 2)
    brains.append( Brain(Network([M, M1]) ) )


cars = [Car(Point(-4., 4.), np.pi/2, 0., brains[i]) for i in range(N)]
values = np.zeros(N)
for i in range(N):
    values[i]= cars[i].evaluate(track, 200)
    print i, values[i]

best_cars = []
I = np.argsort(values)[::-1]
for i in range(5):
    best_cars.append(Car(Point(-4., 4.), np.pi/2, 0., brains[I[i]]))

sim.simulation_movie(track, best_cars)
