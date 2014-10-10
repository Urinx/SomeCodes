#!/usr/bin/env python
# coding:utf-8
from matplotlib import pyplot

language=('C','Java','Obj-C','C++','VB','C#','PHP','Python','JS','Perl')

def autolabel(rects):
	for rect in rects:
		height=rect.get_height()
		pyplot.text(rect.get_x(),0.2+height,'%s' % height)

pyplot.xlabel('Languages')
pyplot.ylabel('Rantings')
pyplot.title('Language Rating')
pyplot.xticks((0,1,2,3,4,5,6,7,8,9),language)

rect=pyplot.bar(left=(0,1,2,3,4,5,6,7,8,9),height=(16.926,16.907,11.791,5.986,4.197,3.745,3.386,3.057,1.788,1.47),width=0.5,align='center')
pyplot.legend((rect,),(u'图例',))
autolabel(rect)
pyplot.show()