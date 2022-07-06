import tensorflow as tf
from typing import Callable


def random_uniform(size):
  return tf.random.uniform(shape=size, minval=-1.0, maxval=1.0)


def nabla(f: Callable):
  zero = tf.UnconnectedGradients.ZERO

  tf.function
  def nabla_f(x):
    with tf.GradientTape() as tape:
      tape.watch(x)
      y = tf.reduce_sum(f(x))
      return tape.gradient(y, x, unconnected_gradients=zero)

  return nabla_f


class RandomWalkParams:
  
  def __init__(self, t, dt, T):
    self.t = tf.convert_to_tensor(t)
    self.dt = tf.convert_to_tensor(dt)
    self.T = tf.convert_to_tensor(T)


def random_walk(f: Callable, x: tf.Tensor, params):
  stddev = tf.sqrt(2 * params.T * params.dt)
  s = tf.constant(0.0)
  while tf.less(s, params.t):
    dx = f(x) * params.dt
    if tf.greater(stddev, 0.0):
      dx += stddev * tf.random.truncated_normal(tf.shape(x))
    x += dx
    s += params.dt
  return x


def negate(f):
  
  def negated(x):
    return -f(x)
  
  return negated


def get_param_gradients(network: tf.Module, x: tf.Tensor):
  params = network.trainable_variables
  with tf.GradientTape() as tape:
    y = tf.reduce_mean(network(x))
    return tape.gradient(y, params)
