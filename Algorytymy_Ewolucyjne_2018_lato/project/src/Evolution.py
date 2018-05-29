import numpy as np
import matplotlib.pyplot as plt
import random
from matplotlib.patches import Ellipse
import time
import timeit
import matplotlib.animation as animation
import multiprocessing

from Geometry import Polyline, Line, Point
from Car import Car
from Track import Track
from AI import Brain, Network
import Simulation as sim
import EvolUtils as util
import Const as const

################################################################################

def mutation(gene, tau, tau0):
    mutated = gene.copy()
    d = len(gene)/2
    sigma_mutation = np.exp(np.random.normal(0, tau, d)  + np.random.normal(0, tau0) )
    mutated[d:] = mutated[d:] * sigma_mutation
    chromosome_mutation = np.random.normal(0, mutated[d:])
    mutated[:d] = mutated[:d] + chromosome_mutation
    return mutated

def initial_population(population_size, sigma, d, rmin, rmax):
    population = np.zeros((population_size, 2*d))
    population[:, :d] = np.random.uniform(rmin, rmax, (population_size, d))
    population[:, d:] = sigma * np.ones( (population_size, d)).astype(float)
    return population

def evaluate_population(population, population_size, d, objective_function, tracks, layers_shape, frames_limit):
    arguments = []
    for i in range(population_size):
        arguments.append((population[i, :d], tracks, layers_shape, frames_limit))
    pool = multiprocessing.Pool()
    res = pool.map(util.objective_function_thread, arguments)
    pool.close()
    pool.join()
    return np.array(res)

def parent_selection(objective_values, number_of_offsprings):
    fitness_values = objective_values - objective_values.min()
    if fitness_values.sum() > 0:
        fitness_values = fitness_values / fitness_values.sum()
    else:
        fitness_values.fill(1./len(fitness_values))
    return np.random.choice(len(fitness_values), (number_of_offsprings, 2), True, fitness_values).astype(np.int64)


def ES1(objective_function, tracks, population_size=10, number_of_offsprings=10, d=32, rmin=-1, rmax=1,
        sigma=1, tau=1., tau0=1., iters=10, layers_shape=[], frames_limit=100):

    population = initial_population(population_size, sigma, d, rmin, rmax)
    objective_values = evaluate_population(population, population_size, d, objective_function, tracks, layers_shape, frames_limit)

    results = np.zeros((iters))
    best_sigmas = np.zeros((d, iters))

    for t in range(iters):

        indices = parent_selection(objective_values, number_of_offsprings)

        children_population = np.zeros((number_of_offsprings, 2*d))
        for i in range(number_of_offsprings):
            children_population[i] = mutation(population[indices[i], :].mean(axis=0), tau, tau0)
        children_objective_values = evaluate_population(children_population, number_of_offsprings, d, objective_function,
                                                        tracks, layers_shape, frames_limit)

        objective_values = np.hstack([objective_values, children_objective_values])
        population = np.vstack([population, children_population])
        I = np.argsort(objective_values)[::-1]
        population = population[ I[:population_size] , :]
        objective_values = objective_values[I[:population_size]]

        ### recording statistics
        results[t] = objective_values.max()
        pos_best = objective_values.argmax()
        for i in range(d):
            best_sigmas[i][t] = population[pos_best][d+i]


        print t, results[t]
        if t % 5 == 0:
            np.savetxt('../images/sim/population.txt', population)
            for i in range(len(tracks)):
                title = "../images/sim/track_" + str(i+1) + "_gen_" + str(t)
                sim.simulation_movie(tracks[i], util.create_cars(population[:5, :d], layers_shape), title=title, frames_limit=frames_limit, show_demo=False, save=True)

    return results, best_sigmas, population

################################################################################
tracks = []
width= const.learn_track_width
curvature = 0.5
for t in range(2):
    track = Track(10, width=width, curvature=curvature, path_type='random', circ_dir='left')
    plt.axis('equal')
    track.draw()
    plt.show()
    tracks.append(track)

results, sigmas, population = ES1(util.objective_function, tracks, population_size=30,
                                  number_of_offsprings=30, d=const.chromosome_length,
                                  rmin=-1, rmax=1, sigma=1, tau=1./np.sqrt(64.),
                                  tau0=1./np.sqrt(2*np.sqrt(64.)), iters=81,
                                  layers_shape=const.network_layers_shape,
                                  frames_limit=10)

np.savetxt('../images/sim/population.txt', population)
np.savetxt('../images/sim/results.txt', results)
np.savetxt('../images/sim/sigmas.txt', sigmas)
