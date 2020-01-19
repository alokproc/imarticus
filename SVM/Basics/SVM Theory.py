#!/usr/bin/env python
# coding: utf-8

# # Support Vector Machine

# A Support Vector Machine (SVM) is a discriminative classifier formally defined by a separating hyperplane. In other words, given labeled training data (supervised learning), the algorithm outputs an optimal hyperplane which categorizes new examples. In two dimentional space this hyperplane is a line dividing a plane in two parts where in each class lay in either side.

# ![image.png](attachment:image.png)

# ![image.png](attachment:image.png)

# To separate the two classes of data points, there are many possible hyperplanes that could be chosen. Our objective is to find a plane that has the maximum margin, i.e the maximum distance between data points of both classes. Maximizing the margin distance provides some reinforcement so that future data points can be classified with more confidence.

# **Hyperplanes** are decision boundaries that help classify the data points. Data points falling on either side of the hyperplane can be attributed to different classes. Also, the dimension of the hyperplane depends upon the number of features. If the number of input features is 2, then the hyperplane is just a line. If the number of input features is 3, then the hyperplane becomes a two-dimensional plane. It becomes difficult to imagine when the number of features exceeds 3.

# # Tuning parameters: Kernel, Regularization, Gamma and Margin.

# **Kernel**
# 
# * The learning of the hyperplane in linear SVM is done by transforming the problem using some linear algebra. This is where the kernel plays role.
# 
# * For linear kernel the equation for prediction for a new input using the dot product between the input (x) and each support vector (xi) is calculated as follows:
# 
# f(x) = B(0) + sum(ai * (x,xi))
# 
# * This is an equation that involves calculating the inner products of a new input vector (x) with all support vectors in training data. The coefficients B0 and ai (for each input) must be estimated from the training data by the learning algorithm.
# The polynomial kernel can be written as K(x,xi) = 1 + sum(x * xi)^d and exponential as K(x,xi) = exp(-gamma * sum((x — xi²)). 

# **Regularization**
# 
# * The Regularization parameter (often termed as C parameter in python’s sklearn library) tells the SVM optimization how much you want to avoid misclassifying each training example.
# 
# * For large values of C, the optimization will choose a smaller-margin hyperplane if that hyperplane does a better job of getting all the training points classified correctly. Conversely, a very small value of C will cause the optimizer to look for a larger-margin separating hyperplane, even if that hyperplane misclassifies more points.

#                                         LOW Regularization

# ![image.png](attachment:image.png)

#                                         GOOD Regularization

# ![image.png](attachment:image.png)

# **Gamma**
# 
# * The gamma parameter defines how far the influence of a single training example reaches, with low values meaning ‘far’ and high values meaning ‘close’. In other words, with low gamma, points far away from plausible seperation line are considered in calculation for the seperation line. Where as high gamma means the points close to plausible line are considered in calculation.
# 

# ![image.png](attachment:image.png)

# ![image.png](attachment:image.png)

# **Margin**
# 
# And finally last but very importrant characteristic of SVM classifier. SVM to core tries to achieve a good margin.
# 
# * A margin is a separation of line to the closest class points.
# 
# * A good margin is one where this separation is larger for both the classes. Images below gives to visual example of good and bad margin. A good margin allows the points to be in their respective classes without crossing to other class.
# 
# 

# ![image.png](attachment:image.png)

# ![image.png](attachment:image.png)

# In[ ]:




