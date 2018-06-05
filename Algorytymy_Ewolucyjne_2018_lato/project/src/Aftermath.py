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
import EvolUtils as util
from Track import create_benchmarks
import Const as const
from Braindraw import draw_network


genes = np.loadtxt('../images/sim/population.txt')

gene = np.loadtxt('../images/sim/population.txt')[0]

layers_shape = const.network_layers_shape
layers = []
beg = 0
end = 0
for layer_shape in layers_shape:
    beg = end
    end += layer_shape[0]*layer_shape[1]
    layers.append( gene[beg:end].reshape(layer_shape) )


network = Network(layers)
draw_network(network)

cars = util.create_cars(genes[:5, :genes.shape[1]/2 ], const.network_layers_shape)
track = Track(10)
sim.simulation_movie(track, cars, title='sim/after', frames_limit=30, show_demo=True, save=False)


tracks = create_benchmarks()
for track in tracks:
    plt.axis('equal')
    track[0].draw()
    plt.show()
    cars = util.create_cars(genes[:1, :genes.shape[1]/2 ], const.network_layers_shape)
    #sim.simulation_movie(track[0], cars, title='sim/after', frames_limit=track[1], show_demo=True, save=False)
