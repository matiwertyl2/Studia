import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation


from Geometry import Line, Point, Polyline
import Geometry as Geo


class Node:

    def __init__(self, position=Point(0, 0), parent=0, ID=0):
        self.id = ID
        self.sons = []
        self.p = position
        self.parent = parent
        self.angle = np.pi/2

    def traverse(self, lengths, angles):
        lines = []
        end_points = []
        self.angle = self.parent.angle + angles[0]
        self.p = self.parent.p.translation(lengths[0], 0).rotation(self.angle, self.parent.p)
        lines.append(Line(self.parent.p, self.p))
        for son in self.sons:
            lengths, angles, l, e= son.traverse(lengths[1:], angles[1:])
            lines += l
            end_points += e
        if len(self.sons) == 0:
            end_points.append(self.p)
        return lengths, angles, lines, end_points


class TreeArm:

    def __init__(self, root):
        self.root = root

    def traverse(self, lengths, angles):
        lines = []
        end_points = []
        for son in self.root.sons:
            lengths, angles, l, e = son.traverse(lengths, angles)
            lines += l
            end_points += e
        return lines, end_points

    def draw(self, lengths, angles, end_points):
        lines, end_points= self.traverse(lengths, angles)
        for line in lines:
            x, y = line.plot_data()
            plt.plot(x, y, color='green')
        for e in end_points:
            plt.scatter(e.x, e.y, s=100, color='black')
        plt.axis('equal')
        plt.axis('off')
        plt.show()


def random_path(n, branch_nr):
    nodes = []
    root = Node()
    nodes.append(root)
    for i in range(n):
        node = Node(parent=nodes[-1], ID=branch_nr *10000 +len(nodes) )
        nodes[-1].sons.append(node)
        nodes.append(node)
    return root, nodes


def random_tree(n, branches=2):
    d = np.random.randint(3, n)
    root, main_path = random_path(d, 1)
    n -= d
    for i in range(1, branches):
        d = np.random.randint(1, n)
        if i == branches - 1:
            d = n-1
        n -= (d + 1)
        r, path = random_path(d, i+1)
        merge = np.random.randint(2, len(main_path)/2)
        r.parent = main_path[merge]
        main_path[merge].sons.append(r)
    return TreeArm(root)

def validate(arm):
    if arm.find_intersections():
        return False
    for line in arm.lines:
        if line.a.y < 0 or line.b.y < 0:
            return False
    return True


def random_good_tree(n, angle_ranges, branches=2):
    t = random_tree(n, branches)
    while True:
        lengths = np.random.random(n) * 10
        angles = np.random.uniform(low=-np.pi/4, high=np.pi/4, size=n)
        if good_angles(angles, angle_ranges):
            lines, end_points = t.traverse(lengths, angles)
            if validate(Polyline(lines)) == True:
                return t, end_points, lengths, angles

def random_good_gene(n, tree, lengths, angle_ranges):
    while True:
        angles = np.random.uniform(low=-np.pi/4, high=np.pi/4, size=n)
        if good_angles(angles, angle_ranges):
            lines, end_points = tree.traverse(lengths, angles)
            if validate(Polyline(lines)) == True:
                return angles

def good_angles(gene, ranges):
    for i in range(len(gene)):
        if gene[i] < ranges[i, 0] or gene[i] > ranges[i, 1]:
            return False
    return True
################################################################################

def init_tree_sim(D):
    return [plt.plot([], [], linewidth=3)[0] for _ in range(D)]

def flatten(arr):
    res = []
    for a in arr:
        res += a
    return res

def get_fig_limits(points):
    Lx =0
    Ly=0
    for point in points:
        Lx = max(Lx, abs(point.x))
        Ly = max(Ly, abs(point.y))
    return Lx *1.5, Ly *1.5

