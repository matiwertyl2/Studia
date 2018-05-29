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

def create_car(gene, layers_shape):
    layers = []
    beg = 0
    end = layers_shape[0][0] * layers_shape[0][1]
    for layer_shape in layers_shape:
        layers.append( gene[beg:end].reshape(layer_shape) )
        beg = end
        end += layer_shape[0]*layer_shape[1]

    initial_position = Point(-4., 4.)
    initial_angle = np.pi/2
    initial_speed = 0.
    brain = Brain(Network(layers))
    return Car(initial_position, initial_angle, initial_speed, brain)


def create_cars(genes, layers_shape):
    cars = []
    for gene in genes:
        cars.append(create_car(gene, layers_shape))
    return cars


genes = np.loadtxt('sim/population.txt')

cars = create_cars(genes[:1, :64], [(6, 8), (8, 2)])
track = Track(100)
plt.axis('equal')
track.draw()
plt.show()
sim.simulation_movie(track, cars, title='sim/after', frames_limit=200, show_demo=True, save=True)
