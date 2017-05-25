#!/usr/bin/env python
# coding: utf-8
import math
import random

# Input:  A set of kmers Motifs
# Output: Count(Motifs)
def Count(Motifs):
    count = {}
    k = len(Motifs[0])
    for symbol in "ACGT":
        count[symbol] = []
        for j in range(k):
            count[symbol].append(0)

    t = len(Motifs)
    for i in range(t):
        for j in range(k):
            symbol = Motifs[i][j]
            count[symbol][j] += 1

    return count

# Input:  A list of kmers Motifs
# Output: the profile matrix of Motifs, as a dictionary of lists.
def Profile(Motifs):
    t = len(Motifs)
    k = len(Motifs[0])
    profile = Count(Motifs)

    for symbol in "ACGT":
        for j in range(k):
            profile[symbol][j] /= 1.0 * t

    return profile


# Input:  A set of kmers Motifs
# Output: A consensus string of Motifs.
def Consensus(Motifs):
    k = len(Motifs[0])
    count = Count(Motifs)
    consensus = ""
    for j in range(k):
        m = 0
        frequentSymbol = ""
        for symbol in "ACGT":
            if count[symbol][j] > m:
                m = count[symbol][j]
                frequentSymbol = symbol
        consensus += frequentSymbol
    return consensus


# Input:  A set of k-mers Motifs
# Output: The score of these k-mers.
def Score(Motifs):
    t = len(Motifs)
    k = len(Motifs[0])
    consensus = Consensus(Motifs)
    score = 0
    for i in range(t):
        for j in range(k):
            if Motifs[i][j] != consensus[j]:
                score += 1
    return score

# Input:  String Text and profile matrix Profile
# Output: Pr(Text, Profile)
def Pr(Text, Profile):
    p = 1
    for i in range(len(Text)):
        p *= Profile[Text[i]][i]
    return p

# Input:  String Text, an integer k, and profile matrix Profile
# Output: ProfileMostProbablePattern(Text, k, Profile)
def ProfileMostProbablePattern(Text, k, Profile):
    n = len(Text)
    m = 0
    pattern = Text[:k]
    for i in range(n - k + 1):
        p = Pr(Text[i:i+k], Profile)
        if p > m:
            m = p
            pattern = Text[i:i+k]
    return pattern

# Input:  A list of kmers Dna, and integers k and t (where t is the number of kmers in Dna)
# Output: GreedyMotifSearch(Dna, k, t)
def GreedyMotifSearch(Dna, k, t):
    BestMotifs = []
    for i in range(t):
        BestMotifs.append(Dna[i][:k])

    n = len(Dna[0])
    for i in range(n - k + 1):
        Motifs = []
        Motifs.append(Dna[0][i:i+k])
        for j in range(1, t):
            P = Profile(Motifs[0:j])
            Motifs.append(ProfileMostProbablePattern(Dna[j], k, P))

        if Score(Motifs) < Score(BestMotifs):
            BestMotifs = Motifs

    return BestMotifs


def EntropyScore(Motifs):
    t = len(Motifs)
    k = len(Motifs[0])
    profile = Profile(Motifs)
    score = 0
    for i in profile.keys():
        h = -sum([j * math.log(j, 2) for j in profile[i] if j > 0])
        score += h
    return score


# Input:  A set of kmers Motifs
# Output: CountWithPseudocounts(Motifs)
def CountWithPseudocounts(Motifs):
    t = len(Motifs)
    k = len(Motifs[0])
    count = {}

    for symbol in "ACGT":
        count[symbol] = []
        for j in range(k):
            count[symbol].append(1)

    for i in range(t):
        for j in range(k):
            symbol = Motifs[i][j]
            count[symbol][j] += 1

    return count

# Input:  A set of kmers Motifs
# Output: ProfileWithPseudocounts(Motifs)
def ProfileWithPseudocounts(Motifs):
    t = len(Motifs)
    k = len(Motifs[0])
    profile = CountWithPseudocounts(Motifs)

    for symbol in "ACGT":
        for j in range(k):
            profile[symbol][j] /= 4.0 + t

    return profile

