#!/usr/bin/env python
# coding: utf-8

import itertools

CODONS = {
    'AAA': 'K', 'AAC': 'N', 'AAG': 'K', 'AAU': 'N',
    'ACA': 'T', 'ACC': 'T', 'ACG': 'T', 'ACU': 'T',
    'AGA': 'R', 'AGC': 'S', 'AGG': 'R', 'AGU': 'S',
    'AUA': 'I', 'AUC': 'I', 'AUG': 'M', 'AUU': 'I',
    'CAA': 'Q', 'CAC': 'H', 'CAG': 'Q', 'CAU': 'H',
    'CCA': 'P', 'CCC': 'P', 'CCG': 'P', 'CCU': 'P',
    'CGA': 'R', 'CGC': 'R', 'CGG': 'R', 'CGU': 'R',
    'CUA': 'L', 'CUC': 'L', 'CUG': 'L', 'CUU': 'L',
    'GAA': 'E', 'GAC': 'D', 'GAG': 'E', 'GAU': 'D',
    'GCA': 'A', 'GCC': 'A', 'GCG': 'A', 'GCU': 'A',
    'GGA': 'G', 'GGC': 'G', 'GGG': 'G', 'GGU': 'G',
    'GUA': 'V', 'GUC': 'V', 'GUG': 'V', 'GUU': 'V',
    'UAA': '', 'UAC': 'Y', 'UAG': '', 'UAU': 'Y',
    'UCA': 'S', 'UCC': 'S', 'UCG': 'S', 'UCU': 'S',
    'UGA': '', 'UGC': 'C', 'UGG': 'W', 'UGU': 'C',
    'UUA': 'L', 'UUC': 'F', 'UUG': 'L', 'UUU': 'F'
}

def RNA_translation(rna_string):
    protein = ''
    for i in range(0, len(rna_string), 3):
        codon = CODONS[rna_string[i:i+3]]
        if codon:
            protein += codon
        else:
            break
    return protein

# with open('dataset_96_4.txt','r') as f:
#     lines = f.read().splitlines()
#     print RNA_translation(lines[0])

def num_of_dna_to_protein(protein):
    v = CODONS.values()
    r = 1
    for p in protein:
        r *= v.count(p)
    return r

# print num_of_dna_to_protein('SYNGE')

def dna_complement(dna):
    map = {'A': 'T', 'T': 'A', 'C': 'G', 'G': 'C'}
    return ''.join([map[r] for r in dna])

def substring_peptide_encoding(dna_string, peptide):
    substring = []
    n = len(peptide)
    for i in range(len(dna_string) - n*3 + 1):
        dna = dna_string[i:i+n*3]
        reverse_complement_dna = dna_complement(dna)[::-1]
        rna = dna.replace('T', 'U')
        reverse_rna = reverse_complement_dna.replace('T', 'U')
        p1 = RNA_translation(rna)
        p2 = RNA_translation(reverse_rna)
        if peptide in [p1, p2]:
            substring.append(dna)
    return substring

# print substring_peptide_encoding('ATGGCCATGGCCCCCAGAACTGAGATCAATAGTACCCGTATTAACGGGTGA', 'MA')

# with open('dataset_96_7.txt','r') as f:
#     lines = f.read().splitlines()
#     dna_string = lines[0]
#     peptide = lines[1]
#     subs = substring_peptide_encoding(dna_string, peptide)
#     for s in subs:
#         print s

# with open('Bacillus_brevis.txt','r') as f:
#     lines = f.read().splitlines()
#     dna_string = ''.join(lines)
#     peptide = 'VKLFPWFNQY'
#     subs = substring_peptide_encoding(dna_string, peptide)
#     print len(subs)


AMINO_ACID_MASS = {
    'G': 57, 'A': 71, 'S': 87, 'P': 97, 'V': 99, 'T': 101, 
    'C': 103, 'I': 113, 'L': 113, 'N': 114, 'D': 115, 'K': 128, 
    'Q': 128, 'E': 129, 'M': 131, 'H': 137, 'F': 147, 'R': 156, 
    'Y': 163, 'W': 186
}

def linear_spectrum(peptide):
    prefixmass = [0]
    for i in range(len(peptide)):
        acid = peptide[i]
        prefixmass.append(prefixmass[-1] + AMINO_ACID_MASS[acid])
    
    l_spectrum = [0]
    for i in range(len(peptide)):
        for j in range(i+1, len(peptide)+1):
            l_spectrum.append(prefixmass[j] - prefixmass[i])
    return sorted(l_spectrum)

