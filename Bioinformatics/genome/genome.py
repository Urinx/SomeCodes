#!/usr/bin/env python
# coding: utf-8
import numpy as np
from utils import *

def composition(text, k):
    arr = []
    for i in range(len(text) - k + 1):
        arr.append(text[i:i+k])
    return sorted(arr)

### DO NOT MODIFY THE CODE BELOW THIS LINE ###
# import sys
# lines = sys.stdin.read().splitlines()

# with open('dataset_197_3-2.txt', 'r') as f:
#     lines = f.readlines()
#     k = int(lines[0])
#     text = lines[1]
#     arr = composition(text, k)

#     f2 = open('2.txt','w+')
#     for i in arr:
#         f2.write(i+'\n')


# with open('dataset_198_3.txt', 'r') as f:
#     lines = f.readlines()
#     seq = lines[0].strip()
#     for line in lines[1:]:
#         seq += line.strip()[-1]
# print seq

def adjacency_list(seq_arr):
    adjacency_dict = {}
    for a in seq_arr:
        tmp = []
        for b in seq_arr:
            if a[1:] == b[:-1]:
                tmp.append(b)
        if len(tmp) != 0:
            adjacency_dict[a] = tmp
    return adjacency_dict

# with open('dataset_198_10.txt', 'r') as f:
#     seq_arr = []
#     for line in f:
#         seq_arr.append(line.strip())
#     adjacency_dict = adjacency_list(seq_arr)

#     f2 = open('result.txt', 'w')
#     for k,v in adjacency_dict.items():
#         f2.write(k+' -> '+', '.join(v)+'\n')
#     f2.close()


import itertools
def k_universal_string(k):
    binary_string = []
    for i in itertools.product([0,1], repeat=k):
        binary_string.append(reduce(lambda a,b: str(a)+str(b), i))

    result = []
    find_k_u_s('', binary_string, k, result)
    print len(result)

def find_k_u_s(s, arr, k, r):
    if len(arr) == 0:
        # print s
        r.append(s)
    if not s:
        for s_a in arr:
            arr_left = arr[:]
            arr_left.remove(s_a)
            # print s_a, arr_left
            find_k_u_s(s_a, arr_left, k, r)
    else:
        for i in range(len(arr)):
            if s[-k+1:] == arr[i][:-1]:
                s_a = s + arr[i][-1]
                arr_left = arr[:i] + arr[i+1:]
                # print s_a, arr_left
                find_k_u_s(s_a, arr_left, k, r)

# k_universal_string(4)

def adjacency_matrix_to_list(graph):
    adjacency_list = {}
    nodes = graph['nodes']
    mat = graph['adjacency_matrix']
    n = len(nodes)
    for i in range(n):
        node = nodes[i]
        tmp = []
        for j in range(n):
            if mat[i][j] >= 1:
                tmp += [nodes[j]] * mat[i][j]
        if tmp:
            if node not in adjacency_list:
                adjacency_list[node] = tmp
            else:
                adjacency_list[node] += tmp
    return adjacency_list

def print_adjacency_matrix(graph):
    nodes = graph['nodes']
    mat = graph['adjacency_matrix']
    k = len(nodes[0])
    foo = lambda a,b: str(a) + str(b).rjust(k+1)
    print ' '*(k+1) + ' '.join(nodes)
    for i in range(len(nodes)):
        print nodes[i] + ' '*k + reduce(foo, mat[i])

def print_adjacency_list(graph):
    a_list = graph['adjacency_list']
    for k,v in sorted(a_list.items()):
        if len(v) > 0:
            print k, '->', ', '.join(v)

def PathGraph(text, k):
    edges = [text[i:i+k] for i in range(len(text)-k+1)]
    nodes = [e[:-1] for e in edges] + [edges[-1][1:]]
    n = len(nodes)
    path_graph = {
        'edges': edges,
        'nodes': nodes,
        'adjacency_matrix': [[0] * n for i in range(n)],
        'adjacency_list': {}
    }

    for i in range(n-1):
        path_graph['adjacency_matrix'][i][i+1] = 1

    a_list = adjacency_matrix_to_list(path_graph)
    path_graph['adjacency_list'] = a_list

    # print_adjacency_matrix(path_graph)
    # print_adjacency_list(path_graph)

    return path_graph

