yum remove pptpd ppp -y
iptables --flush POSTROUTING --table nat
iptables --flush FORWARD
rm -f /etc/pptpd.conf
rm -f /etc/ppp
arch=`uname -m`
yum -y install make libpcap iptables gcc-c++ logrotate tar cpio perl pam tcp_wrappers dkms kernel_ppp_mppe ppp
wget http://www.huzs.net/soft/pptp_onekey/pptpd-1.4.0-1.el6.$arch.rpm
rpm -Uvh pptpd-1.4.0-1.el6.$arch.rpm

mknod /dev/ppp c 108 0
echo 1 > /proc/sys/net/ipv4/ip_forward
echo "mknod /dev/ppp c 108 0" >> /etc/rc.local
echo "echo 1 > /proc/sys/net/ipv4/ip_forward" >> /etc/rc.local
echo "localip 172.16.22.254" >> /etc/pptpd.conf
echo "remoteip 172.16.22.1-253" >> /etc/pptpd.conf
echo "ms-dns 8.8.8.8" >> /etc/ppp/options.pptpd
echo "ms-dns 8.8.4.4" >> /etc/ppp/options.pptpd
 
#pass=`openssl rand 6 -base64`
#if [ "$1" != "" ]
#then pass=$1
#fi

echo "vpn pptpd www.scon.me *" >> /etc/ppp/chap-secrets
 
iptables -t nat -A POSTROUTING -s 172.16.22.0/24 -j SNAT --to-source `ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk 'NR==1 { print $1}'`
iptables -A FORWARD -p tcp --syn -s 172.16.22.0/24 -j TCPMSS --set-mss 1356
service iptables save
chkconfig iptables on
chkconfig pptpd on
service iptables restart
service pptpd start

echo "恭喜您，VPN PPTP已经安装完成, 用户名：vpn   密码：www.scon.me"
echo "编辑此文件以添加删除用户： vi /etc/ppp/chap-secrets"


