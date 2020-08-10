#!/bin/bash

##backup

mkdir -p /root/backup
cp /etc/nginx/nginx.conf /root/backup/
cp /etc/nginx/conf.d/default.conf /root/backup/
cp /etc/sysctl.conf /root/backup/



echo "net.netfilter.nf_conntrack_max=99999999" >> /etc/sysctl.conf
echo "fs.inotify.max_user_watches=99999999" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_tw_buckets=99999999" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_tw_buckets_ub=65535" >> /etc/sysctl.conf
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_syncookies=1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_syn_backlog=65536" >> /etc/sysctl.conf
echo "net.core.somaxconn=65535" >> /etc/sysctl.conf
echo "fs.file-max=99999999" >> /etc/sysctl.conf
echo "kernel.sem=1000 128000 128 512" >> /etc/sysctl.conf
echo "vm.dirty_ratio=5" >> /etc/sysctl.conf
echo "fs.aio-max-nr=262144" >> /etc/sysctl.conf
echo "kernel.panic=1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.rp_filter=1" >> /etc/sysctl.conf
echo "kernel.sysrq=1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.send_redirects=1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.send_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.ip_dynaddr=1" >> /etc/sysctl.conf
# new 01now2015
echo "kernel.sem=1000 256000 128 1024" >> /etc/sysctl.conf
echo "kernel.msgmni=1024" >> /etc/sysctl.conf
#
# new 10apr2016
echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf
echo "fs.inotify.max_user_instances=1024" >> /etc/sysctl.conf

echo "kernel.msgmnb=65536" >> /etc/sysctl.conf
echo "kernel.msgmax=65536" >> /etc/sysctl.conf
echo "kernel.shmmax=4294967295" >> /etc/sysctl.conf
echo "kernel.shmall=268435456" >> /etc/sysctl.conf
echo "kernel.shmmni=4096" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_time=15" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_intvl=10" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_probes=5" >> /etc/sysctl.conf
echo "net.ipv4.tcp_fin_timeout=30" >> /etc/sysctl.conf
echo "net.ipv4.tcp_window_scaling=0" >> /etc/sysctl.conf
echo "net.ipv4.tcp_sack=0" >> /etc/sysctl.conf
echo "net.ipv4.tcp_timestamps=0" >> /etc/sysctl.conf
echo "vm.swappiness=10" >> /etc/sysctl.conf
echo "vm.overcommit_memory=1" >> /etc/sysctl.conf

# new test 26102016
# free_mem=$((`free | grep Mem | awk '{print $2}'`/3))
# echo "vm.min_free_kbytes=$free_mem" >> /etc/sysctl.conf
# sed -i "s/.*vm\.min_free_kbytes.*/vm.min_free_kbytes=$free_mem/g" /etc/sysctl.conf

sed -i 's/.*net.netfilter.nf_conntrack_max.*/net.netfilter.nf_conntrack_max=99999999/g' /etc/sysctl.conf
sed -i 's/.*fs.inotify.max_user_watches.*/fs.inotify.max_user_watches=99999999/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.net.ipv4.tcp_max_tw_buckets.*/net.ipv4.net.ipv4.tcp_max_tw_buckets=99999999/g' /etc/sysctl.conf
sed -i 's/.*tcp_max_tw_buckets_ub.*/net.ipv4.tcp_max_tw_buckets_ub=65535/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.tcp_max_tw_buckets_ub.*/net.ipv4.tcp_max_tw_buckets_ub=65535/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.ip_forward.*/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.tcp_syncookies.*/net.ipv4.tcp_syncookies=1/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.tcp_max_syn_backlog.*/net.ipv4.tcp_max_syn_backlog=65536/g' /etc/sysctl.conf
sed -i 's/.*net.core.somaxconn.*/net.core.somaxconn=65535/g' /etc/sysctl.conf
sed -i 's/.*fs.file-max.*/fs.file-max=99999999/g' /etc/sysctl.conf
sed -i 's/.*kernel.sem.*/kernel.sem=1000 128000 128 512/g' /etc/sysctl.conf
sed -i 's/.*vm.dirty_ratio.*/vm.dirty_ratio=5/g' /etc/sysctl.conf
sed -i 's/.*fs.aio-max-nr.*/fs.aio-max-nr=262144/g' /etc/sysctl.conf
sed -i 's/.*kernel.panic.*/kernel.panic=1/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.conf.all.rp_filter.*/net.ipv4.conf.all.rp_filter=1/g' /etc/sysctl.conf
sed -i 's/.*kernel.sysrq.*/kernel.sysrq=1/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.conf.default.send_redirects.*/net.ipv4.conf.default.send_redirects=1/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.conf.all.send_redirects.*/net.ipv4.conf.all.send_redirects=0/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.ip_dynaddr.*/net.ipv4.ip_dynaddr=1/g' /etc/sysctl.conf
# new 01now2015
sed -i 's/.*kernel.sem.*/kernel.sem=1000 256000 128 1024/g' /etc/sysctl.conf
sed -i 's/.*kernel.msgmn.*/kernel.msgmn=1024/g' /etc/sysctl.conf
#
# new 10apr2016
sed -i 's/.*fs.inotify.max_user_watches.*/fs.inotify.max_user_watches=524288/g' /etc/sysctl.conf
sed -i 's/.*fs.inotify.max_user_instances.*/fs.inotify.max_user_instances=1024/g' /etc/sysctl.conf