def DeBruijn(text, k):
    path_graph = PathGraph(text, k)
    a_list = path_graph['adjacency_list']
    de_bruijn_graph = {
        'edges': path_graph['edges'],
        'nodes': [],
        'adjacency_matrix': [],
        'adjacency_list': a_list
    }
    
    nodes = a_list.keys()
    nodes = [i[1] for i in sorted([(path_graph['nodes'].index(n), n) for n in nodes])]
    nodes.append(path_graph['nodes'][-1])

    de_bruijn_graph['nodes'] = nodes
    n = len(nodes)
    mat = [[0] * n for i in range(n)]
    for i in range(n-1):
        node = nodes[i]
        for b in a_list[node]:
            j = nodes.index(b)
            mat[i][j] += 1
    de_bruijn_graph['adjacency_matrix'] = mat
    # print_adjacency_matrix(de_bruijn_graph)

    return de_bruijn_graph


# DeBruijn('AAGATTCTCTAAGA', 4)
# DeBruijn('TAATGCCATGGGATGTT', 3)

# patterns = ['GCGA','CAAG','AAGA','GCCG','ACAA','AGTA',
# 'TAGG','AGTA','ACGT','AGCC','TTCG','AGTT','AGTA','CGTA',
# 'GCGC','GCGA','GGTC','GCAT','AAGC','TAGA','ACAG','TAGA',
# 'TCCT','CCCC','GCGC','ATCC','AGTA','AAGA','GCGA','CGTA']
# DeBruijn(patterns)

# with open('dataset_200_8.txt', 'r') as f:
#     patterns = []
#     for line in f:
#         patterns.append(line.strip())
#     DeBruijn(patterns)

import random
import copy

def eulerian_cycle(graph):
    a_list = copy.deepcopy(graph['adjacency_list'])
    edge_count = graph['edge_count']
    nodes = graph['nodes']

    circle = nodes[:1]
    while len(circle) - 1 != edge_count:
        for i in range(len(circle)):
            n = circle[i]
            if len(a_list[n]) > 0:
                tmp = []
                while 1:
                    tmp.append(n)
                    if len(a_list[n]) > 0:
                        n = a_list[n].pop()
                    else:
                        break
                circle = circle[:i] + tmp + circle[i+1:]
                break

    return circle

def adjacency_list_to_graph(adjacency_strs):
    nodes = []
    a_list = {}
    edge_count = 0
    degress = {}
    for line in adjacency_strs:
        k, v = line.split(' -> ')
        nodes.append(k)
        a_list[k] = v.split(',')
        edge_count += len(a_list[k])

        if k in degress:
            degress[k]['outdegress'] += len(a_list[k])
        else:
            degress[k] = {
                'outdegress': len(a_list[k]),
                'indegress': 0
            }

        for i in a_list[k]:
            if i in degress:
                degress[i]['indegress'] += 1
            else:
                degress[i] = {
                    'outdegress': 0,
                    'indegress': 1
                }


    graph = {
        'edge_count': edge_count,
        'nodes': nodes,
        'adjacency_list': a_list,
        'degress': degress,
    }

    return graph

# sample_input = ['0 -> 3', '1 -> 0', '2 -> 1,6', '3 -> 2', '4 -> 2', '5 -> 4', '6 -> 5,8', '7 -> 9', '8 -> 7', '9 -> 6']
# graph = adjacency_list_to_graph(sample_input)
# print '->'.join(eulerian_cycle(graph))

def eulerian_path(graph):
    a_list = copy.deepcopy(graph['adjacency_list'])
    edge_count = graph['edge_count']
    nodes = graph['nodes']
    degress = graph['degress']

    # the outdegress of start node greater than its indegress by 1
    path = []
    for n in a_list.keys():
        if degress[n]['outdegress'] - degress[n]['indegress'] == 1:
            path = [n]
            break
    while len(path) - 1 != edge_count:
        for i in range(len(path)):
            n = path[i]
            if n in a_list and len(a_list[n]) > 0:
                tmp = []
                while 1:
                    tmp.append(n)
                    if n in a_list and len(a_list[n]) > 0:
                        j = random.randint(0, len(a_list[n]) - 1)
                        n = a_list[n].pop(j)
                    else:
                        break
                path = path[:i] + tmp + path[i+1:]
                break

    return path

