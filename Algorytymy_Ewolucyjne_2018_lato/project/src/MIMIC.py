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


def cond_entropy(i, j, P):
    ### P(xi=1 | xj = 1) * P(j=1) = P(i=1, j=1), sum of all options of values of xi, xj
    return -(P[i, 1, j, 1] * P[j, 1, j, 1] * np.log(P[i, 1, j, 1]) +
             P[i, 1, j, 0] * P[j, 0, j, 0] * np.log(P[i, 1, j, 0]) +
             P[i, 0, j, 1] * P[j, 1, j, 1] * np.log(P[i, 0, j, 1]) +
             P[i, 0, j, 0] * P[j, 0, j, 0] * np.log(P[i, 0, j, 0]) )

def entropy(i, P):
    return -(P[i, 1, i, 1] * np.log(P[i, 1, i, 1]) + P[i, 0, i, 0] * np.log(P[i, 0, i, 0]))


def probability_model_mimic(population, d, N):
    P = np.zeros((d, 2, d, 2))
    ### firstly compute normal probabilities
    for i in range(d):
        p = (population[:, i] == 1).sum().astype(float) / N
        if p > 1:
            print "SYF", p
        P[i, 1, i, 1] = p
        P[i, 0, i, 0] = 1. - p
    for i in range(d):
        for j in range(d):
            if i == j:
                continue
            population_1 = population[np.where(population[:, j] == 1)]
            population_0 = population[np.where(population[:, j] == 0)]
            p_1 = (population_1[:, i] == 1).sum().astype(float)
            if population_1.shape[0]> 0:
                p_1 /= population_1.shape[0]
            else:
                p_0 = 0.
            p_0 = (population_0[:, i] == 1).sum().astype(float)
            if population_0.shape[0]> 0:
                p_0 /= population_0.shape[0]
            else:
                p_0 = 0.
            if p_1 > 1 or p_0 > 1:
                print "SYF", p_1, p_0
            P[i, 1, j, 1] = p_1
            P[i, 0, j, 1] = 1 - p_1
            P[i, 1, j, 0] = p_0
            P[i, 0, j, 0] = 1 - p_0
    return P

def phenotype(gene, bit_length):
    d = len(gene)/bit_length
    pheno = np.zeros(d)
    for i in range(d):
        val = 1
        for j in range(1, bit_length-1):
            val *=2;
            if gene[bit_length * i + j]==1:
                val += 1
            if gene[bit_length * i] == 1:
                val *= -1
        pheno[i] = val
    return pheno

def evaluate_population_mimic(population, objective_function, N, tracks, layers_shape, frames_limit, bit_length):
    values = np.zeros(N)
    for i in range(N):
        values[i] = objective_function(phenotype(population[i, :], bit_length), tracks, layers_shape, frames_limit)
    return values

def find_first(H, d):
    res = 0
    val = np.inf
    for i in range(d):
        if H[i, i] < val:
            res = i
            val = H[i, i]
    return res

def permutation_of_dependancy(P, d):
    H = np.zeros((d, d))
    for i in range(d):
        H[i, i] = entropy(i, P)
    for i in range(d):
        for j in range(d):
            if i == j:
                continue
            H[i, j] = cond_entropy(i, j, P)

    permutation = np.zeros(d).astype(int)
    used = []
    first = find_first(H, d)
    used.append(first)
    permutation[0]=first
    for i in range(1, d):
        I = np.argsort(H[:, permutation[i-1]])
        for j in range(d):
            if (I[j] in used) == False:
                used.append(I[j])
                permutation[i]=I[j]
                break

    return permutation

def random_population(P, N, d):
    population = np.zeros((N, d))
    for i in range(N):
        for j in range(d):
            if np.random.random() < P[j]:
                population[i, j] = 1
    return population

def mimic_population(P, perm, N, d):
    population= np.zeros((N, d)).astype(int)
    for i in range(N):
        for j in range(d):
            pos = perm[j]
            if j == 0:
                population[i, pos] = np.random.choice([0, 1], p=[P[pos, 0, pos, 0], P[pos, 1, pos, 1]])
            else:
                pos_prev = perm[j-1]
                value_prev = population[i, pos_prev].astype(int)
                population[i, pos] = np.random.choice([0, 1], p=[P[pos, 0, pos_prev, value_prev], P[pos, 1, pos_prev, value_prev]] )
    return population

def MIMIC(objective_function, tracks, chromosome_length, population_size=50,
          number_of_offsprings=50, iters=10, layers_shape=[], frames_limit=100, bit_length=8):

    population = random_population(np.ones(chromosome_length*bit_length) * 0.5, population_size, chromosome_length*bit_length)
    objective_values = evaluate_population_mimic(population, objective_function,
            population_size, tracks, layers_shape, frames_limit, bit_length)

    results = np.zeros(iters)

    for t in range(iters):
        if t % 10 == 0:
            print t, objective_values[0]
        P = probability_model_mimic(population, chromosome_length*bit_length, population_size)
        perm = permutation_of_dependancy(P, chromosome_length*bit_length)
        children_population = mimic_population(P, perm, number_of_offsprings, chromosome_length*bit_length)
        children_objective_values = evaluate_population_mimic(children_population, objective_function, number_of_offsprings,
                                    tracks, layers_shape, frames_limit, bit_length)

        objective_values = np.hstack((objective_values, children_objective_values))
        population = np.vstack((population, children_population))
        I = np.argsort(objective_values)[::-1]
        objective_values = objective_values[I[:population_size]]
        population = population[I[:population_size], :]

        results[t] = objective_values[0]

    return results

################################################################################

tracks = []
for t in range(2):
    track = Track(50)
    plt.axis('equal')
    track.draw()
    plt.show()
    tracks.append(track)

MIMIC(util.objective_function, tracks, 64, population_size=50,
          number_of_offsprings=50, iters=10, layers_shape=[(6, 8), (8, 2)],
          frames_limit=30, bit_length=5)
