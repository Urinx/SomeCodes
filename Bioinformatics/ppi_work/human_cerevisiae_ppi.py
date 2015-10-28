#!/usr/bin/env python
# coding: utf-8

import math
import numpy as np
import matplotlib.pyplot as plt
from time import time

# Data files
PSQ_File = 'protein_sequence.txt'
TrainingData_File = 'training.txt'
sqMap = {}
positiveTrainingData = []
negativeTrainingData = []
pTrainingSample = 1222 # max: 1222
nTrainingSample = 1494 # max: 1494
Factor = [
	# Vector of hydrogen-bonding
	[0.0,0.13,52.0,49.5,3.38,1.43,49.7,0.35,1.48,1.58,3.53,1.67,49.9,1.66,0.0,2.10,51.6,1.61,0.13,0.13],# Zimmerman_Score
	[8.1,4.9,10.5,11.3,11.6,5.7,13.0,5.2,5.5,8.0,10.5,9.2,12.3,8.6,9.0,5.4,10.4,6.2,5.2,5.9],# Granthan_Score
	# Vector of secondary structure
	[0.66,0.59,0.95,1.01,1.56,0.60,1.46,0.60,1.19,1.52,0.98,1.43,0.74,0.96,1.56,0.96,0.95,1.14,0.47,0.50],# Fasman_Score
	# Vector of Van der Waal's interaction
	[1.8,3.8,-4.5,-3.9,-3.5,1.9,-3.5,2.8,2.5,-1.6,-3.5,-0.8,-3.5,-0.7,-0.4,-0.9,-3.2,-1.3,4.5,4.2],# KD_Score
	[8.1,4.9,10.5,11.3,11.6,5.7,13.0,5.2,5.5,8.0,10.5,9.2,12.3,8.6,9.0,5.4,10.4,6.2,5.2,5.9]# BB_Score
]

print '[*] Start load data...'
startTime = time()
with open(PSQ_File) as f:
	acids = set('ALRKNMDFCPQSETGWHYIV')
	data = f.readlines()
	for i in xrange(0,len(data),2):
		ac = data[i].split('|')[1]
		sq = data[i+1].replace('\n','')
		if acids == set(sq):
			sqMap[ac] = sq
print '[*] Load ' + str(len(sqMap)) + ' protein sequences successful!'

with open(TrainingData_File) as f:
	for line in f.readlines():
		data = line.replace('\r\n','').replace('\n','').split(' ')
		if data[1] in sqMap and data[2] in sqMap:
			if data[0] == '+':
				positiveTrainingData.append(data[1:])
			else:
				negativeTrainingData.append(data[1:])
pNum = len(positiveTrainingData)
nNum = len(negativeTrainingData)
print '[*] Load ' + str(pNum + nNum) + ' training data successful!'

totalTime = time()-startTime
print '[*] Load data done. ' + str(totalTime) + ' s'

# 提取特征值
def getFactor(ac, k):
	acids = 'ALRKNMDFCPQSETGWHYIV'
	sq = sqMap[ac]
	f = Factor[k]
	return [f[acids.find(a)] for a in sq]

# 维度转换
def fourierTransform(arr, k=10):
	L = len(arr)
	C1, C2 = math.sqrt(2.0/L), math.pi/L
	return [C1 * sum([ arr[n]*math.cos( C2*(n+0.5)*(i+0.5) ) for n in range(L) ]) for i in range(k)]

# 叉乘
def crossMulti(f1, f2):
	return [i*j for i in f1 for j in f2]

# 每一对蛋白质的特征向量相乘后的向量X
def getX(sq1, sq2, k):
	f1 = fourierTransform(getFactor(sq1, k))
	f2 = fourierTransform(getFactor(sq2, k))
	X = crossMulti(f1, f2)
	return X

def setData(k=0):
	pos = [getX(d[0], d[1], k) for d in positiveTrainingData[:pTrainingSample]]
	neg = [getX(d[0], d[1], k) for d in negativeTrainingData[:nTrainingSample]]
	return pos, neg

