#!/usr/bin/env python
# coding: utf-8
from time import time

class AAIndex1():
	"""docstring for AAIndex"""

	data = {}

	def __init__(self, filename):
		startTime = time()
		self.loadData(filename)
		totalTime = time()-startTime
		print '[*] Load AAindex1 data('+str(len(self.data))+') from \''+filename+'\' in '+str(totalTime)+'s'

	def loadData(self, filename):
		with open(filename) as f:
			line = '#'
			flag = ''
			item = {
				'year': '',
				'description': '',
				'author': '',
				'article': '',
				'journal': '',
				'data': [],
			}
			accession = ''
			while line:
				l0, l2 = line[0], line[2:]
				if l0 == 'H':
					accession = l2
				elif l0 == 'D':
					item['description'] = l2
					flag = l0
				elif l0 == 'A':
					item['author'] = l2
					flag = l0
				elif l0 == 'T':
					item['article'] = l2
					flag = l0
				elif l0 == 'J':
					item['journal'] = l2
					flag = l0
				elif l0 == 'I':
					flag = l0
				elif l0 == ' ':
					if flag == 'D':
						item['description'] += l2
					elif flag == 'T':
						item['article'] += l2
					elif flag == 'I':
						item['data'] += filter(lambda x: x, l2.split(' '))
				elif l0 == '/':
					item['year'] = item['description'][-5:-1]
					self.data[accession] = item
					item = {'data': []}
					flag = ''
				line = f.readline().replace('\n','')

	def use(self, accession):
		acid = 'ARNDCQEGHILKMFPSTWYV'
		item = self.data[accession]
		result = {}
		print '[*] Use '+item['description']
		for i in range(len(acid)):
			result[acid[i]] = item['data'][i]
		return result

	def unittest(self):
		access = 'FAUJ880103' # van der Waals
		van = self.use(access)
		assert van['P']=='2.72', 'Wrong value'
		assert van['T']=='2.60', 'Wrong value'
		assert van['R']=='6.13', 'Wrong value'

if __name__=='__main__':
	aaindex1 = AAIndex1('aaindex1.txt')
	aaindex1.unittest()