# ls = linear_spectrum('PIRRDVFSENRFCQADWNSMHRPYCEAYFMVIFSALRFMCFYPP')
# print ' '.join([str(i) for i in ls])

def cyclic_spectrum(peptide):
    prefixmass = [0]
    for i in range(len(peptide)):
        acid = peptide[i]
        prefixmass.append(prefixmass[-1] + AMINO_ACID_MASS[acid])
    
    peptide_mass = prefixmass[-1]
    c_spectrum = [0]
    for i in range(len(peptide)):
        for j in range(i+1, len(peptide)+1):
            c_spectrum.append(prefixmass[j] - prefixmass[i])
            if i > 0 and j < len(peptide):
                c_spectrum.append(peptide_mass - (prefixmass[j] - prefixmass[i]))
    return sorted(c_spectrum)

# cs = cyclic_spectrum('KICNVQVQYRWSPPR')
# print ' '.join([str(i) for i in cs])

# a = '0 71 101 113 131 184 202 214 232 285 303 315 345 416'
# b = ['TALM', 'TLAM', 'TMIA', 'TAIM', 'MAIT', 'MTAI']
# print a
# for i in b:
#     c = ' '.join([str(j) for j in cyclic_spectrum(i)])
#     print i, c == a


peptide_mass = [
    57, 71, 87, 97, 99, 101, 103, 113, 114, 115,
    128, 129, 131, 137, 147, 156, 163, 186
]
peptides = [
    'G','A','S','P','V','T','C','I/L','N',
    'D','K/Q','E','M','H','F','R','Y','W'
]

def all_peptides_with_mass(mass):
    result = []

    def peptides_with_mass(mass, i, comb):
        m = peptide_mass[i]
        if mass == 0:
            result.append(comb)
            return
        elif i == 0:
            if mass % m == 0:
                comb.append((peptides[i], mass / m))
                result.append(comb)
            return
        
        for n in range(mass / m + 1):
            tmp = comb[:]
            if n != 0:
                tmp.append((peptides[i], n))
            peptides_with_mass(mass - n * m, i - 1, tmp)

    peptides_with_mass(mass, len(peptide_mass) - 1, [])
    print 'peptides done'
    
    N = 0
    for r in result:
        iterm = []
        for i in r:
            iterm += [i[0]] * i[1]
        comb = list(set(itertools.permutations(iterm, len(iterm))))
        N += len(comb)
    print N

# all_peptides_with_mass(270)

peptides_count_table = {0:1}
def count_peptides_with_mass(m):
    if m in peptides_count_table: return peptides_count_table[m]
    if m < 0: return 0
    f = sum([count_peptides_with_mass(m - i) for i in peptide_mass])
    peptides_count_table[m] = f
    return f

# import math
# y2 = count_peptides_with_mass(1378)
# y1 = count_peptides_with_mass(1024)
# print (1. * y2 / y1) ** (1./ (1379 - 1024))

def num_subpeptides_of_linear_peptide(n):
    return (n + 1) * n / 2 + 1

# print num_subpeptides_of_linear_peptide(22951)

def linear_spectrum_by_mass(peptide):
    prefixmass = [0]
    for i in peptide:
        prefixmass.append(prefixmass[-1] + i)
    
    l_spectrum = [0]
    for i in range(len(peptide)):
        for j in range(i+1, len(peptide)+1):
            l_spectrum.append(prefixmass[j] - prefixmass[i])
    return sorted(l_spectrum)

def cyclic_spectrum_by_mass(peptide):
    prefixmass = [0]
    for i in peptide:
        prefixmass.append(prefixmass[-1] + i)
    
    peptide_mass = prefixmass[-1]
    c_spectrum = [0]
    for i in range(len(peptide)):
        for j in range(i+1, len(peptide)+1):
            c_spectrum.append(prefixmass[j] - prefixmass[i])
            if i > 0 and j < len(peptide):
                c_spectrum.append(peptide_mass - (prefixmass[j] - prefixmass[i]))
    return sorted(c_spectrum)


