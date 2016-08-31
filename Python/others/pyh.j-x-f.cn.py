#!/usr/bin/env python
# coding: utf-8

import re, json, requests, os
from bs4 import BeautifulSoup
from openpyxl import Workbook
from xml.dom.minidom import parse
import base64

def Log(dict):
    for (key, value) in dict.items():
        print key,':',value
    print '='*30

data_arr = []
ILLEGAL_CHARACTERS_RE = re.compile(r'[\000-\010]|[\013-\014]|[\016-\037]')

for n in range(1, 20):
    f = open('BusinessList/'+str(n)+'.json', 'r')
    
    for j in json.load(f):
        d = {
            'pid': j['str_2'].split('/')[-1].split('.')[0],
            'bid': j['str_3'],
            'teacher': j['str_1'],
            'course': ILLEGAL_CHARACTERS_RE.sub(r'', j['str_6'].strip()),
            'subject': j['str_5'],
            'info': '',
            'tel': '',
            'headimg': '',
            'ppt': 'PPT/'+j['str_3'],
            'layout': '',
        }

        # data = requests.get(j['str_2'])
        d['headimg'] = 'head_img/'+d['pid']+'.jpg'
        # with open(d['headimg'], 'wb') as f:
        #     f.write(data.content)

        f2 = open('Teacher_info/'+d['pid'], 'r')
        content = f2.read().replace('&#xe67c;','').replace('\u0026','')
        content = content.replace('<span style="font-size:0.6rem; color:#808080;"> 查看详细</span>','')
        # content = content.decode('utf-8')
        content = ILLEGAL_CHARACTERS_RE.sub(r'', content)
        soup = BeautifulSoup(content, "lxml")
        
        div_box_content = soup.findAll('div', class_='box_content_in_1')
        t = ''
        for div in div_box_content:
            if not div.select('div.facebook-card'):
                t += div.text + '\n'
        d['info'] = t.strip()

        span_teacher = soup.find(id='teacher_txt')
        m = re.search(u'【联系方式】(.+)', span_teacher.text)
        d['tel'] = m.group(1).strip() if m else ''

        f3 = open('VoiceFile/'+d['bid']+'.html', 'r')
        content3 = ILLEGAL_CHARACTERS_RE.sub(r'', f3.read())
        soup3 = BeautifulSoup(content3, "lxml")
        div_box_1 = soup3.findAll('div', class_='box_content_in_1')[0]
        d['layout'] = div_box_1.text.strip()


        # Log(d)
        data_arr.append(d)

col = ['pid', 'bid', '讲师', '课程', '分类', '讲师资料', '联系方式', '头像', 'PPT', '大纲']
cols = ['pid', 'bid', 'teacher', 'course', 'subject', 'info' ,'tel', 'headimg', 'ppt', 'layout']
wb = Workbook()
ws = wb.active
ws.append(col)
for data in data_arr:
    ws.append([data[c] for c in cols])
wb.save('培友会2.xlsx')

# with open('bid.txt', 'a+') as f:
#     for d in data_arr:
#         f.write(d['bid']+'\n')

# DOMTree = parse("data.xml")
# collection = DOMTree.documentElement
# items = collection.getElementsByTagName("response")
# paths = collection.getElementsByTagName("path")

# for i in xrange(len(items)):
#     item = items[i]
#     path = paths[i]
#     bid = path.childNodes[0].data.split('/')[-1]
#     html = base64.b64decode(item.childNodes[0].data)
#     html = '<!DOCTYPE html>\n' + html.split('<!DOCTYPE html>')[-1]

#     with open('VoiceFile/'+bid+'.html','w') as f:
#         f.write(html)

# with open('bid.txt', 'r') as f:
#     for line in f.readlines():
#         bid = line.strip()

#         with open('VoicePlay/'+bid+'.html','r') as f2:
#             content = f2.read()
#             m = re.search(r'({title:.+})', content)
#             if m:
#                 m2 = re.findall(r'(http://[^"]+)', m.group())
#                 if m2:
#                     os.mkdir('PPT/'+bid)
#                     for link in m2:
#                         r = requests.get(link)
#                         file = 'PPT/'+bid+'/'+link.split('/')[-1]
#                         print 'save file:',file
#                         with open(file, 'wb') as f3:
#                             f3.write(r.content)



