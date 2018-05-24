import numpy as np
import random
from numpy.polynomial.polynomial import polyfit
import matplotlib.pyplot as plt

# Sample data
x = np.arange(10)
y = (50 * random.random()*x + (10 * random.random()))

x_len = np.size(x) # more general use: np.shape(x)[0]

# Fit with polyfit
b, m = polyfit(x, y, 1)

plt.plot(x, y, '.')
plt.plot(x, b + m * x, '-')
plt.show()
