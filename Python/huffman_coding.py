#!/usr/bin/env python
#coding:utf-8

import sys
import binascii
import os

def text_to_bits(text, encoding='utf-8', errors='surrogatepass'):
    try:
        bits = bin(int(binascii.hexlify(text.encode(encoding, errors)), 16))[2:]
        return bits.zfill(8 * ((len(bits) + 7) // 8))
    except Exception as e:
        return bin(int(binascii.b2a_hex(text),16))[2:].rjust(8,'0')

def text_from_bits(bits, encoding='utf-8', errors='surrogatepass'):
    n = int(bits, 2)
    try:
        return int2bytes(n).decode(encoding, errors)
    except:
        return binascii.a2b_hex(hex(int(bits, 2))[2:].rjust(2,'0'))

def int2bytes(i):
    hex_string = '%x' % i
    n = len(hex_string)
    return binascii.unhexlify(hex_string.zfill(n + (n & 1)))


class HuffmanNode(object):

    def __init__(self, char, freq, left, right):
        self.char = char
        self.freq = freq
        self.left = left
        self.right = right

    def is_leaf(self):
        return self.left is None and self.right is None

    def compare_to(self, node):
        return self.freq - node.freq


class PriorityQueue(object):

    def __init__(self):
        self.queue = []

    def add(self, node):
        i = 0
        L = len(self.queue)
        while i < L:
            n = self.queue[i]
            if node.compare_to(n) <= 0:        
                break
            i += 1
        self.queue.insert(i, node)

    def poll(self):
        return self.queue.pop(0)

    def size(self):
        return len(self.queue)


def build_tree(ascii_freq):
    pq = PriorityQueue()
    for i in range(len(ascii_freq)):
        f = ascii_freq[i]
        c = chr(i)
        if f > 0:
            pq.add(HuffmanNode(c, f, None, None))

    while pq.size() > 1:
        left = pq.poll()
        right = pq.poll()
        parent = HuffmanNode('\0', left.freq + right.freq, left, right)
        pq.add(parent)

    return pq.poll()


def build_code(root_node):
    ht = {}
    
    def build_ht(table, node, binary_str):
        if node is None:
            return

        if node.is_leaf():
            table[node.char] = binary_str

        build_ht(table, node.left, binary_str + '0')
        build_ht(table, node.right, binary_str + '1')

    build_ht(ht, root_node, '')
    return ht


def gen_ascii_freq(file_name):
    ascii_freq = [0] * 256
    with open(file_name, 'r') as f:
        for c in f.read():
            d = ord(c)
            ascii_freq[d] += 1
    return ascii_freq


def compress(file_name, huffman_table):
    compressed_str = ''
    with open(file_name, 'r') as f:
        for c in f.read():
            compressed_str += huffman_table[c]
    return compressed_str


def build_tree_str(root_node):
    tree_str = []

    def write_tire(node, tree_str):
        if node.is_leaf():
            tree_str.append('1')
            tree_str.append(text_to_bits(node.char))
            return

        tree_str.append('0')
        write_tire(node.left, tree_str)
        write_tire(node.right, tree_str)

    write_tire(root_node, tree_str)
    return ''.join(tree_str)


def gen_compressed_file(origin_file_name, huffman_tree_str, compressed_str, output_file):
    # origin_file_name: 64 byte
    # huffman_tree_len: 32 byte
    # zero_end_num    :  1 byte
    # huffman_tree_str:  x byte
    # compressed_str  :  x byte
    
    name = ''
    for c in origin_file_name:
        name += text_to_bits(c)
    name = name[-64:]
    n = bin(len(huffman_tree_str))[2:].rjust(32,'0')
    zero_end_num = 8 - (len(huffman_tree_str) + len(compressed_str)) % 8
    z = bin(zero_end_num)[2:].rjust(8,'0')
    binary_str = name + n + z + huffman_tree_str + compressed_str + '0' * zero_end_num

    with open(output_file,'wb') as f:
        for i in range(0, len(binary_str), 8):
            h = binascii.a2b_hex(hex(int(binary_str[i:i+8], 2))[2:].rjust(2,'0'))
            f.write(h)


def get_binary_str(input_file):
    binary_str = ''
    with open(input_file, 'rb') as f:
        for h in f.read():
            binary_str += bin(int(binascii.b2a_hex(h),16))[2:].rjust(8,'0')
    return binary_str


def decomposition(binary_str):
    name = text_from_bits(binary_str[:64])
    n = int(binary_str[64:96],2)
    z = int(binary_str[96:104],2)
    huffman_tree_str = binary_str[104:104+n]
    compressed_str = binary_str[104+n:-z]
    return [name, huffman_tree_str, compressed_str]


def restruct_huffman_tree(huffman_tree_str):
    tree_str = []
    i = 0
    while i < len(huffman_tree_str):
        b = huffman_tree_str[i]
        tree_str.append(b)
        i += 1
        if b == '1':
            c = text_from_bits(huffman_tree_str[i:i+8])
            tree_str.append(c)
            i += 8

    def read_tire(tree_str):
        b = tree_str.pop(0)

        if b == '1':
            c = tree_str.pop(0)
            return HuffmanNode(c, 0, None, None)

        return HuffmanNode('\0', 0, read_tire(tree_str), read_tire(tree_str))

    return read_tire(tree_str)


def decompress(compressed_str, root_node):
    origin_str = []
    x = root_node
    i = 0
    while i < len(compressed_str):
        
        while not x.is_leaf():
            b = compressed_str[i]
            if b == '0':
                x = x.left
            else:
                x = x.right
            i += 1

        origin_str += [x.char]
        x = root_node

    return origin_str


opt = sys.argv[1]
if opt == '-c':
    input_file = sys.argv[2]
    output_file = sys.argv[3]
    print '开始压缩:', input_file
    print '生成频率表'
    ascii_freq = gen_ascii_freq(input_file)
    print '生成单词查找树'
    root_node = build_tree(ascii_freq)
    print '生成霍夫曼编码表'
    huffman_table = build_code(root_node)
    print huffman_table
    print '生成单词查找树比特'
    huffman_tree_str = build_tree_str(root_node)
    print huffman_tree_str
    print '生成压缩文件比特'
    compressed_str = compress(input_file, huffman_table)
    print '生成压缩文件:', output_file
    gen_compressed_file(input_file, huffman_tree_str, compressed_str, output_file)
    print '压缩前大小:', os.path.getsize(input_file), 'bytes'
    print '压缩后大小:', os.path.getsize(output_file), 'bytes'
    print '压缩完毕'
elif opt == '-z':
    input_file = sys.argv[2]
    file_binary_str = get_binary_str(input_file)
    name, huffman_tree_str, compressed_str = decomposition(file_binary_str)
    print '读取原文件:', name
    print '读取单词查找树比特'
    print huffman_tree_str
    print '读取压缩文件比特'
    print '重建单词查找树'
    root_node = restruct_huffman_tree(huffman_tree_str)
    print build_code(root_node)
    print '重建原文件'
    origin_str = decompress(compressed_str, root_node)
    with open(name, 'w') as f:
        for c in origin_str:
            f.write(c)
    print '重建文件大小:', os.path.getsize(name), 'bytes'
    print '解压缩完成'

