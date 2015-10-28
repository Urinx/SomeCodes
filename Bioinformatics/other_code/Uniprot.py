#!/usr/bin/env python
# coding: utf-8
from time import time

class Uniprot():
	"""docstring for Uniprot"""

	sqMap = {}

	def __init__(self, filename):
		startTime = time()
		self.load_fasta(filename)
		totalTime = time()-startTime
		print '[*] Load fasta data('+str(len(self.sqMap))+') from \''+filename+'\' in '+str(totalTime)+'s'

	def load_fasta(self, fasta):
		with open(fasta) as f:
			ac = ''
			sq = ''
			while 1:
				line = f.readline().replace('\n','')
				if not line:
					self.sqMap[ac] = sq
					self.sqMap.pop('')
					break
				if line[0] == '>':
					self.sqMap[ac] = sq
					ac = line.split('|')[1]
					sq = ''
				else:
					sq += line

	def unittest(self):
		ac1 = 'P0CX13'
		sq1 = 'MKENELKNEKSVDVLSFKQLESQKIVLPQDLFRSSFTWFCYEIYKSLAFRIWMLLWLPLSVWWKLSNNCIYPLIVSLLVLFLGPIFVLVICGLSRKRSLSKQLIQFCKEITENTPSSDPHDWEVVAANLNSYLYENNVWNTKYFFFNAMVCQEAFRTTLLEPFSLKKDKAAKVKSFKDSVPYIEEALGVYFTEVEKQWKLFNTEKSWSPVGLEDAKLPKEAYRFKLTWFLKRISNIFMLIPFLNFLCCIYVSRGMCLLLRTLYLGWILFMLVQGFQNIRVLIMSMEHKMQFLSTIINEQESGANGWDEIARKMNRYLFEKKAWKNEEFFFDGIDCEWFFNHFFYRVLSAKKSMWPLPLNVELWPYIKEAQLSRSEVLLV'
		ac2 = 'P40104'
		sq2 = 'MKVSDRRKFEKANFDEFESALNNKNDLVHCPSITLFESIPTEVRSFYEDEKSGLIKVVKFRTGAMDRKRSFEKIVISVMVGKNVQKFLTFVEDEPDFQGGPIPSNKPRDGLHVVSSAYFEIQ'
		assert self.sqMap[ac1]==sq1, 'Wrong value'
		assert self.sqMap[ac2]==sq2, 'Wrong value'
		print '[*] Pass unittest'

if __name__=='__main__':
	uniprot = Uniprot('uniprot_sprot.fasta')
	uniprot.unittest()