# Input:  A list of kmers Dna, and integers k and t (where t is the number of kmers in Dna)
# Output: GreedyMotifSearch(Dna, k, t)
def GreedyMotifSearchWithPseudocounts(Dna, k, t):
    BestMotifs = []
    for i in range(t):
        BestMotifs.append(Dna[i][:k])

    n = len(Dna[0])
    for i in range(n - k + 1):
        Motifs = []
        Motifs.append(Dna[0][i:i+k])
        for j in range(1, t):
            P = ProfileWithPseudocounts(Motifs[0:j])
            Motifs.append(ProfileMostProbablePattern(Dna[j], k, P))

        if Score(Motifs) < Score(BestMotifs):
            BestMotifs = Motifs

    return BestMotifs

# Input:  A profile matrix Profile and a list of strings Dna
# Output: Motifs(Profile, Dna)
def Motifs(Profile, Dna):
    k = len(Profile['A'])
    m = []
    for d in Dna:
        m.append(ProfileMostProbablePattern(d, k, Profile))
    return m

# Input:  A list of strings Dna, and integers k and t
# Output: RandomMotifs(Dna, k, t)
# HINT:   You might not actually need to use t since t = len(Dna), but you may find it convenient
def RandomMotifs(Dna, k, t):
    n = len(Dna[0])
    motifs = []
    for d in Dna:
        i = random.randint(0, n - k)
        motifs.append(d[i:i+k])
    return motifs

# Input:  Positive integers k and t, followed by a list of strings Dna
# Output: RandomizedMotifSearch(Dna, k, t)
def RandomizedMotifSearch(Dna, k, t):
    M = RandomMotifs(Dna, k, t)
    BestMotifs = M

    while True:
        Profile = ProfileWithPseudocounts(M)
        M = Motifs(Profile, Dna)
        if Score(M) < Score(BestMotifs):
            BestMotifs = M
        else:
            return BestMotifs

def RepeatedRandomizedMotifSearch(Dna, k, t):
    BestScore = float('inf')
    BestMotifs = []
    for i in range(1000):
        Motifs = RandomizedMotifSearch(Dna, k, t)
        CurrScore = Score(Motifs)
        if CurrScore < BestScore:
            BestScore = CurrScore
            BestMotifs = Motifs
    return BestMotifs

# Input: A dictionary Probabilities, where keys are k-mers and values are the
# probabilities of these k-mers (which do not necessarily sum up to 1)
# Output: A normalized dictionary where the probability of each k-mer was
# divided by the sum of all k-mers' probabilities
def Normalize(Probabilities):
    total = sum([p for p in Probabilities.values()])
    for k in Probabilities:
        Probabilities[k] /= total
    return Probabilities

# Input:  A dictionary Probabilities whose keys are k-mers and whose values are
# the probabilities of these kmers
# Output: A randomly chosen k-mer with respect to the values in Probabilities
def WeightedDie(Probabilities):
    kmer = ''
    p = random.uniform(0, 1)
    for k, v in Probabilities.items():
        kmer = k
        if p - v > 0:
            p -= v
            continue
        else:
            break
    return kmer

# Input:  A string Text, a profile matrix Profile, and an integer k
# Output: ProfileGeneratedString(Text, profile, k)
def ProfileGeneratedString(Text, profile, k):
    n = len(Text)
    probabilities = {}
    for i in range(0,n-k+1):
        probabilities[Text[i:i+k]] = Pr(Text[i:i+k], profile)
    probabilities = Normalize(probabilities)
    return WeightedDie(probabilities)

# Input:  Integers k, t, and N, followed by a collection of strings Dna
# Output: GibbsSampler(Dna, k, t, N)
def GibbsSampler(Dna, k, t, N):
    BestMotifs = []
    Motifs = RandomMotifs(Dna, k, t)
    BestMotifs = Motifs
    for _ in range(N):
        i = random.randint(0,t-1)
        Profile = ProfileWithPseudocounts(Motifs[:i] + Motifs[i+1:])
        Motifs[i] = ProfileGeneratedString(Motifs[i], Profile, k)
        if Score(Motifs) < Score(BestMotifs):
            BestMotifs = Motifs
    return BestMotifs

def RepeatedGibbsSampler(Dna, k, t, N):
    BestScore = float('inf')
    BestMotifs = []
    for i in range(100):
        Motifs = GibbsSampler(Dna, k, t, N)
        CurrScore = Score(Motifs)
        if CurrScore < BestScore:
            BestScore = CurrScore
            BestMotifs = Motifs
    return BestMotifs