# sample_input = ['0 -> 2','1 -> 3','2 -> 1','3 -> 0,4','6 -> 3,7','7 -> 8','8 -> 9','9 -> 6']

# with open('dataset_203_6.txt','r') as f:
#     sample_input = f.read().splitlines()
#     graph = adjacency_list_to_graph(sample_input)
#     print '->'.join(eulerian_path(graph))

def DeBruijn(patterns):
    k = len(patterns[0])
    nodes = sorted(list(set([kmer[:-1] for kmer in patterns] + [kmer[1:] for kmer in patterns])))
    n = len(nodes)

    de_bruijn_graph = {
        'edges': patterns,
        'edge_count': len(patterns),
        'nodes': nodes,
        'adjacency_matrix': [[0] * n for i in range(n)],
        'adjacency_list': {},
        'degress': {}
    }

    for kmer in patterns:
        prefix = kmer[:-1]
        suffix = kmer[1:]
        i = nodes.index(prefix)
        j = nodes.index(suffix)
        de_bruijn_graph['adjacency_matrix'][i][j] += 1


    a_list = adjacency_matrix_to_list(de_bruijn_graph)
    de_bruijn_graph['adjacency_list'] = a_list

    for i in range(n):
        de_bruijn_graph['degress'][nodes[i]] = {
            'outdegress': sum(de_bruijn_graph['adjacency_matrix'][i]),
            'indegress': sum([de_bruijn_graph['adjacency_matrix'][j][i] for j in range(n)]),
        }

    # print_adjacency_matrix(de_bruijn_graph)
    # print_adjacency_list(de_bruijn_graph)

    return de_bruijn_graph

# patterns = ['CTTA','ACCA','TACC','GGCT','GCTT','TTAC']

# with open('dataset_203_7.txt', 'r') as f:
#     patterns = f.read().splitlines()
#     patterns.pop(0)
#     de_bruijn_graph = DeBruijn(patterns)
#     print reduce(lambda a,b: a+b[-1], eulerian_path(de_bruijn_graph))

def k_universal_circular_string(k):
    binary_strings = []
    for i in itertools.product([0,1], repeat=k):
        binary_strings.append(reduce(lambda a,b: str(a)+str(b), i))

    de_bruijn_graph = DeBruijn(binary_strings)
    circle = eulerian_cycle(de_bruijn_graph)
    kmers = [circle[i]+circle[i+1][-1] for i in range(len(circle)-1)]
    print reduce(lambda a,b: a+b[-1], kmers)[:-k+1]

# k_universal_circular_string(8)


def paired_composition(text, k, d):
    pair_comp = []
    l = 2*k+d
    for i in range(len(text) - l + 1):
        pair_comp.append(text[i:i+k] + '|' + text[i+k+d:i+l])
    return pair_comp

# print ', '.join(sorted(paired_composition('TAATGCCATGGGATGTT', 3, 2)))

def StringSpelledByGappedPatterns(gapped_patterns, k, d):
    prefix_patterns = []
    suffix_patterns = []
    for kmer in gapped_patterns:
        p, s = kmer.split('|')
        prefix_patterns.append(p)
        suffix_patterns.append(s)
    prefix_string = reduce(lambda a,b: a+b[-1], prefix_patterns)
    suffix_string = reduce(lambda a,b: a+b[-1], suffix_patterns)
    if prefix_string[k+d:] == suffix_string[:-k-d]:
        return prefix_string + suffix_string[-k-d:]
    else:
        return "there is no string spelled by the gapped patterns"

# gapped_patterns = ['GACC|GCGC','ACCG|CGCC','CCGA|GCCG','CGAG|CCGG','GAGC|CGGA']
# print StringSpelledByGappedPatterns(gapped_patterns, 4, 2)

# with open('dataset_6206_7.txt', 'r') as f:
#     lines = f.read().splitlines()
#     k, d = lines[0].split(' ')
#     print StringSpelledByGappedPatterns(lines[1:], int(k), int(d))

