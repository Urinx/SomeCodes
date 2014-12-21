#!/usr/bin/env python
import re,urllib

url='http://admin:27135812@192.168.1.1/userRpm/AssignedIpAddrListRpm.htm'
r=urllib.urlopen(url)
content=r.read()
reg=r'var DHCPDynList = new Array\(\n([\s\S]*?)\n0,0\s\)'
m=re.findall(reg,content)[0].replace('"','').replace(' ','')

# Outputs
print '='*80
print 'Device'+' '*18+'\t   Mac Address   \t     IP     \tTime'
for line in m.split('\n'):
    ls=line.split(',')[:-1]
    le=len(ls[0])
    if le<24: ls[0]+=' '*(24-le)
    print '\t'.join(ls)
print '='*80
