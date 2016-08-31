#!/usr/bin.env pytohn
#coding: utf-8
import cPickle as pickle
import requests
import re
import os
from bs4 import BeautifulSoup
from openpyxl import Workbook

DATABASE = []
Cache = {}
baseUrl = 'http://www.jiangshi.org/searchLect.aspx'
index = 0

def Log(dict):
	for (key, value) in dict.items():
		print key,':',value
	print '='*30

def getTotalPageNum(data):
	r = requests.get(baseUrl, data = data)
	m = re.search('总页数：\d+/(\d+)', r.content.decode('utf-8').encode('utf-8'))
	return int(m.group(1))

def extractPeopleInfo(node):
	person = {'id': -1}
	div1 = node.select('div.p_list_boxl_2v')[0]
	div2 = node.select('div.p_list_box_s_list')[0]
	[d1, d2, d3] = div2.select('div.p_list_boxr_2_s_list')
	location = d1.select('span.slect_szd1')[0]
	location.span.extract()
	skill = d2.select('span.slect_ly')[0]
	skill.span.extract()
	d3.span.span.extract()
	d4 = div2.select('div.title_c_list > p')[0]
	person['link'] = div1.a['href']
	person['head_image'] = div1.a.img['src']
	person['name'] = d1.select('div.slect_left')[0].span.a.string
	person['title'] = d1.select('span.slect_dw')[0].text
	person['total_score'] = d1.select('span.colorredb')[0].text
	person['location'] = location.text
	person['RMB'] = d1.select('span.slect_fy')[0].span.text
	person['skill'] = skill.text
	person['course_num'] = d2.select('span.slect_sk')[0].span.text

	area = d2.select('span.slect_hy')
	if len(area) != 0:
		area = area[0]
		area.span.extract()
		person['area'] = area.text
	else: person['area'] = ''

	person['main_course'] = d3.span.text.replace('\r\n','')
	person['intro'] = d4.a.string
	person['intro_link'] = d4.a['href']

	if d4.span is not None:
		person['tel'] = d4.span.text.replace(u'电话：','')
	else:
		person['tel'] = ''

	# Log(person)
	return person

def getPeopleInfoList(data):
	global Cache, DATABASE, index
	r = requests.get(baseUrl, data = data)
	soup = BeautifulSoup(r.content, "lxml")
	p_list = soup.find_all('div', class_='p_list_main')[0]
	peoples = p_list.select('div.p_list_boxs_list_recommend') + p_list.select('div.p_list_boxs_list')
	
	for p in peoples:
		info = extractPeopleInfo(p)
		if not Cache.has_key(info['name']+info['tel']):
			Cache[info['name']+info['tel']] = 1
			index += 1
			info['id'] = index
			DATABASE.append(info)

def fetchAll():
	totalPageNum = 10 # only the first 10 pages data is valid
	print '[*] Total Page:',totalPageNum
	for n in range(1,totalPageNum+1):
		print '[*] Page:',n
		data = {'page': n, 'order': 1}
		getPeopleInfoList(data)
	saveDatabase(1)

def fetchAtLocation():
	for a in range(1,36):
		totalPageNum = getTotalPageNum({'a':a})
		print '[*] Location:',a,'Total Page:',totalPageNum
		for n in range(1,totalPageNum+1):
			print '[*] Page:',n
			data = {'page': n, 'order': 1, 'a': a}
			getPeopleInfoList(data)
		if a % 10 == 0:
			saveDatabase('4-'+str(a / 10))
	saveDatabase('4-4')

def fetchAtArea():
	i_code = [1,2,3,4,6,7,10,13,15,16,17,19,21,23,24,26,27,29,30,31,32,36,44,41]
	for i in i_code:
		totalPageNum = getTotalPageNum({'i':i})
		print '[*] Area:',i,'Total Page:',totalPageNum
		for n in range(1,totalPageNum+1):
			print '[*] Page:',n
			data = {'page': n, 'order': 1, 'i': i}
			getPeopleInfoList(data)
	saveDatabase(3)

def fetchAtSkill():
	for s in range(51, 101):
		totalPageNum = getTotalPageNum({'s':s})
		if totalPageNum == 1:
			if s % 10 == 0: saveDatabase('2-'+str(s / 10))
			continue
		print '[*] Skill:',s,'Total Page:',totalPageNum
		for n in range(1,totalPageNum+1):
			print '[*] Page:',n
			data = {'page': n, 'order': 1, 's': s}
			getPeopleInfoList(data)
		if s % 10 == 0:
			saveDatabase('2-'+str(s / 10))

def saveDatabase(n):
	global DATABASE
	name = 'database'+str(n)+'.pkl'
	print '[*] Save Data:',name
	with open(name, 'wb') as f:
		pickle.dump(DATABASE, f, pickle.HIGHEST_PROTOCOL)
		DATABASE = []
	with open('cache.pkl', 'wb') as f:
		pickle.dump(Cache, f, pickle.HIGHEST_PROTOCOL)

def loadCache():
	global Cache, index
	if os.path.isfile('cache.pkl'):
		with open('cache.pkl', 'rb') as f:
			Cache = pickle.load(f)
	index = len(Cache)

def loadDatabase():
	global DATABASE

	print '[*] Load Database 1'
	with open('data/database1.pkl', 'rb') as f:
		d1 = pickle.load(f)
	print '[*] Load Database 3'
	with open('data/database3.pkl', 'rb') as f:
		d3 = pickle.load(f)

	print '[*] Load Database 4'
	d4 = []
	for i in range(1,5):
		with open('data/database4-'+str(i)+'.pkl', 'rb') as f:
			d4 += pickle.load(f)

	print '[*] Load Database 2'
	d2 = []
	for i in range(1,11):
		with open('data/database2-'+str(i)+'.pkl', 'rb') as f:
			d2 += pickle.load(f)

	DATABASE = d1+d3+d4+d2
	print '[*] Load Done'

def saveDataToExcel(filename='data.xlsx'):
	print '[*] Save Data to Excel'
	col = ['id', 'name', 'title', 'tel', 'location', 'area', 'skill', 'total_score',
	'link', 'head_image', 'main_course', 'RMB', 'course_num', 'intro', 'intro_link']
	wb = Workbook()
	ws = wb.active
	ws.append(col)
	for data in DATABASE:
		ws.append([data[c] for c in col])
	wb.save(filename)

def main():
	# loadCache()
	print '[*] Fetch Data Start:',baseUrl
	# fetchAll()
	print '[*] 按领域抓取'
	# fetchAtSkill()
	print '[*] 按行业抓取'
	# fetchAtArea()
	print '[*] 按地区抓取: 35个地区(a:1-35)'
	# fetchAtLocation()
	print '[*] Total Data:',index
	loadDatabase()
	saveDataToExcel()

main()