def cyclo_peptide_sequencing(spectrum):
    peptides = [[]]

    def expand(peps):
        peps_exp = []
        for p in peps:
            for a in peptide_mass[::-1]:
                peps_exp.append(p + [a])
        return peps_exp

    def consistent(peps1, peps2):
        for p in peps1:
            if p not in peps2:
                return False
        return True

    result = []
    while len(peptides) > 0:
        peptides = expand(peptides)

        del_peps = []
        for p in peptides:
            if sum(p) == spectrum[-1]:
                if cyclic_spectrum_by_mass(p) == spectrum:
                    result.append(p)
                del_peps.append(p)
            elif sum(p) > spectrum[-1]:
                del_peps.append(p)
            elif not consistent(linear_spectrum_by_mass(p), spectrum):
                del_peps.append(p)

        for p in del_peps: peptides.remove(p)

    return result

# spectrum = [0, 113, 128, 186, 241, 299, 314, 427]
# result = cyclo_peptide_sequencing(spectrum)
# print ' '.join(['-'.join([str(i) for i in r]) for r in result])

# with open('dataset_100_6.txt' ,'r') as f:
#     lines = f.read().splitlines()
#     ns = lines[0].split(' ')
#     spectrum = [int(n) for n in ns]
#     result = cyclo_peptide_sequencing(spectrum)
#     print ' '.join(['-'.join([str(i) for i in r]) for r in result])

# spectrum = [
#     0, 71, 99, 101, 103, 128, 129, 199, 200, 204,
#     227, 230, 231, 298, 303, 328, 330, 332, 333
# ]
# b = ['CTV', 'QCV', 'VAQ', 'TCA', 'AQV', 'TCE']
# for i in b:
#     print i, consistent(linear_spectrum(i), spectrum)


def cyclopeptide_score(peptide, spectrum):
    dict1 = {}
    dict2 = {}
    score = 0
    if peptide != '' or peptide != []:
        if type(peptide) == str:
            c_spectrum = cyclic_spectrum(peptide)
        elif type(peptide) == list:
            c_spectrum = cyclic_spectrum_by_mass(peptide)
        for i in c_spectrum:
            if i in dict1: dict1[i] += 1
            else: dict1[i] = 1
        for i in spectrum:
            if i in dict2: dict2[i] += 1
            else: dict2[i] = 1
        for i in dict1.keys():
            if i in dict2:
                score += min(dict1[i], dict2[i])
    return score

# spectrum = [0, 99, 113, 114, 128, 227, 257, 299, 355, 356, 370, 371, 484]
# print cyclopeptide_score('NQEL', spectrum)

# with open('dataset_102_3.txt', 'r') as f:
#     lines = f.read().splitlines()
#     peptide = lines[0]
#     spectrum = [int(i) for i in lines[1].split(' ')]
#     print cyclopeptide_score(peptide, spectrum)

def linear_score(peptide, spectrum):
    dict1 = {}
    dict2 = {}
    score = 0
    if peptide != '' or peptide != []:
        if type(peptide) == str:
            l_spectrum = linear_spectrum(peptide)
        elif type(peptide) == list:
            l_spectrum = linear_spectrum_by_mass(peptide)
        for i in l_spectrum:
            if i in dict1: dict1[i] += 1
            else: dict1[i] = 1
        for i in spectrum:
            if i in dict2: dict2[i] += 1
            else: dict2[i] = 1
        for i in dict1.keys():
            if i in dict2:
                score += min(dict1[i], dict2[i])
    return score

# print linear_score('NQEL', [0,99,113,114,128,227,257,299,355,356,370,371,484])
# with open('dataset_4913_1.txt', 'r') as f:
#     lines = f.read().splitlines()
#     peptide = lines[0]
#     spectrum = [int(i) for i in lines[1].split(' ')]
#     print linear_score(peptide, spectrum)

def trim(leaderboard, spectrum, N):
    leaderboard_score = []
    for i in leaderboard:
        score = linear_score(i, spectrum)
        leaderboard_score.append((score, i))
    leaderboard_score.sort()
    leaderboard_score.reverse()
    for i in range(N, len(leaderboard)):
        if leaderboard_score[i][0] < leaderboard_score[N-1][0]:
            return [j[1] for j in leaderboard_score[:i]]
    return [j[1] for j in leaderboard_score]

# leaderboard = ['LAST', 'ALST', 'TLLT', 'TQAS']
# spectrum = [0, 71, 87, 101, 113, 158, 184, 188, 259, 271, 372]
# N = 2
# print trim(leaderboard, spectrum, N)

