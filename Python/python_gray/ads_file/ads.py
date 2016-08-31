import sys
for x in xrange(1,3):
	f=open(sys.argv[x],'rb')
	fc=f.read()
	print '[*] Fiel:',sys.argv[x]
	print '[*] File length:',len(fc)
	print '[*] File content:',fc
	print
	f.close()
f=open('%s:%s' % (sys.argv[1],sys.argv[2]),'wb')
f.write(fc)
print '[*] Succeed make fiel: %s:%s' % (sys.argv[1],sys.argv[2])
f.close()