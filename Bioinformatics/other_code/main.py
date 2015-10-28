#!/usr/bin/env python

from AAIndex import AAIndex1
from Uniprot import Uniprot
from Traindata import Traindata

if __name__=='__main__':
	aaindex1 = AAIndex1('../db/aaindex1.txt')
	uniprot = Uniprot('../db/uniprot_sprot.fasta')
	# set training data
	traindata = Traindata()
	traindata.load_intm('../db/yeast.db.all.200908.intm', True)
	traindata.load_intm('../db/human.db.all.201008.intm', True)
	traindata.load_intm('../db/human.db.all.201108-201008.intm', True)
	traindata.load_txt('../db/combined.txt', False)
	traindata.load_mitab('../db/18509523_neg.mitab', False)
	traindata.KCV(10)
	traindata.done()