@timeit
def PairedDeBruijnGraph(paired_reads, k, d):

    def prefix(paired_read):
        return paired_read[:k-1] + '|' + paired_read[-k:-1]

    def suffix(paired_read):
        return paired_read[1:k] + '|' + paired_read[-k+1:]

    nodes = []
    for pair in paired_reads:
        p = prefix(pair)
        s = suffix(pair)
        nodes += [p, s]
    nodes = sorted(list(set(nodes)))
    n = len(nodes)

    de_bruijn_graph = {
        'edges': paired_reads,
        'edge_count': len(paired_reads),
        'nodes': nodes,
        'adjacency_matrix': np.zeros((n, n), dtype=np.int8),
        'adjacency_list': {},
        'degress': {}
    }

    for pair in paired_reads:
        i = nodes.index(prefix(pair))
        j = nodes.index(suffix(pair))
        de_bruijn_graph['adjacency_matrix'][i, j] += 1


    a_list = adjacency_matrix_to_list(de_bruijn_graph)
    de_bruijn_graph['adjacency_list'] = a_list

    for i in range(n):
        de_bruijn_graph['degress'][nodes[i]] = {
            'outdegress': sum(de_bruijn_graph['adjacency_matrix'][i]),
            'indegress': sum(de_bruijn_graph['adjacency_matrix'][:, i]),
        }

    # print_adjacency_matrix(de_bruijn_graph)
    # print_adjacency_list(de_bruijn_graph)

    return de_bruijn_graph

# k = 2
# d = 1
# paired_reads = sorted(paired_composition('AGCAGCTGCTGCA', k, d))
# graph = PairedDeBruijnGraph(paired_reads, k, d)
# gapped_patterns = eulerian_path(graph)
# print StringSpelledByGappedPatterns(gapped_patterns, k, d)

# with open('dataset_204_15.txt', 'r') as f:
#     lines = f.read().splitlines()
#     k, d = lines[0].split(' ')
#     k = int(k)
#     d = int(d)
#     graph = PairedDeBruijnGraph(lines[1:], k, d)
#     gapped_patterns = eulerian_path(graph)
#     print StringSpelledByGappedPatterns(gapped_patterns, k, d)

def maximal_non_branching_paths(graph):

    def one_in_one_out(v):
        return graph['degress'][v]['outdegress'] == 1 and graph['degress'][v]['indegress'] == 1

    paths = []
    nodes = graph['nodes']
    degress = graph['degress']
    for v in nodes:
        if not one_in_one_out(v):
            if graph['degress'][v]['outdegress'] > 0:
                for w in graph['adjacency_list'][v]:
                    nonbranchingpath = [v, w]
                    while one_in_one_out(w):
                        w = graph['adjacency_list'][w][0]
                        nonbranchingpath.append(w)
                    paths.append(nonbranchingpath)
    
    # isolated cycle in graph
    isolated_nodes = set(nodes) - set(reduce(lambda a,b: a + b, paths))
    while len(isolated_nodes) > 0:
        w = v = list(isolated_nodes)[0]
        nonbranchingpath = [v]
        while 1:
            w = graph['adjacency_list'][w][0]
            nonbranchingpath.append(w)
            if w == v: break
        paths.append(nonbranchingpath)
        isolated_nodes = isolated_nodes - set(nonbranchingpath)

    return paths

# sample_input = ['1 -> 2','2 -> 3','3 -> 4,5','6 -> 7','7 -> 6']
# with open('dataset_6207_2.txt','r') as f:
#     sample_input = f.read().splitlines()
#     graph = adjacency_list_to_graph(sample_input)
#     for i in maximal_non_branching_paths(graph):
#         print '->'.join(i)

# patterns = ['ATG','ATG','TGT','TGG','CAT','GGA','GAT','AGA']
# with open('dataset_205_5.txt', 'r') as f:
#     patterns = f.read().splitlines()
#     graph = DeBruijn(patterns)
#     result = []
#     for i in maximal_non_branching_paths(graph):
#         result.append(reduce(lambda a,b:a+b[-1], i))
#     print ' '.join(result)