def simulation(generations, tree, lengths, final_points, angle_ranges):
    frames_limit = len(generations)
    N = generations[0].shape[0]
    D = generations[0].shape[1]/2

    fig = plt.figure(figsize=(10, 5))
    Lx, Ly = get_fig_limits(final_points)
    plt.axis('off')
    plt.xlim(-Lx, Lx)
    plt.ylim(0, Ly)

    arms =  [init_tree_sim(D) for _  in range(N)]

    def init():
        for final_point in final_points:
            plt.scatter(final_point.x, final_point.y, s=100, color='black')
        plt.plot([-Lx, Lx], [0, 0], color='black')
        for arm in arms:
            for i in range(D):
                arm[i].set_data([], [])
        return flatten(arms)

    def animate(i):
        print i
        population = generations[i]
        d = population.shape[1] / 2
        for j, arm in enumerate(arms):
            lines, e = tree.traverse(lengths,population[j, :d])
            for k in range(D):
                x, y = lines[k].plot_data()
                arm[k].set_data(x, y)
            color = 'green'
            if good_angles(population[j, :d], angle_ranges) == False or validate(Polyline(lines)) == False:
                color = 'red'
            for k in range(D):
                arm[k].set_color(color)
                if (j > 0):
                    arm[k].set_alpha(0.2)
                    arm[k].set_linewidth(0.5)
        return flatten(arms)

    Writer = animation.writers['ffmpeg']
    writer = Writer(fps=3, metadata=dict(artist='Me'), bitrate=1800)

    anim = animation.FuncAnimation(fig, animate, init_func=init,
                                       frames=frames_limit, interval=100, blit=False, repeat=False)
    anim.save("tree_kinematics" +'.mp4', writer=writer)
    plt.close()

################################################################################

def random_population(population_size, tree, lengths, sigma, angle_ranges):
    d = len(lengths)
    population=np.zeros((population_size, 2*d))
    for i in range(population_size):
        print i
        population[i, :d] = random_good_gene(d, tree, lengths, angle_ranges)
    population[:, d:] = sigma
    return population

def objective_function(gene, tree, lengths, final_points, angle_ranges, generation, good_ratio):
    lines, end_points = tree.traverse(lengths, gene)
    coeff = 1.
    if validate(Polyline(lines)) == False:
        coeff += 0.5 * np.sqrt(generation)
    if good_angles(gene, angle_ranges) == False:
        coeff += 0.2 * generation * generation
    res = 0
    for i in range(len(end_points)):
        res += final_points[i].distance(end_points[i])
    return -res * coeff

def angle_normalize(gene):
    for i in range(len(gene)):
        while gene[i] < 2*np.pi:
            gene[i] += 2*np.pi
        while gene[i] > 2*np.pi:
            gene[i] -= 2*np.pi

        if gene[i] > np.pi:
            gene[i] = -np.pi + (gene[i] - np.pi)
        elif gene[i] < -np.pi:
            gene[i] = np.pi + (gene[i] + np.pi)
    return gene

def mutation(gene, tau, tau0):
    mutated = gene.copy()
    d = len(gene)/2
    sigma_mutation = np.exp(np.random.normal(0, tau, d)  + np.random.normal(0, tau0) )
    mutated[d:] = mutated[d:] * sigma_mutation
    for i in range(d, 2*d):
        mutated[i]= max(0.01, mutated[i])
    chromosome_mutation = np.random.normal(0, mutated[d:])
    mutated[:d] = mutated[:d] + chromosome_mutation
    mutated[:d] = angle_normalize(mutated[:d])
    return mutated

def evaluate_population(population, population_size, d, tree, final_points, lengths, angle_ranges, generation):
    res = np.zeros(population_size)
    good_ratio = 1.
    for gene in population:
        if good_angles(gene[:d], angle_ranges):
            good_ratio += 1
    good_ratio /= population_size
    print "GOOD RATIO ", good_ratio
    for i in range(population_size):
        res[i]= objective_function(population[i, :d], tree, lengths, final_points, angle_ranges, generation, good_ratio)
    return res

def tournament(objective_values, indices):
    return np.argmax(objective_values[indices])

