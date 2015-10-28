#!/usr/bin/env python
# coding: utf-8
from time import time
import random

class Traindata():
	"""docstring for Traindata"""

	posi = []
	nega = []
	cv = []
	k = 3

	def __init__(self):
		pass

	def load_intm(self, filename, isPosi):
		startTime = time()
		dataset = self.posi if isPosi else self.nega
		state = 'Positive' if isPosi else 'Negative'
		with open(filename) as f:
			f.readline()
			i = 0
			while 1:
				line = f.readline().replace('\t',' ')
				if not line: break
				pp = line.split(' ')[1].replace('|',' ')
				dataset.append(pp)
				i += 1
		totalTime = time()-startTime
		print '[*] Load '+state+' PPIs data('+str(i)+') from \''+filename+'\' in '+str(totalTime)+'s'

	def load_txt(self, filename, isPosi):
		startTime = time()
		dataset = self.posi if isPosi else self.nega
		state = 'Positive' if isPosi else 'Negative'
		with open(filename) as f:
			line = ' '
			i = 0
			while line:
				line = f.readline().replace('\r\n','')
				dataset.append(' '.join(line.split('\t')))
				i += 1
		dataset.pop()
		i -= 1
		totalTime = time()-startTime
		print '[*] Load '+state+' PPIs data('+str(i)+') from \''+filename+'\' in '+str(totalTime)+'s'

	def load_mitab(self, filename, isPosi):
		startTime = time()
		dataset = self.posi if isPosi else self.nega
		state = 'Positive' if isPosi else 'Negative'
		with open(filename) as f:
			i = 0
			while 1:
				line = f.readline().replace('\n','')
				if not line: break
				p1, p2 = line.replace('uniprotkb:','').split('\t')[:2]
				dataset.append(' '.join([p1,p2]))
				i += 1
		totalTime = time()-startTime
		print '[*] Load '+state+' PPIs data('+str(i)+') from \''+filename+'\' in '+str(totalTime)+'s'

	# K-fold Cross Validation
	def KCV(self, k):
		startTime = time()
		self.k = k
		self.cv = []
		p = len(self.posi)
		n = len(self.nega)
		prange = range(p)
		nrange = range(n)
		random.shuffle(prange)
		random.shuffle(nrange)
		dp, mp = p / k, p % k
		dn, mn = n / k, n %k
		for i in xrange(k):
			tmp = []
			for jp in prange[i*dp:(i+1)*dp]:
				tmp.append('+ '+self.posi[jp])
			if i < mp:
				tmp.append('+ '+self.posi[prange[-(i+1)]])
			for jn in nrange[i*dn:(i+1)*dn]:
				tmp.append('- '+self.nega[jn])
			if i >= k - mn:
				tmp.append('- '+self.nega[nrange[-(k-i)]])
			self.cv.append(tmp)
		totalTime = time()-startTime
		print '[*] Set cross validation data (k='+str(k)+') in '+str(totalTime)+'s'

	def done(self):
		p = len(self.posi)
		n = len(self.nega)
		print '[*] Positive data: '+str(p)+', Negative data: '+str(n)+', Total: '+str(p+n)

	def unittest(self):
		pass

if __name__=='__main__':
	traindata = Traindata()
	traindata.load_intm('yeast.db.all.200908.intm', True)
	traindata.load_intm('human.db.all.201008.intm', True)
	traindata.load_intm('human.db.all.201108-201008.intm', True)
	traindata.load_txt('combined.txt', False)
	traindata.load_mitab('18509523_neg.mitab', False)
	traindata.KCV(10)
	traindata.done()
