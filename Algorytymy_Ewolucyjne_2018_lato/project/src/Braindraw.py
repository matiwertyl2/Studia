import numpy as np
import matplotlib.pyplot as plt

from Geometry import Point, Line
from AI import Network
import Const as const

def create_layer_points(point_distance, layer_distance, layer_size, layer_depth):
    layer_points = []
    p = Point(layer_depth*layer_distance, float(layer_size-1)/2 * point_distance)
    for j in range(layer_size):
        layer_points.append(p)
        p = p.translation(0, -point_distance)
    return layer_points

def create_layer_lines(points1, points2, weights):
    lines = []
    for i in range(weights.shape[0]):
        for j in range(weights.shape[1]):
            color = "red"
            if weights[i][j] < 0:
                color = "blue"
            lines.append( ( Line(points1[i], points2[j]), color, weights[i][j]) )
    return lines

def draw_points(points):
    for layer in points:
        for p in layer:
            plt.scatter(p.x, p.y, s=100, color="black", zorder=100)

def draw_lines(lines):
    for layer_lines in lines:
        for line in layer_lines:
            X, Y = line[0].plot_data()
            plt.plot(X, Y, zorder=abs(line[2]), color=line[1], linewidth=line[2])


def draw_network(network):

    point_distance = 5
    layer_distance = 10

    plt.axis('equal')
    plt.axis('off')

    points = []
    lines = []

    for i, layer in enumerate(network.layers):
        n = layer.shape[0]
        points.append( create_layer_points(point_distance, layer_distance, n, i) )

    points.append(create_layer_points(point_distance, layer_distance, network.layers[-1].shape[1], len(network.layers) ) )

    for i in range(1,len(points)):
        lines.append(create_layer_lines(points[i-1], points[i], network.layers[i-1]) )

    draw_points(points)
    draw_lines(lines)
    plt.show()





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
