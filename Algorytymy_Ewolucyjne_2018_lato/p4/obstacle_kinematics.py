import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation


from Geometry import Line, Point, Polyline
import Geometry as Geo

def rectangle(l):
    p = Point(np.random.uniform(low=-l/2, high=l/2), np.random.uniform(low=0, high=l/2))
    w = np.random.uniform(low=0, high=l/3)
    h = np.random.uniform(low=0, high=l/6)
    a = np.random.uniform(low=-np.pi/4, high=np.pi/4)
    p1 = p.translation(w, h).rotation(a, p)
    p2 = p.translation(w, -h).rotation(a, p)
    p3 = p.translation(-w, -h).rotation(a, p)
    p4 = p.translation(-w, h).rotation(a, p)
    return Polyline([Line(p1, p2), Line(p2, p3), Line(p3, p4), Line(p4, p1)])

def point_in_rectangle(p, rec):
    if p.x <= rec.lines[0].a.x and p.x >= rec.lines[2].a.x and p.y <= rec.lines[0].a.y and p.y >= rec.lines[2].a.y:
        return True
    return False

def middle(rec):
    x = 0.5*(rec.lines[0].a.x + rec.lines[2].a.x)
    y = 0.5*(rec.lines[0].a.y + rec.lines[2].a.y)
    return Point(x, y)

def good_rectangle(rec, obstacles, arm):
    if Geo.find_intersections(rec, arm):
        return False
    p = middle(rec)
    for o in obstacles:
        if Geo.find_intersections(rec, o):
            return False
        if point_in_rectangle(p, o):
            return False

    #if point_in_rectangle(arm.lines[-1].b, rec):
    #    return False
    return True

def non_intersecting_arm(arm, obstacles):
    for o in obstacles:
        if Geo.find_intersections(arm, o):
            return False
    return True

def create_obstacles(number_of_obstacles, l, arm):
    obstacles = []
    for i in range(number_of_obstacles):
        while True:
            rec = rectangle(l)
            if good_rectangle(rec, obstacles, arm):
                obstacles.append(rec)
                break
    return obstacles



def point_in_obstacles(p, obstacles):
    for o in obstacles:
        if point_in_rectangle(p, o):
            return True
    return False

def create_end_point(obstacles, l):
    R = np.random.uniform(low=l/2, high=l)
    A = np.random.uniform(low=0, high=np.pi)
    while True:
        P = Point(R, 0).rotation(A, Point(0, 0))
        if point_in_obstacles(P, obstacles)== False:
            return P

def create_arm(angles, lengths):
    alpha = np.pi/2
    A = Point(0, 0)
    lines = []
    for i in range(len(angles)):
         B = A.translation(lengths[i], 0)
         alpha += angles[i]
         B = B.rotation(alpha, A)
         lines.append(Line(A, B))
         A = B
    return Polyline(lines)

def validate(arm):
    if arm.find_intersections():
        return False
    for line in arm.lines:
        if line.a.y < 0 or line.b.y < 0:
            return False
    return True

def random_arm(lengths, angle_ranges, obstacles):
    probability = np.random.random()
    while True:
        angles = np.zeros(len(lengths))
        for i in range(len(lengths)):
            angles[i] = np.random.uniform(low=angle_ranges[i, 0], high=angle_ranges[i, 1])
        arm = create_arm(angles, lengths)
        if validate(arm):
            if probability < 0.8:
                return angles
            if non_intersecting_arm(arm, obstacles):
                return angles

def good_angles(gene, ranges):
    for i in range(len(gene)):
        if gene[i] < ranges[i, 0] or gene[i] > ranges[i, 1]:
            return False
    return True

def simulation(generations, lengths, final_point, angle_ranges, obstacles):
    frames_limit = len(generations)
    N = generations[0].shape[0]

    fig = plt.figure(figsize=(10, 5))
    plt.axis('off')
    plt.xlim(-lengths.sum(), lengths.sum())
    plt.ylim(0, lengths.sum())

    arms =  [plt.plot([], [], linewidth=1., alpha=0.5)[0] for _  in range(N)]
    arms[0].set_alpha(1)
    arms[0].set_linewidth(3)
    arms[0].set_zorder(10)

    def init():
        plt.scatter(final_point.x, final_point.y, s=100, color='red')
        plt.plot([-lengths.sum(), lengths.sum()], [0, 0], color='black')
        for obstacle in obstacles:
            x, y = obstacle.plot_data()
            plt.plot(x, y, color='black', linewidth=2)
        for arm in arms:
            arm.set_data([], [])
        return arms

    def animate(i):
        print i
        population = generations[i]
        d = population.shape[1] / 2
        for j, arm in enumerate(arms):
            a = create_arm(population[j, :d], lengths)
            x, y = a.plot_data()
            arm.set_data(x, y)
            color = 'green'
            if good_angles(population[j, :d], angle_ranges) == False or validate(a) == False or non_intersecting_arm(a, obstacles)==False:
                color = 'red'
            arm.set_color(color)
            if (j > 0):
                arm.set_alpha(0.2)
        return arms



    Writer = animation.writers['ffmpeg']
    writer = Writer(fps=3, metadata=dict(artist='Me'), bitrate=1800)

    anim = animation.FuncAnimation(fig, animate, init_func=init,
                                   frames=frames_limit, interval=100, blit=False, repeat=False)
    anim.save("obstacle_kinematics" +'.mp4', writer=writer)
    plt.close()

