import tensorflow.compat.v1 as tf


class MultiLayerPerceptron:
  """
  Args:
    hidden_layers: List of positive integers.
    output_size: Positive integer.
    output_activation: Callable.
    hidden_activation: Callable.
    dropout_rate: Float in range (0, 1], as the rate of dropout between
      the layers herein.
    use_batchnorm: Bool, optional.
    name: String.
  """

  def __init__(self,
               hidden_layers,
               output_size,
               output_activation=None,
               hidden_activation=tf.nn.relu,
               dropout_rate=0.0,
               use_batchnorm=True,
               name='mlp'):
    self.hidden_layers = hidden_layers
    self.output_size = output_size
    self.output_activation = output_activation
    self.hidden_activation = hidden_activation
    self.dropout_rate = dropout_rate
    self.use_batchnorm = use_batchnorm
    self.name = name

  def __call__(self, inputs, reuse=None):
    """
    Args:
      inputs: Tensor with shape `batch_shape + event_shape`.
      reuse: Boolean.
    Returns:
      Tensor with shape `batch_shape + [output_size]`.
    """
    hiddens = inputs
    with tf.variable_scope(self.name, reuse=reuse):
      for i, hidden_layer in enumerate(self.hidden_layers):
        with tf.name_scope(f'hidden_layer_{i}'):
          hiddens = tf.layers.dense(hiddens, hidden_layer)
          if self.use_batchnorm:
            hiddens = tf.layers.batch_normalization(hiddens)
          if self.hidden_activation:
            hiddens = self.hidden_activation(hiddens)
          if self.dropout_rate:
            hiddens = tf.layers.dropout(hiddens, self.dropout_rate)
      outputs = tf.layers.dense(hiddens, self.output_size,
                                activation=self.output_activation,
                                name='output_layer')
      return outputs


class RandomWalk:
  # TODO: Implement this.
  pass
