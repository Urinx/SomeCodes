#!/usr/bin/env python
# coding:utf-8
from matplotlib import pyplot

x=range(-5,6)
pyplot.plot(x,[i**2 for i in x],color='red',linestyle='dashed',marker='o')
'''
pyplot.plot(x,y,'ro--')
				'bs'
				'g^'
'''
pyplot.show()