def tournament_selection(fitness_values, number_of_offsprings, mixture_number):
    parents = np.zeros((number_of_offsprings, mixture_number)).astype(int)
    for i in range(number_of_offsprings):
        for j in range(mixture_number):
            parents[i, j] = tournament(fitness_values, np.random.choice(len(fitness_values), 10) )
    return parents

def parent_selection(objective_values, number_of_offsprings):
    fitness_values = (objective_values - objective_values.min())
    if fitness_values.sum() > 0:
        fitness_values = fitness_values / fitness_values.sum()
    else:
        fitness_values.fill(1./len(fitness_values))

    mixture_number = 2
    if np.random.random() < 0.7:
        return np.random.choice(len(fitness_values), (number_of_offsprings, mixture_number), True, fitness_values).astype(np.int64)
    return tournament_selection(fitness_values, number_of_offsprings, mixture_number)

def get_best_good(population, objective_values, d, angle_ranges):
    res = -1000000.
    for i in range(len(objective_values)):
        if good_angles(population[i, :d], angle_ranges):
            res = max(res, objective_values[i])
    return res

def ES(population_size, number_of_offsprings, d, sigma, iters, tree, final_points, lengths, angle_ranges):

    tau = 1. / np.sqrt(2*d)
    tau0 = 1./ np.sqrt(2*np.sqrt(d))

    population = random_population(population_size, tree, lengths, sigma, angle_ranges)
    objective_values = evaluate_population(population, population_size, d, tree, final_points, lengths, angle_ranges, 0)

    results = np.zeros((iters+1))
    results[0] = get_best_good(population, objective_values, d, angle_ranges)
    print 0, results[0], objective_values.std()
    best_sigmas = np.zeros((d, iters+1))
    best_sigmas[:, 0] = population[0, d:].T
    generations = [population]

    for t in range(1, iters+1):

        indices = parent_selection(objective_values, number_of_offsprings)
        objective_values = evaluate_population(population, population_size, d, tree, final_points, lengths, angle_ranges, t)
        children_population = np.zeros((number_of_offsprings, 2*d))
        for i in range(number_of_offsprings):
            children_population[i] = mutation(population[indices[i], :].mean(axis=0), tau, tau0)
        children_objective_values = evaluate_population(children_population, number_of_offsprings, d, tree, final_points, lengths, angle_ranges, t)

        objective_values = np.hstack([objective_values, children_objective_values])
        population = np.vstack([population, children_population])
        I = np.argsort(objective_values)[::-1]
        population = population[ I[:population_size] , :]
        objective_values = objective_values[I[:population_size]]

        ### recording statistics
        if t % 1 == 0:
            generations.append(population.copy())
        results[t] = max(results[t-1], get_best_good(population, objective_values, d, angle_ranges) )
        pos_best = objective_values.argmax()
        for i in range(d):
            best_sigmas[i][t] = population[pos_best][d+i]

        if t % 1 == 0:
            print t, results[t], objective_values.std()

    return results, best_sigmas, generations

################################################################################


population_size = 200
number_of_offsprings = 350
d = 50
branches= 5
iters = 150
sigma = 0.2

angle_ranges= np.zeros((d, 2))
angle_ranges[:, 0] = np.random.uniform(low=-np.pi/2, high=-np.pi/6, size=(1, d))
angle_ranges[:, 1] =  np.random.uniform(low=np.pi/6, high=np.pi/2, size=(1, d))

tree, end_points, lengths, angles = random_good_tree(d, angle_ranges, branches=branches)


tree.draw(lengths, angles, end_points)

results, sigmas, generations = ES(population_size, number_of_offsprings, d, sigma, iters, tree,
                                end_points, lengths, angle_ranges)
#plt.plot(results)
for sigma in sigmas:
    plt.plot(sigma)
plt.savefig('sigmas')
plt.close()
plt.plot(results)
plt.savefig('results')
simulation(generations, tree, lengths, end_points, angle_ranges)