# with open('dataset_4913_3.txt', 'r') as f:
#     lines = f.read().splitlines()
#     leaderboard = lines[0].split(' ')
#     spectrum = [int(i) for i in lines[1].split(' ')]
#     N = int(lines[2])
#     print ' '.join(trim(leaderboard, spectrum, N))

def leaderboard_cyclo_peptide_sequencing(spectrum, N):
    leaderboard = [[]]
    leaderpeptide = []
    max_leader_score = 0

    def expand(peps):
        peps_exp = []
        for p in peps:
            # for a in peptide_mass[::-1]:
            for a in range(57,201):
                peps_exp.append(p + [a])
        return peps_exp

    while len(leaderboard) > 0:
        leaderboard = expand(leaderboard)

        del_peps = []
        for p in leaderboard:
            if sum(p) == spectrum[-1]:
                score = cyclopeptide_score(p, spectrum)
                if score > max_leader_score:
                    max_leader_score = score
                    leaderpeptide = [p]
                elif score == max_leader_score:
                    leaderpeptide.append(p)
            elif sum(p) > spectrum[-1]:
                del_peps.append(p)

        for p in del_peps: leaderboard.remove(p)
        leaderboard = trim(leaderboard, spectrum, N)

    return leaderpeptide

def reduce_leaderpeptide_redundance(leaderpeptide):
    unique = []
    tmp = []
    for p in leaderpeptide:
        sp = [str(i) for i in p]
        s = '-'.join(sp)
        if s not in tmp:
            tmp.append(s)
            unique.append(s)
            for i in range(1,len(p)):
                pre = '-'.join(sp[:i])
                suf = '-'.join(sp[i:])
                tmp.append(suf+'-'+pre)
    return unique


# N = 10
# spectrum = [0, 71, 113, 129, 147, 200, 218, 260, 313, 331, 347, 389, 460]
# result = leaderboard_cyclo_peptide_sequencing(spectrum, N)
# print ' '.join(['-'.join([str(i) for i in r]) for r in result])

# with open('dataset_102_8.txt', 'r') as f:
#     lines = f.read().splitlines()
#     N = int(lines[0])
#     spectrum = [int(i) for i in lines[1].split(' ')]
#     result = leaderboard_cyclo_peptide_sequencing(spectrum, N)
#     print '-'.join([str(r) for r in result])

# spectrum25 = '0 97 99 113 114 115 128 128 147 147 163 186 227 241 242 244 244 256 260 261 262 283 291 309 330 333 340 347 385 388 389 390 390 405 435 447 485 487 503 504 518 544 552 575 577 584 599 608 631 632 650 651 653 672 690 691 717 738 745 770 779 804 818 819 827 835 837 875 892 892 917 932 932 933 934 965 982 989 1039 1060 1062 1078 1080 1081 1095 1136 1159 1175 1175 1194 1194 1208 1209 1223 1322'
# spectrum = [int(i) for i in spectrum25.split(' ')]
# N = 1000
# result = leaderboard_cyclo_peptide_sequencing(spectrum, N)
# print ' '.join(['-'.join([str(i) for i in r]) for r in result])

# spectrum10 = '0 97 99 114 128 147 147 163 186 227 241 242 244 260 261 262 283 291 333 340 357 385 389 390 390 405 430 430 447 485 487 503 504 518 543 544 552 575 577 584 632 650 651 671 672 690 691 738 745 747 770 778 779 804 818 819 820 835 837 875 892 917 932 932 933 934 965 982 989 1030 1039 1060 1061 1062 1078 1080 1081 1095 1136 1159 1175 1175 1194 1194 1208 1209 1223 1225 1322'
# spectrum = [int(i) for i in spectrum10.split(' ')]
# N = 1000
# result = leaderboard_cyclo_peptide_sequencing(spectrum, N)
# print ' '.join(['-'.join([str(i) for i in r]) for r in result])

def convolution(spectrum):
    spect = sorted(spectrum)
    conv = []
    for i in range(len(spect)):
        m = spect[i]
        for j in range(i):
            n = m - spect[j]
            if n != 0:
                conv.append(n)
    return sorted(conv)

# spectrum = [0, 137, 186, 323]
# r = convolution(spectrum)
# print ' '.join([str(i) for i in r])

# with open('dataset_104_4.txt', 'r') as f:
#     lines = f.read().splitlines()
#     spectrum = [int(i) for i in lines[0].split(' ')]
#     r = convolution(spectrum)
#     print ' '.join([str(i) for i in r])

