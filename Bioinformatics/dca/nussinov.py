#!/usr/bin/env python

"""
The Nussinov Algorithm solves the problem of RNA non-crossing secondary
structure prediction by base pair maximization with input S.
"""

Seq = 'AAAUCCCAGGA'
# Seq = 'GCACGACG'
# Seq = 'GGGAAAUCC'
L = len(Seq)
N = [ ['-']*L for i in range(L)]
Struc = ['.']*L

def printN():
	print ' [Nussinov Table]'
	print '  ' + ' '.join([c for c in Seq])
	for i in range(L):
		print Seq[i],' '.join([str(j) for j in N[i]])
	print

def printStruc():
	print ' [Secondary Structure]'
	print '-',Seq
	print '-',''.join(Struc)

def sigma(i,j):
	if (Seq[i], Seq[j]) in (('A','U'),('U','A'),('C','G'),('G','C')):
		return 1
	return 0

def Nussinov():
	# initialization
	for i in range(L):
		N[i][i] = 0
		if i != 0: N[i][i-1] = 0
	# recursion
	for a in range(1,L):
		for i in range(L-a):
			j = i + a
			tmp = [
				N[i+1][j],
				N[i][j-1],
				N[i+1][j-1] + sigma(i,j),
				max([N[i][k] + N[k+1][j] for k in range(i,j)])
			]
			N[i][j] = max(tmp)

def Traceback(i,j):
	if j <= i: return
	elif N[i][j] != 1 and N[i][j] == N[i+1][j]:
		Traceback(i+1, j)
		return
	else:
		for k in range(i,j):
			if sigma(k,j) == 1 and N[i][j] == N[i][k-1] + N[k+1][j-1] + 1:
				Struc[k] = '('
				Struc[j] = ')'
				Traceback(i, k-1)
				Traceback(k+1, j-1)
				return

if __name__ == '__main__':
	Nussinov()
	printN()
	Traceback(0, L-1)
	printStruc()