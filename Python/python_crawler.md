[Python爬虫：一些常用的爬虫技巧总结](http://my.oschina.net/jhao104/blog/647308?fromerr=X3ziCEMd)
==============================================================

Category
--------
1. 基本抓取网页
	- get方法
	- post方法
2. 使用代理IP
3. Cookies处理
4. 伪装成浏览器
5. 页面解析
6. 验证码的处理
7. gzip压缩
8 .多线程并发抓取

1. 基本抓取网页
**get方法**
```
import urllib2
 
url = "http://www.baidu.com"
response = urllib2.urlopen(url)
print response.read()
```

**post方法**
```
import urllib
import urllib2
 
url = "http://abcde.com"
form = {'name':'abc','password':'1234'}
form_data = urllib.urlencode(form)
request = urllib2.Request(url,form_data)
response = urllib2.urlopen(request)
print response.read()
```

2. 使用代理IP
```
import urllib2
 
proxy = urllib2.ProxyHandler({'http': '127.0.0.1:8087'})
opener = urllib2.build_opener(proxy)
urllib2.install_opener(opener)
response = urllib2.urlopen('http://www.baidu.com')
print response.read()
```

3. Cookies处理
```
import urllib2, cookielib
 
cookie_support= urllib2.HTTPCookieProcessor(cookielib.CookieJar())
opener = urllib2.build_opener(cookie_support)
urllib2.install_opener(opener)
content = urllib2.urlopen('http://XXXX').read()
```
关键在于CookieJar()，它用于管理HTTP cookie值、存储HTTP请求生成的cookie、向传出的HTTP请求添加cookie的对象。整个cookie都存储在内存中，对CookieJar实例进行垃圾回收后cookie也将丢失，所有过程都不需要单独去操作。
```
cookie = "PHPSESSID=91rurfqm2329bopnosfu4fvmu7; kmsign=55d2c12c9b1e3; KMUID=b6Ejc1XSwPq9o756AxnBAg="
request.add_header("Cookie", cookie)
```

4. 伪装成浏览器
```
import urllib2
 
headers = {
    'User-Agent':'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6'
}
request = urllib2.Request(
    url = 'http://my.oschina.net/jhao104/blog?catalog=3463517',
    headers = headers
)
print urllib2.urlopen(request).read()
```

5. 页面解析

> lxml：http://my.oschina.net/jhao104/blog/639448 
> BeautifulSoup：http://cuiqingcai.com/1319.html 

Beautifulsoup纯python实现，效率低，但是功能实用，比如能用通过结果搜索获得某个HTML节点的源码；lxmlC语言编码，高效，支持Xpath

7. gzip压缩
许多web服务具有发送压缩数据的能力，这可以将网络线路上传输的大量数据消减 60% 以上。这尤其适用于 XML web 服务，因为 XML 数据 的压缩率可以很高。但是一般服务器不会为你发送压缩数据，除非你告诉服务器你可以处理压缩数据。
```
import urllib2, httplib
request = urllib2.Request('http://xxxx.com')
request.add_header('Accept-encoding', 'gzip')        1
opener = urllib2.build_opener()
f = opener.open(request)
```
解压缩数据:
```
import StringIO
import gzip
 
compresseddata = f.read() 
compressedstream = StringIO.StringIO(compresseddata)
gzipper = gzip.GzipFile(fileobj=compressedstream) 
print gzipper.read()
```

8. 多线程并发抓取
```
from threading import Thread
from Queue import Queue
from time import sleep
# q是任务队列
#NUM是并发线程总数
#JOBS是有多少任务
q = Queue()
NUM = 2
JOBS = 10
#具体的处理函数，负责处理单个任务
def do_somthing_using(arguments):
    print arguments
#这个是工作进程，负责不断从队列取数据并处理
def working():
    while True:
        arguments = q.get()
        do_somthing_using(arguments)
        sleep(1)
        q.task_done()
#fork NUM个线程等待队列
for i in range(NUM):
    t = Thread(target=working)
    t.setDaemon(True)
    t.start()
#把JOBS排入队列
for i in range(JOBS):
    q.put(i)
#等待所有JOBS完成
q.join()
```
