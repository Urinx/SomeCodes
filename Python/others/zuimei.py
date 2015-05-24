#!/usr/bin python
#coding: utf-8

# 最美应用图标下载

import re
import requests
import shutil

for page in range(1,101):
	url='http://zuimeia.com/?page='+str(page)+'&platform=1'
	r=requests.get(url)
	reg=r'alt="([^"]*?) 的 icon" data-original="(http://qstatic.zuimeia.com/[^"]*?\.([^"]*?))"'
	img_src=re.findall(reg,r.content)
	for i in img_src:
		print i[0]
		img=requests.get(i[1],stream=True)
		if img.status_code == 200:
			with open('icon/'+i[0]+'.'+i[2],'wb') as f:
				shutil.copyfileobj(img.raw,f)
			del img