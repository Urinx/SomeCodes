#! /usr/bin/env python
# coding:utf-8
import urllib2,urllib,re
import sys
reload(sys)
sys.setdefaultencoding('utf8')

def user_info(content):
	try:
		m1=re.search(r'<div class="ershou-info">([\s\S]*?)</ul>',content)

		cmt=re.search(r'<span id="user_cmt">([\s\S]*?)</span>',content).group(1)
		good=re.search(r'<h2 class="ershou-title">([\s\S]*?)</h2>',m1.group(1)).group(1)
		price=re.search(r'<div class="ershou-price discount">\s*<span>([\s\S]*?)</span>',m1.group(1)).group(1)
		seller=re.search(r'<div class="value">\s+<span>([\s\S]*?)</span>',m1.group(1)).group(1)
		user_arr=re.findall(r'<div class="value"><span>([\s\S]*?)</span>',m1.group(1))
		for i in range(4):
			if not user_arr[i]: user_arr[i]='#'
		return [seller]+user_arr+[good,price,cmt]
	except Exception, e:
		return []

def get(num):
	url='http://2shoujie.com/goods/'+str(num)
	return urllib2.urlopen(url).read()

def main():
    with open('2shoujie.txt','a') as f:
        a=100
        try:
            f2=open('2shoujie.txt','r')
            num=int(f2.readlines()[-1].split(' ')[0])+1
            num_before=num
        except Exception,e:
            num=66451
        while 1:
            info=[i.decode('utf8') for i in user_info(get(num))]
            if not info:
                if a<=0: break
                a-=1
            else:
                tmp=' '.join([str(num)]+info)
                print tmp
                f.write(tmp+"\n")
                a=100
            num+=1
        print 'Add',num-num_before,'new infos'

if __name__=='__main__':
	main()
