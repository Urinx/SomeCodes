#!/usr/bin/python

import numpy as np

def testing_numpy():
	ax=np.array([1,2,3])
	ay=np.array([3,4,5])
	print ax
	print ax*2
	print ax+10
	print np.sqrt(ax)
	print np.cos(ax)
	print ax-ay
	print np.where(ax<2,ax,10)

	m=np.matrix([ax,ay,ax])
	print m
	print m.T

	grid1=np.zeros(shape=(10,10),dtype=float)
	grid2=np.ones(shape=(10,10),dtype=float)
	print grid1
	print grid2
	print grid1[1]+10
	print grid2[:,2]*2

if __name__=='__main__':
	testing_numpy()