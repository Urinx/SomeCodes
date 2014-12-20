#!/usr/bin/env python
import os,re

url='http://admin:27135812@192.168.1.1/userRpm/AssignedIpAddrListRpm.htm'
r=os.popen('curl '+url)
content=r.read()
reg=r'var DHCPDynList = new Array\(([\s\S]*?)\)'
m=re.findall(reg,content)[0]
print m