################################################################################

def objective_function(gene, obstacles,lengths, final_point, angle_ranges, generation, good_ratio):
    arm = create_arm(gene, lengths)
    coeff = 1.
    if validate(arm) == False:
        coeff += 0.5 * generation
    if good_angles(gene, angle_ranges) == False:
        coeff += 0.2 * generation
    if non_intersecting_arm(arm, obstacles) == False:
        coeff += 0.2 * (generation ** 1.5)
    return -final_point.distance(arm.lines[-1].b) * coeff

def random_population(population_size, lengths, sigma, angle_ranges, obstacles):
    d = len(lengths)
    population=np.zeros((population_size, 2*d))
    for i in range(population_size):
        print i
        population[i, :d] = random_arm(lengths, angle_ranges, obstacles)
    population[:, d:] = sigma
    return population

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
    chromosome_mutation = np.random.normal(0, mutated[d:])
    mutated[:d] = mutated[:d] + chromosome_mutation
    mutated[:d] = angle_normalize(mutated[:d])
    return mutated

def evaluate_population(population, population_size, d, final_point, obstacles, lengths, angle_ranges, generation):
    res = np.zeros(population_size)
    good_ratio = 0.
    for gene in population:
        if good_angles(gene[:d], angle_ranges) and non_intersecting_arm(create_arm(gene[:d], lengths), obstacles):
            good_ratio += 1
    good_ratio /= population_size
    print "GOOD RATIO ", good_ratio
    for i in range(population_size):
        res[i]= objective_function(population[i, :d], obstacles, lengths, final_point, angle_ranges, generation, good_ratio)
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

    mixture_number = 3
    if np.random.random() < 0.8:
        return np.random.choice(len(fitness_values), (number_of_offsprings, mixture_number), True, fitness_values).astype(np.int64)
    return tournament_selection(fitness_values, number_of_offsprings, mixture_number)

def get_best_good(population, objective_values, d, angle_ranges, obstacles):
    res = -100.
    for i in range(len(objective_values)):
        arm = create_arm(population[i, :d], lengths )
        if good_angles(population[i, :d], angle_ranges) and non_intersecting_arm(arm, obstacles):
            res = max(res, objective_values[i])
    return res

def ES(population_size, number_of_offsprings, d, sigma, iters, final_point, obstacles, lengths, angle_ranges):

    tau = 1. / np.sqrt(2*d)
    tau0 = 1./ np.sqrt(2*np.sqrt(d))

    population = random_population(population_size, lengths, sigma, angle_ranges, obstacles)
    objective_values = evaluate_population(population, population_size, d, final_point, obstacles, lengths, angle_ranges, 0)

    results = np.zeros((iters+1))
    results[0] = get_best_good(population, objective_values, d, angle_ranges, obstacles)
    print 0, results[0], objective_values.std()
    best_sigmas = np.zeros((d, iters+1))
    best_sigmas[:, 0] = population[0, d:].T
    generations = [population]

    for t in range(1, iters+1):
        indices = parent_selection(objective_values, number_of_offsprings)
        objective_values = evaluate_population(population, population_size, d, final_point, obstacles, lengths, angle_ranges, t)
        children_population = np.zeros((number_of_offsprings, 2*d))
        for i in range(number_of_offsprings):
            children_population[i] = mutation(population[indices[i], :].mean(axis=0), tau, tau0)
        children_objective_values = evaluate_population(children_population, number_of_offsprings, d, final_point, obstacles, lengths, angle_ranges, t)

        objective_values = np.hstack([objective_values, children_objective_values])
        population = np.vstack([population, children_population])
        I = np.argsort(objective_values)[::-1]
        population = population[ I[:population_size] , :]
        objective_values = objective_values[I[:population_size]]

        ### recording statistics
        generations.append(population.copy())
        results[t] = max(results[t-1], get_best_good(population, objective_values, d, angle_ranges, obstacles) )
        pos_best = objective_values.argmax()
        for i in range(d):
            best_sigmas[i][t] = population[pos_best][d+i]

        if t % 1 == 0:
            print t, results[t], objective_values.std()

    return results, best_sigmas, generations

################################################################################

population_size = 100
number_of_offsprings = 150
d = 25
iters = 100
sigma = 0.5
number_of_obstacles=15

lengths = np.random.random(d) * 10

angle_ranges= np.zeros((d, 2))
angle_ranges[:, 0] = np.random.uniform(low=-np.pi/2, high=-np.pi/6, size=(1, d))
angle_ranges[:, 1] =  np.random.uniform(low=np.pi/6, high=np.pi/2, size=(1, d))
good_arm = create_arm( random_arm(lengths, angle_ranges, []), lengths)

P = good_arm.lines[-1].b
obstacles= create_obstacles(number_of_obstacles, lengths.sum(), good_arm)

x, y = good_arm.plot_data()
plt.plot(x, y)
for o in obstacles:
    x, y = o.plot_data()
    plt.plot(x, y)
plt.axis('equal')
plt.show()

results, sigmas, generations = ES(population_size, number_of_offsprings, d, sigma, iters, P, obstacles, lengths, angle_ranges)
#plt.plot(results)
for sigma in sigmas:
    plt.plot(sigma)
plt.savefig('sigmas')
plt.close()
plt.plot(results)
plt.savefig('results')
simulation(generations, lengths, P, angle_ranges, obstacles)