def top_convolution(spectrum, M):
    conv = convolution(spectrum)
    conv.append(0)
    conv_count = []

    i = 0
    mass = 0
    count = 0
    while i != len(conv):
        m = conv[i]
        if mass != m:
            if mass >= 57 and mass <= 200:
                conv_count.append((count, mass))
            mass = m
            count = 0
        count += 1
        i += 1

    conv_count.sort()
    conv_count.reverse()
    print conv_count
    top_conv = conv_count[:M]

    n = top_conv[-1][0]
    for i in range(M, len(conv_count)):
        if n == conv_count[i][0]:
            top_conv.append(conv_count[i])
        else:
            break

    return [i[1] for i in top_conv]

def convolution_cyclo_peptide_sequencing(spectrum, M, N):
    spectrum = sorted(spectrum)
    leaderboard = [[]]
    leaderpeptide = []
    max_leader_score = 0
    top_conv = top_convolution(spectrum, M)

    def expand(peps):
        peps_exp = []
        for p in peps:
            for a in top_conv:
                peps_exp.append(p + [a])
        return peps_exp

    while len(leaderboard) > 0:
        leaderboard = expand(leaderboard)

        del_peps = []
        for p in leaderboard:
            if sum(p) == spectrum[-1]:
                score = cyclopeptide_score(p, spectrum)
                if score > max_leader_score:
                    max_leader_score = score
                    leaderpeptide = [p]
                elif score == max_leader_score:
                    leaderpeptide.append(p)
            elif sum(p) > spectrum[-1]:
                del_peps.append(p)

        for p in del_peps: leaderboard.remove(p)
        leaderboard = trim(leaderboard, spectrum, N)

    return leaderpeptide

# M = 20
# N = 60
# spectrum = [57, 57, 71, 99, 129, 137, 170, 186, 194, 208, 228, 265, 285, 299, 307, 323, 356, 364, 394, 422, 493]
# result = convolution_cyclo_peptide_sequencing(spectrum, M, N)
# print reduce_leaderpeptide_redundance(result)

# with open('dataset_104_7.txt', 'r') as f:
#     lines = f.read().splitlines()
#     M = int(lines[0])
#     N = int(lines[1])
#     spectrum = [int(i) for i in lines[2].split(' ')]
#     result = convolution_cyclo_peptide_sequencing(spectrum, M, N)
#     print reduce_leaderpeptide_redundance(result)

# with open('dataset_104_8.txt', 'r') as f:
#     lines = f.read().splitlines()
#     M = int(lines[0])
#     N = int(lines[1])
#     spectrum = [int(i) for i in lines[2].split(' ')]
#     result = convolution_cyclo_peptide_sequencing(spectrum, M, N)
#     print ' '.join(['-'.join([str(i) for i in r]) for r in result])

# real_spectrum = [
#     371.5, 375.4, 390.4, 392.2, 409.0, 420.2, 427.2, 443.3, 446.4, 
#     461.3, 471.4, 477.4, 491.3, 505.3, 506.4, 519.2, 536.1, 546.5, 
#     553.3, 562.3, 588.2, 600.3, 616.2, 617.4, 618.3, 633.4, 634.4, 
#     636.2, 651.5, 652.4, 702.5, 703.4, 712.5, 718.3, 721.0, 730.3, 
#     749.4, 762.6, 763.4, 764.4, 779.6, 780.4, 781.4, 782.4, 797.3, 
#     862.4, 876.4, 877.4, 878.6, 879.4, 893.4, 894.4, 895.4, 896.5, 
#     927.4, 944.4, 975.5, 976.5, 977.4, 979.4, 1005.5, 1007.5, 1022.5, 
#     1023.7, 1024.5, 1039.5, 1040.3, 1042.5, 1043.4, 1057.5, 1119.6, 
#     1120.6, 1137.6, 1138.6, 1139.5, 1156.5, 1157.6, 1168.6, 1171.6, 
#     1185.4, 1220.6, 1222.5, 1223.6, 1239.6, 1240.6, 1250.5, 1256.5, 
#     1266.5, 1267.5, 1268.6
# ]
# spectrum = [int(i) - 1 for i in real_spectrum]
# M = 20
# N = 1000
# result = convolution_cyclo_peptide_sequencing(spectrum, M, N)
# print reduce_leaderpeptide_redundance(result)





