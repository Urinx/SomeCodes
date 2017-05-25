#!/usr/bin/env python
# coding: utf-8

import time
import datetime
from guppy import hpy

GLOBAL_START_TIME = time.time()
GLOBAL_TEMPORARY_TIME = GLOBAL_START_TIME

def time_cost():
    global GLOBAL_TEMPORARY_TIME
    now = time.time()
    totalTime = now - GLOBAL_TEMPORARY_TIME
    GLOBAL_TEMPORARY_TIME = now
    t = datetime.timedelta(seconds=totalTime)
    return t

# Copy your PatternCount function from the previous step below this line
def PatternCount(Pattern, Text):
    count = 0
    for i in range(len(Text)-len(Pattern)+1):
        if Text[i:i+len(Pattern)] == Pattern:
            count += 1
    return count

# Input:  A string Text and an integer k
# Output: CountDict(Text, k)
def CountDict(Text, k):
    Count = {}
    for i in range(len(Text) - k + 1):
        Pattern = Text[i:i+k]
        Count[i] = PatternCount(Pattern, Text)
    return Count

# Input:  A list Items
# Output: A list containing all objects from Items without duplicates
def remove_duplicates(Items):
    ItemsNoDuplicates = list(set(Items))
    return ItemsNoDuplicates

# Input:  A string Text and an integer k
# Output: A list containing all most frequent k-mers in Text
def FrequentWords(Text, k):
    FrequentPatterns = [] # output variable
    Count = CountDict(Text, k)
    m = max(Count.values())
    for i in Count:
        if Count[i] == m:
            FrequentPatterns.append(Text[i:i+k])
    FrequentPatternsNoDuplicates = remove_duplicates(FrequentPatterns)
    return FrequentPatternsNoDuplicates

# Input:  A DNA string Pattern
# Output: The reverse complement of Pattern
def ReverseComplement(Pattern):
    revComp = '' # output variable
    for i in Pattern:
        revComp += complement(i)
    return revComp[::-1]

# Input:  A character Nucleotide
# Output: The complement of Nucleotide
def complement(Nucleotide):
    comp = {'A': 'T', 'C': 'G', 'G': 'C', 'T': 'A'}
    return comp[Nucleotide]

# Input:  Two strings, Pattern and Genome
# Output: A list containing all starting positions where Pattern appears as a substring of Genome
def PatternMatching(Pattern, Genome):
    positions = [] # output variable
    for i in range(len(Genome) - len(Pattern) + 1):
        if Genome[i:i+len(Pattern)] == Pattern:
            positions.append(i)
    return positions

# Input:  Strings Genome and symbol
# Output: SymbolArray(Genome, symbol)
def SymbolArray1(Genome, symbol):
    # MemoryError, limited in 512 MB,
    # this method take too much memory space
    # but time cost 3s
    array = {}
    n = len(Genome)
    l = n // 2
    ExtendedGenome = Genome + Genome[:l]
    symbolArr = [1 if c == 'C' else 0 for c in ExtendedGenome]
    array[0] = sum(symbolArr[:l])
    for i in range(1, n):
        array[i] = array[i-1] - symbolArr[i-1] + symbolArr[i+l-1]
    return array


def SymbolArray2(Genome, symbol):
    array = {}
    n = len(Genome)
    l = n // 2
    array[0] = sum([1 if c == symbol else 0 for c in Genome[:l]])
    for i in range(1, n):
        a = 1 if Genome[i-1] == symbol else 0
        b = 1 if Genome[(i+l-1) % n] == symbol else 0
        array[i] = array[i-1] - a + b
    return array

