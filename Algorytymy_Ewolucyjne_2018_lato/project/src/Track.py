import numpy as np
import matplotlib.pyplot as plt
import random
from matplotlib.patches import Ellipse
import time
import timeit
import matplotlib.animation as animation

import Geometry as Geo
from Geometry import Polyline, Line, Point
import Const as const

def random_path(n, sigma, l):
    lines = [Line(Point(0., 0.), Point(0., l))]
    a = np.pi/2
    xprv = 0.
    yprv = l
    for i in range(n):
        turn = np.random.normal(0, sigma)
        if turn < 0:
            turn = max(turn, -sigma*1.5)
        else:
            turn = min(turn, sigma*1.5)
        a += turn
        l = np.random.random() * l + 2
        x = xprv + l*np.cos(a)
        y = yprv + l*np.sin(a)
        lines.append( Line(Point(xprv, yprv), Point(x, y) ) )
        xprv = x
        yprv = y
    return Polyline(lines)

def circular(n, circ_dir):
    lines = [Line(Point(0., 0.), Point(0., 10.))]
    a = np.pi/2
    xprv = 0.
    yprv = 10.0
    sgn = -1 ### turn right
    if circ_dir == 'left':
        sgn = 1
    print "sgn ", sgn
    for i in range(n):
        a += 0.2 * sgn
        l = 2*np.sqrt(i+10);
        x = xprv + l*np.cos(a)
        y = yprv + l*np.sin(a)
        lines.append( Line(Point(xprv, yprv), Point(x, y) ) )
        xprv = x
        yprv = y
    return Polyline(lines)

def generate_path(n, width, curvature, path_type='random', circ_dir="right"):
    while True:
        p = None
        if path_type == 'random':
            p = random_path(n, curvature, 10)
        elif path_type == 'circular':
            p = circular(n, circ_dir)
        pt = p.translation(width)
        if p.find_intersections() or Geo.find_intersections(p, pt):
            continue
        else:
            pt.remove_intersections()
            return p, pt


class Track:

    def __init__(self, n, width=const.learn_track_width, curvature=0.5, path_type='random', circ_dir='right'):

        self.left, self.right = generate_path(n, width, curvature, path_type=path_type, circ_dir=circ_dir)
        self.finish = Polyline( [ Line (self.left.lines[-1].b, self.right.lines[-1].b)])
        self.start = Polyline( [Line(self.left.lines[0].a, self.right.lines[0].a)])

    def draw(self):
        x, y = self.right.plot_data()
        plt.plot(x, y, color="black")
        xt, yt = self.left.plot_data()
        plt.plot(xt, yt, color="black")
