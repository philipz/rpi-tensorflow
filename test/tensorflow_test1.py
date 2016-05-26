import tensorflow as tf

with tf.Session():
  input1 = tf.constant([1.0, 1.0, 1.0, 1.0])
  input2 = tf.constant([2.0, 2.0, 2.0, 2.0])
  output = tf.add(input1, input2)
  result = output.eval()
  print result
