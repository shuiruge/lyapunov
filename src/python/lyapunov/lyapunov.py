from operator import ne
from random import Random
import tensorflow as tf
from typing import Callable, List
from .utils import get_param_gradients, nabla, RandomWalkParams, random_walk, negate


class EnergyModel:

  def __init__(self, network: tf.Module, fantasy_particles: tf.Tensor):
    self.network = network
    self.fantasy_particles = tf.Variable(fantasy_particles, trainable=False)

    self.params = self.network.trainable_variables
    self.particle_gradient = nabla(self.network)
    self.param_gradients = lambda x: get_param_gradients(self.network, x)
  
  def __call__(self, x: tf.Tensor, params: RandomWalkParams):
    return random_walk(negate(self.particle_gradient), x, params)

  def get_loss_gradients(
        self,
        real_particles: tf.Tensor,
        params: RandomWalkParams,
        warmup: bool
    ):
    if not warmup:
      self.fantasy_particles.assign(
          random_walk(
              negate(self.particle_gradient),
              self.fantasy_particles,
              params)
      )
    real_grads = get_param_gradients(self.network, real_particles)
    fantasy_grads = get_param_gradients(self.network, self.fantasy_particles)
    return [r - f for r, f in zip(real_grads, fantasy_grads)]
  
  def get_optimize_fn(
        self,
        optimizer: tf.keras.optimizers.Optimizer,
        params: RandomWalkParams,
        callbacks: List[Callable] = None,
    ):
    callbacks = [] if callbacks is None else callbacks
    step = tf.Variable(0, trainable=False, dtype='int32')

    def train_step(batch):
      vars = self.params
      grads = self.get_loss_gradients(batch, params, warmup=False)
      optimizer.apply_gradients(zip(grads, vars))

      step.assign_add(1)
      for callback in callbacks:
        callback(self, step, batch, grads)
      
      return step

    return train_step


class Lyapunov:
  
  def __init__(
        self,
        f: Callable,
        network: tf.Module,
        real_particles: tf.Tensor,
        fantasy_particles: tf.Tensor,
    ):
    self.f = f
    self.real_particles = tf.Variable(real_particles, trainable=False)
    self.energy_model = EnergyModel(network, fantasy_particles)

  def get_loss_gradients(
        self,
        params: RandomWalkParams,
        warmup: bool
    ):
    if not warmup:
      self.real_particles.assign(
          random_walk(
              self.f,
              self.real_particles,
              params)
      )
    return self.energy_model.get_loss_gradients(
        self.real_particles, params, warmup)
