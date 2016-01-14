#!/usr/bin/env python

"""
The Nussinov Algorithm solves the problem of RNA non-crossing secondary
structure prediction by base pair maximization with input S.
"""

Seq = '\
GUUAAUCAUGCUCGGGUAAUCGCUGCGGCCGGUUUCGGCCGUAGAGGAAAGUCCAUGCUC\
GCACGGUGCUGAGAUGCCCGUAGUGUUCGUGGAAACACGAGCGAGAAACCCAAAUGAUGG\
UAGGGGCACCUUCCCGAAGGAAAUGAACGGAGGGAAGGACAGGCGGCGCAUGCAGCCUGU\
AGAUAGAUGAUUACCGCCGGAGUACGAGGCGCAAAGCCGCUUGCAGUACGAAGGUACAGA\
ACAUGGCUUAUAGAGC'

DOMAIN = [
	[4,  'uuuggguaaucgcugguuua..uuuuuauuguugaGGaaaguccaugcucgcacaa.gcugugauGcuuGuaGuguucgug', 81],
	[11, 'CUCGGGUAAUCGCUGCGGCCggUUUCGGCCGUAGAGGAAAGUCCAUGCUCGCACGGuGCUGAGAUGCCCGUAGUGUUCGUG', 91],
	[226,'cacgagcgagaaacccaaauuuuGguaggggcaccuaauuuaaggaaaugaacguaaaauugggacgguuu.....uuaaaucuguaGauagaugauuaccgccagaguaug.....ccua............guacuauggaacagaacauGGcuuauaga', 365],
	[96, 'CACGAGCGAGAAACCCAAAUGAUGGUAGGGGCACCUUCCCGAAGGAAAUGAACGGA-GGGAAGGACAGGCGgcgcaUGCAGCCUGUAGAUAGAUGAUUACCGCCGGAGUACGaggcgC--AaagccgcuugcaGUACGAAGGUACAGAACAUGGCUUAUAGA', 254]
]
Map = {}
DIFILE = 'test_ranked.DI'
MIFILE = 'test_ranked.MI'

L = len(Seq)
M = [['-']*L for i in range(L)] # Contact-scoring matrix
N = [['-']*L for i in range(L)]
Struc = ['.']*L

def initMap():
	for i in range(0, len(DOMAIN), 2):
		a, b = DOMAIN[i][0]-1, DOMAIN[i+1][0]-1
		for j in range( len(DOMAIN[i][1]) ):
			a += 1
			b += 1
			if DOMAIN[i][1][j] == '.':
				a -= 1
				continue
			elif DOMAIN[i+1][1][j] == '-':
				b -= 1
				continue
			Map[a] = b

def printMat(mat, title = ' [Nussinov Table]'):
	print title
	print '  ' + ' '.join([c for c in Seq])
	for i in range(L):
		print Seq[i],' '.join([str(j) for j in mat[i]])
	print

def output(filename, mat):
	with open(filename,'w') as f:
		f.write('  ' + '\t'.join([c for c in Seq]) + '\n')
		for i in range(L):
			f.write(Seq[i] + ' ' + '\t'.join([str(j) for j in mat[i]]) + '\n')

def printStruc():
	print ' [Secondary Structure]'
	print '-',Seq
	print '-',''.join(Struc)

def sigma(i,j):
	if (Seq[i], Seq[j]) in (('A','U'),('U','A'),('C','G'),('G','C')):
		return 1
	return 0

def initM():
	n = 10
	initMap()
	for i in range(L):
		for j in range(i+1,L):
			M[i][j] = sigma(i,j) - 1

	with open(MIFILE, 'r') as f:
		for line in f.readlines()[:L*n]:
			arr = line.split(' ')
			a, b = int(arr[0]), int(arr[1])
			if a in Map and b in Map:
				i = Map[a] - 1
				j = Map[b] - 1
				if sigma(i,j) == 1:
					M[i][j] += float(arr[-1])

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
				N[i+1][j-1] + M[i][j],
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
			if sigma(k,j) == 1 and N[i][j] == N[i][k-1] + N[k+1][j-1] + M[k][j]:
				Struc[k] = '('
				Struc[j] = ')'
				Traceback(i, k-1)
				Traceback(k+1, j-1)
				return

if __name__ == '__main__':
	initM()
	Nussinov()
	Traceback(0, L-1)
	printStruc()
