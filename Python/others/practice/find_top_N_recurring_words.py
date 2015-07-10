#!/usr/bin/python3

from collections import Counter

def find_top_N_recurring_words(seq,N):
	dcounter=Counter()
	for word in seq.split():
		dcounter[word]+=1
	return dcounter.most_common(N)

def test_find_top_N_recurring_words(module_name="this module"):
	seq="buffy angel monster xrander a willow gg buffy the monster super buffy angel"
	N=3
	assert(find_top_N_recurring_words(seq,N) == [('buffy',3),('monster',2),('angel',2)])
	s='Tests in {name} have {con}!'
	print(s.format(name=module_name,con='passed'))

if __name__=='__main__':
	test_find_top_N_recurring_words()