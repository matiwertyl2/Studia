import numpy as np
import Const as const

class Brain:

    def __init__(self, network):
        self.network = network

    def scale_speed(self, speed):
        return speed * const.car_max_acc

    def scale_turn(self, alpha):
        return alpha * const.car_max_turn

    def scale_inputs(self, inputs):
        inputs[:5] /= const.car_sensor_length
        inputs[5] /= const.car_max_speed
        return inputs

    ### inputs - some number of sensors and speed
    ### output - dV dAlpha
    def make_decision(self, inputs):
        inputs = self.scale_inputs(inputs)
        decision = self.network.feed_forward(inputs)
        decision[0] = self.scale_speed(decision[0])
        decision[1] = self.scale_turn(decision[1])
        return decision


class Network:

    ### layers - list of arrays responsible for wieghts
    def __init__(self, layers):
        self.layers = layers

    def feed_forward(self, inputs):
        for layer in self.layers:
            inputs = np.tanh(np.dot(inputs, layer))
        return inputs
