#!/usr/bin/env python
# coding:utf-8
from matplotlib import pyplot
import numpy as np

def f(t):
	return np.exp(-t)*np.cos(2*np.pi*t)

t1=np.arange(0.0,5.0,0.1)
t2=np.arange(0.0,5.0,0.02)
pyplot.figure(1)
pyplot.subplot(211)
pyplot.plot(t1,f(t1),'g^',t2,f(t2),'k')
pyplot.subplot(212)
pyplot.plot(t2,np.cos(2*np.pi*t2),'r--')
pyplot.show()