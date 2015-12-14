#!/usr/bin/env python
from numpy import *
from scipy.spatial.distance import pdist, squareform
from itertools import product, permutations, combinations
from time import time

def timeit(fn):
   def wrapper(*args):
      n = 10
      startTime = time()
      for i in range(n): result = fn(*args)
      totalTime = (time()-startTime) / n
      print '[*] Test function {0}() {1} times, average: {2} s'.format(fn.__name__, n, totalTime)
      return result
   return wrapper

# cost 6.8s
def dca(input, output):
   '''
   Direct Coupling Analysis (DCA)
   
   input  - file containing the FASTA alignment
   output - file for dca results. The file is composed by N(N-1)/2 
            (N = length of the sequences) rows and 4 columns: 
            residue i (column 1), residue j (column 2),
            MI(i,j) (Mutual Information between i and j), and 
            DI(i,j) (Direct Information between i and j).
            Note: all insert columns are removed from the alignment.
   
   SOME RELEVANT VARIABLES:
   M        number of sequences in the alignment
   N        number of residues in each sequence (no insert)
   align    M x N matrix containing the alignmnent
   q        equal to 5 (4 ribonucleic acids + 1 gap)
   Meff     effective number of sequences after reweighting
   fij      N x N x q x q matrix containing the reweigthed frequency
            counts
   Pij      N x N x q x q matrix containing the reweighted frequency 
            counts with pseudo counts
   C        N(q-1) x N(q-1) matrix containing the covariance matrix
   '''

   pseudocount_weight, theta = 0.5, 0.2
   print '[*] Load FASTA alignment data:', input
   [M, N, q, align] = alignment(input)
   print '[*] M =',M,'N =',N,'q =',q
   print '[*] Calculate fi, fij ...'
   [fi, fij, Meff] = calculate_f(align, theta)
   print '[*] Meff =',Meff
   print '[*] Calculate Pi, Pij ...'
   [Pi, Pij] = calculate_P(fi, fij, pseudocount_weight)
   print '[*] Calculate C ...'
   C = calculate_C(Pi, Pij)
   invC = linalg.inv(C)
   print '[*] Calculate results & save to',output
   calculate_results(Pij, Pi, fij, fi, invC, output)

def alignment(Rfamfile):
   seq = fastaread(Rfamfile)
   rnaNum = {'-': 1, 'A': 2, 'U': 3, 'C': 4, 'G': 5}
   rnaMap = lambda r: rnaNum[r] if r in rnaNum else 1
   
   align = array([ [rnaMap(r) for r in s if r != '.' and r == r.upper()] for s in seq])
   (M, N) = align.shape
   q = align.max()
   return [M, N, q, align]

def fastaread(fastafile):
   seq, tmp = [], ''
   with open(fastafile) as f:
      for line in f.readlines():
         if line[0] == '>':
               seq.append(tmp.replace('\n',''))
               tmp = ''
         else: tmp += line
   seq.pop(0)
   return seq

# cost 4.5s
def calculate_f(align, theta):
   (M, N) = align.shape
   q = align.max()
   if theta > 0: W = 1/(1+sum(squareform(pdist(align,'hamming')<theta),0))
   Meff = sum(W)

   fi = array([sum(W * (align.T == i), 1) for i in range(1,q+1)]).T / Meff

   fij = zeros((N,N,q,q))
   for (i,j,A,B) in product(range(N), range(N), range(1,q+1),range(1,q+1)):
         fij[i,j,A-1,B-1] = sum(W * (align[:,i] == A) * (align[:,j] == B))
   fij /= Meff

   return [fi, fij, Meff]

def calculate_P(fi, fij, pseudocount_weight):
   (N, q) = fi.shape
   Pi = (1 - pseudocount_weight) * fi + pseudocount_weight/q * ones((N,q))
   Pij = (1 - pseudocount_weight) * fij + pseudocount_weight/q/q * ones((N,N,q,q))

   for i in xrange(N):
      Pij[i,i] = 0
      for j in xrange(q):
         Pij[i,i,j,j] = (1 - pseudocount_weight) * fij[i,i,j,j] + pseudocount_weight / q

   return [Pi, Pij]

def calculate_C(Pi, Pij):
   (N, q) = Pi.shape
   C = zeros(( N*(q-1), N*(q-1) ))
   for (i,j,A,B) in product(range(N), range(N), range(q-1),range(q-1)):
      C[ (q-1)*i + A, (q-1)*j + B ] = Pij[i,j,A,B] - Pi[i,A] * Pi[j,B]
   return C

def calculate_results(Pij, Pi, fij, fi, invC, output):
   (N, q) = Pi.shape
   with open(output, 'w') as f:
      for (i, j) in combinations(range(N),2):
         MI = calculate_MI(i,j,fi,fij)
         W = calculate_W(i,j,q,invC)
         DI = calculate_DI(i,j,q,W,Pi)
         f.write('{0}\t{1}\t{2}\t{3}\n'.format(i+1, j+1, MI, DI))

def calculate_MI(i, j, fi, fij):
   MI, q = 0, fi.shape[1]
   for (A, B) in product(range(q), range(q)):
         if fij[i,j,A,B] > 0:
            MI += fij[i,j,A,B] * log( fij[i,j,A,B] / fi[i,A] / fi[j,B] )
   return MI

def calculate_W(i, j, q, C):
   W = ones((q,q))
   a, b = (q-1)*i, (q-1)*(i+1)
   c, d = (q-1)*j, (q-1)*(j+1)
   W[:q-1, :q-1] = exp( -C[a:b,c:d] )
   return W

def calculate_DI(i, j, q, W, Pi):
   [mu1, mu2] = compute_mu(i,j,q,W,Pi)
   tiny = 1e-100
   Pdir = W * mu1.T.dot(mu2)
   Pdir /= sum(Pdir)
   Pfac = Pi[i,:].reshape(Pi[i,:].shape[0],1) * Pi[j,:]
   DI = trace( Pdir.T.dot( log( (Pdir+tiny) / (Pfac+tiny) ) ) )
   return DI

def compute_mu(i, j, q, W, Pi):
   epsilon, diff = 1e-4, 1.0
   mu1, mu2 = ones((1,q))/q, ones((1,q))/q
   pi, pj = Pi[i, :], Pi[j, :]

   while diff > epsilon:
      scra1 = mu2.dot(W.T)
      scra2 = mu1.dot(W)
      new1 = pi / scra1
      new1 /= sum(new1)
      new2 = pj / scra2
      new2 /= sum(new2)
      diff = max( abs(new1-mu1).max(), abs(new2-mu2).max()  )
      mu1, mu2 = new1, new2

   return [mu1, mu2]

if __name__ == '__main__':
   dca('3ADC.RF01852.afa.txt', '2.txt')