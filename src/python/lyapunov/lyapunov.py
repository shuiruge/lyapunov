import tensorflow as tf
from collections import namedtuple


def random_uniform(size):
  return tf.random.uniform(shape=size, minval=-1.0, maxval=1.0)



def nabla(f):
  unconnected_gradients = tf.UnconnectedGradients.ZERO

  tf.function
  def grad_f(x):
    with tf.GradientTape() as tape:
      y = f(x)
      return tape.gradient(y, x, unconnected_gradients=unconnected_gradients)

  return f


RandomWalkParams = namedtuple('RandomWalkParams', 't, dt, T')
 

def random_walk(f, x0, params):
  sqrt_T = tf.sqrt(params.T)

  s = params.t
  x = x0
  while s < params.t:
    dW = tf.random.truncated_normal(shape=tf.shape(x), stddev=sqrt_T)
    x = f(x) * params.dt + dW
  return x


def get_loss_gradients(E:tf.Module, xD, xE):
  with tf.GradientTape() as tape:
    yD = tf.reduce_mean(E(xD))
    grad_D = tape.gradient(yD, E.trainable_variables)

  with tf.GradientTape() as tape:
    yE = tf.reduce_mean(E(xE))
    grad_E = tape.gradient(yE, E.trainable_variables)

  return [gD - gE for gD, gE in zip(grad_D, grad_E)]


def negate(f):
  
  def negated(x):
    return -f(x)
  
  return negated


# TODO: Implement this.
class EnergyModel:

  def __init__(self, E: tf.Module, init_xE: tf.Tensor):
    self.E = E
    self.xE = init_xE
    self.gradE = nabla(E)

  def get_gradients(self, xD: tf.Tensor, params: RandomWalkParams):
    self.xE = random_walk(negate(self.gradE), self.xE, params)
    return get_loss_gradients(self.E, xD, self.xE)


class Lyapunov:
  
  def __init__(self, f, E: tf.Module, init_xD: tf.Tensor, init_xE: tf.Tensor):
    self.f = f
    self.xD = init_xD
    self.E = EnergyModel(E, init_xE)

  def get_gradients(self, params: RandomWalkParams):
    self.xD = random_walk(f, self.xD, params)
    return self.E.get_gradient(self.xD, params)