def FssterSymbolArray(Genome, symbol):
    array = {}
    n = len(Genome)
    ExtendedGenome = Genome + Genome[0:n//2]
    array[0] = PatternCount(symbol, Genome[0:n//2])
    for i in range(1,n):
        array[i] = array[i-1]
        if ExtendedGenome[i-1] == symbol:
            array[i] = array[i] - 1
        if ExtendedGenome[i+(n//2)-1] == symbol:
            array[i] = array[i] + 1
    return array

# Input:  A String Genome
# Output: Skew(Genome)
def Skew(Genome):
    skew = {} #initializing the dictionary
    skew[0] = 0
    for i in range(len(Genome)):
        a = 0
        if Genome[i] == 'G':
            a =  1
        elif Genome[i] == 'C':
            a = -1
        skew[i+1] = skew[i] + a
    return skew

# Input:  A DNA string Genome
# Output: A list containing all integers i minimizing Skew(Prefix_i(Text)) over all values of i (from 0 to |Genome|)
def MinimumSkew(Genome):
    positions = [] # output variable
    genome_skew = Skew(Genome)
    m = min(genome_skew.values())
    for i in genome_skew:
        if genome_skew[i] == m:
            positions.append(i)
    return positions

# Input:  Two strings p and q
# Output: An integer value representing the Hamming Distance between p and q.
def HammingDistance(p, q):
    n = len(p)
    mismatch = 0
    for i in range(n):
        if p[i] != q[i]:
            mismatch += 1
    return mismatch

# Input:  Strings Pattern and Text along with an integer d
# Output: A list containing all starting positions where Pattern appears
# as a substring of Text with at most d mismatches
def ApproximatePatternMatching(Pattern, Text, d):
    positions = [] # initializing list of positions
    n = len(Pattern)
    for i in range(len(Text) - n + 1):
        if HammingDistance(Pattern, Text[i:i+n]) <= d:
            positions.append(i)
    return positions

# Input:  Strings Pattern and Text, and an integer d
# Output: The number of times Pattern appears in Text with at most d mismatches
def ApproximatePatternCount(Pattern, Text, d):
    count = 0 # initialize count variable
    n = len(Pattern)
    for i in range(len(Text) - n + 1):
        if HammingDistance(Pattern, Text[i:i+n]) <= d:
            count += 1
    return count

# Now, set Text equal to the ori of Vibrio cholerae and Pattern equal to "TGATCA"
ori = """
ATCAATGATCAACGTAAGCTTCTAAGCATGATCAAGGTGCTCACACAGTTTATCCACAACCTGAGTGGATGACA
TCAAGATAGGTCGTTGTATCTCCTTCCTCTCGTACTCTCATGACCACGGAAAGATGATCAAGAGAGGATGATTT
CTTGGCCATATCGCAATGAATACTTGTGACTTGTGCTTCCAATTGACATCTTCAGCGCCATATTGCGCTGGCCA
AGGTGACGGAGCGGGATTACGAAAGCATGATCATGGCTGTTGTTCTGTTTATCTTGTTTTGACTGAGACTTGTT
AGGATAGACGGTTTTTCATCACTGACTAGCCAAAGCCTTACTCTGCCTGACATCGACCGTAAATTGATAATGAA
TTTACATGCTTCCGCGACGATTTACCTCTTGATCATCGATCCGATTGAAGATCTTCAATTGTTAATTCTCTTGC
CTCGACTCATAGCCATGATGAGCTCTTGATCATGTTTCCTTAACCCTCTATTTTTTACGGAAGAATGATCAAGC
TGCTGCTCTTGATCATCGTTTC
"""
pattern = 'TGATCA'

# Finally, print the result of calling PatternCount on Text and Pattern.
# Don't forget to use the notation print() with parentheses included!

# print(PatternCount(pattern, ori))
# print(FrequentWords('TAAACGTGAGAGAAACGTGCTGATTACACTTGTTCGTGTGGTAT', 3))
# print PatternCount('TGT','ACTGTACGATGATGTGTGTCAAAG')
# print ReverseComplement('TTGTGTC')

# e_coli = ''
# with open('E_coli.txt') as f:
#     e_coli = f.read().strip()

# print time_cost()

# FssterSymbolArray(e_coli, 'C')
# print time_cost()
# h = hpy()
# print h.heap()

# Pattern = 'ATTCTGGA'
# Text = 'CGCCCGAATCCAGAACGCATTCCCATATTTCGGGACCACTGGCCTCCACGGTACGGACGTCAATCAAAT'
# print ApproximatePatternMatching(Pattern, Text, 3)




