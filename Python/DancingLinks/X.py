#! /usr/bin/env python

def solve(X,Y,solution=[]):
	if not X:
		yield list(solution)
	else:
		c=min(X,key=lambda c: len(X[c]))
		for r in list(X[c]):
			solution.append(r)
			cols=select(X,Y,r)
			for s in solve(X,Y,solution):
				yield s
			deselect(X,Y,r,cols)
			solution.pop()

def select(X,Y,r):
	cols=[]
	for j in Y[r]:
		for  i in X[j]:
			for k in Y[i]:
				if k!=j:
					X[k].remove(i)
		cols.append(X.pop(j))
	return cols

def deselect(X,Y,r,cols):
	for j in reversed(Y[r]):
		X[j]=cols.pop()
		for i in X[j]:
			for k in Y[i]:
				if k!=j:
					X[k].append(i)

def T(Y):
	X={}
	for i,j in Y.items():
		for k in j:
			if k in X:
				X[k].append(i)
			else:
				X[k]=[i]
	return X

if __name__=='__main__':
	Y={
		'A':[1,4,7],
		'B':[1,4],
		'C':[4,5,7],
		'D':[3,5,6],
		'E':[2,3,6,7],
		'F':[2,7]
	}
	X=T(Y)
	print list(solve(X,Y))