sed -i 's/.*kernel.msgmnb.*/kernel.msgmnb=65536/g' /etc/sysctl.conf
sed -i 's/.*kernel.msgmax.*/kernel.msgmax=65536/g' /etc/sysctl.conf
sed -i 's/.*kernel.shmmax.*/kernel.shmmax=4294967295/g' /etc/sysctl.conf
sed -i 's/.*kernel.shmall.*/kernel.shmall=268435456/g' /etc/sysctl.conf
sed -i 's/.*kernel.shmmni.*/kernel.shmmni=4096/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.tcp_keepalive_time.*/net.ipv4.tcp_keepalive_time=15/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.tcp_keepalive_intvl.*/net.ipv4.tcp_keepalive_intvl=10/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.tcp_keepalive_probes.*/net.ipv4.tcp_keepalive_probes=5/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.tcp_fin_timeout.*/net.ipv4.tcp_fin_timeout=30/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.tcp_window_scaling.*/net.ipv4.tcp_window_scaling=0/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.tcp_sack.*/net.ipv4.tcp_sack=0/g' /etc/sysctl.conf
sed -i 's/.*net.ipv4.tcp_timestamps.*/net.ipv4.tcp_timestamps=0/g' /etc/sysctl.conf 
sed -i 's/.*vm.swappiness.*/vm.swappiness=10/g' /etc/sysctl.conf 
sed -i 's/.*vm.overcommit_memory.*/vm.overcommit_memory=1/g' /etc/sysctl.conf 



# kill duplicates 
mv -f /etc/sysctl.conf /etc/sysctl.old
cat /etc/sysctl.old | sed 's/ =/=/g' | sed 's/= /=/g' | grep -v -e \# -e ^$ > /etc/sysctl.new
awk '! a[$0]++' /etc/sysctl.new >  /etc/sysctl.conf

# apply new parametrs 
sysctl -p

# file limis
cat > /etc/security/limits.d/nofile.conf << EOL
root      soft    nofile           1048576
root      hard    nofile           1048576
*         soft    nofile           1048576
*         hard    nofile           1048576    
*         hard    core           0
EOL

cat > /etc/security/limits.d/90-nproc.conf << EOL
*       hard    nproc   unlimited
*       soft    nproc   unlimited
root    hard    nproc   unlimited
root    soft    nproc   unlimited
EOL

cat > /etc/security/limits.d/90-stack.conf << EOL
*       hard    stack   unlimited
*       soft    stack   unlimited
root    hard    stack   unlimited
root    soft    stack   unlimited
EOL


sed -i 's/Subsystem/#Subsystem/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

setenforce 0

cat >> /etc/ssh/sshd_config << EOL

Subsystem sftp internal-sftp
Match Group sftpusers
ForceCommand internal-sftp
ChrootDirectory %h
X11Forwarding no
AllowAgentForwarding no
AllowTcpForwarding no
PermitTunnel no

EOL

groupadd sftpusers


systemctl restart sshd
systemctl stop firewalld
systemctl disable firewalld
yum -y update
yum -y install epel-release
yum -y install mc nano net-tools ncdu yum-utils htop iftop python3-certbot-nginx



cat > /etc/yum.repos.d/nginx.repo << EOL

[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/8/x86_64/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/8/x86_64/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
EOL



###Nginx

yum -y module reset nginx
yum -y module enable nginx:mainline

yum -y install nginx
systemctl start nginx
systemctl enable nginx


###php-fpm

yum -y install  https://rpms.remirepo.net/enterprise/remi-release-8.rpm 
yum -y module reset php
yum -y module enable php:remi-7.4
yum -y install php-fpm php-cli php-mysql php-gd php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-pecl-apc  php-mbstring php-mcrypt php-snmp php-soap php-tidy
systemctl start php-fpm
systemctl enable php-fpm



##mariadb


cat > /etc/yum.repos.d/mariadb.repo << EOL
# MariaDB 10.5 CentOS repository list - created 2020-08-07 06:34 UTC
# http://downloads.mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.5/centos8-amd64
module_hotfixes=1
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1

EOL

yum -y install mariadb mariadb-server
systemctl enable mariadb
systemctl start mariadb


