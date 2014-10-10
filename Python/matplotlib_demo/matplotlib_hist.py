#!/usr/bin/env python
# coding:utf-8
from matplotlib import pyplot
import numpy as np

mu,sigma=100,15
x=mu+sigma*np.random.randn(10000)
pyplot.hist(x,50,normed=1,facecolor='b',alpha=0.5)
pyplot.xlabel('Smarts')
pyplot.ylabel('Probability')
pyplot.title('Histogram of IQ')
pyplot.text(50,.025,r'$\mu=100,\sigma=15$')
pyplot.grid(True)
pyplot.axis([40,160,0,0.03])
pyplot.show()