# Fisher 判别法
def fisher(X1, X2):
	L1, L2 = len(X1), len(X2)
	M1 = np.sum(X1,0)/L1
	M2 = np.sum(X2,0)/L2
	S1 = 0
	S2 = 0
	for x in X1:
		tmp = x - M1
		tmp.shape = (1, M1.shape[0])
		S1 += tmp.T.dot(tmp)
	for x in X2:
		tmp = x-M2
		tmp.shape = (1, M2.shape[0])
		S2 += tmp.T.dot(tmp)
	Sw = S1 + S2
	W = np.linalg.inv(Sw).dot(M1-M2)
	return W

# 打分
def score(score, M, X, k):
	for i in range(len(score)):
		score[i, k] = M.dot(X[i])

def normalizeScore(scoreArr):
	norScore = scoreArr.copy()
	Lp, Ln = pTrainingSample, nTrainingSample
	m, n = norScore.shape
	for i in range(n):
		c1 = np.sum(norScore[:Lp,i]) / Lp
		c2 = np.sum(norScore[Lp:,i]) / Ln
		c = (c1+c2) / 2
		for j in range(m):
			norScore[j,i] = 100.0 / math.pi * math.atan(2*(norScore[j,i]-c)/(c1-c2)) + 50
	return norScore

def evaluate(score):
	maxRate = threashold = 0
	L, Lp = len(score), pTrainingSample
	for i in range(100):
		succ = sum(score[:Lp]>=i) + sum(score[Lp:]<i)
		rate = succ * 1.0 / L
		if rate > maxRate:
			maxRate, threashold = rate, i
	print '[*] The threashold is '+str(threashold)+' & Accuracy is '+ str(maxRate)

def ROC(score):
	FPR, TPR, FTPR = [], [], []
	P, N = pTrainingSample, nTrainingSample
	for threashold in score:
		FP = sum(score[P:] >= threashold)
		TP = sum(score[:P] >= threashold)
		FTPR.append( (round(FP * 1.0 / N, 2), round(TP * 1.0 / P, 2)) )
	FTPR = list(set(FTPR))
	FTPR.sort()
	FTPR = np.array(FTPR)
	plt.plot(FTPR[:,0],FTPR[:,1])
	plt.xlabel('False Positive Rate')
	plt.ylabel('True Positive Rate')
	# plt.show()
	filename = 'ROC-'+str(pTrainingSample)+'x'+str(nTrainingSample)+'.png'
	plt.savefig(filename)
	print '[*] Save image to file: '+filename
	return FTPR[:,0], FTPR[:,1]

def AUC(x, y):
    direction = 1
    dx = np.diff(x)
    if np.any(dx < 0):
        if np.all(dx <= 0):
            direction = -1
        else:
            raise ValueError("Reordering is not turned on, and the x array is not increasing: %s" % x)
    area = direction * np.trapz(y, x)
    return area

if __name__ == '__main__':
	LF=len(Factor)
	dataScore=np.zeros( (pTrainingSample + nTrainingSample,LF) )

	for k in range(LF):
		print '[*] K = '+str(k)
		startTime = time()
		pos,neg = setData(k)
		totalTime = time()-startTime
		print '[*] Set '+str(len(pos))+' positive & '+str(len(neg))+' negative samples. '+str(totalTime)+' s'
		startTime = time()
		M = fisher(pos, neg)
		score(dataScore, M, pos+neg, k)
		totalTime = time()-startTime
		print '[*] Solve M & Score the samples. '+str(totalTime)+' s'

	print '[*] Normalize the score.'
	norScore = normalizeScore(dataScore)
	finalScore = np.sum(norScore,1) / norScore.shape[1]

	evaluate(finalScore)
	print '[*] Plot ROC curve.'
	fpr, tpr = ROC(finalScore)
	print '[*] The AUC is ' + str(AUC(fpr, tpr))