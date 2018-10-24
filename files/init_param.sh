#!/bin/bash

if [ $# != 1 ] ; then
echo "please input hostname param!"
exit;
fi

hostname=$1

echo "hostname is:" $hostname

#adduser yun ===================================
mkdir /app
useradd yun -d /app
echo "hisun"|passwd yun --stdin > /dev/null 2>&1
cp /root/.bash*  /app  
mkdir /app/.ssh

echo >> /etc/rc.d/rc.local
echo "ntpdate pool.ntp.org" >> /etc/rc.d/rc.local
echo >> /etc/rc.d/rc.local

cp /etc/sysconfig/network /etc/sysconfig/network_ori_bak
sed -i "s/HOSTNAME=.*/HOSTNAME=$hostname/" /etc/sysconfig/network
hostname $hostname

cp /etc/security/limits.conf /etc/security/limits_conf_ori_bak
echo "# /etc/security/limits.conf" > /etc/security/limits.conf
echo "#">>/etc/security/limits.conf
echo "#Each line describes a limit for a user in the form:">>/etc/security/limits.conf
echo "#">>/etc/security/limits.conf
echo "#<domain>        <type>  <item>  <value>">>/etc/security/limits.conf
echo "#">>/etc/security/limits.conf
echo "#Where:">>/etc/security/limits.conf
echo "#<domain> can be:">>/etc/security/limits.conf
echo "#        - an user name">>/etc/security/limits.conf
echo "#        - a group name, with @group syntax">>/etc/security/limits.conf
echo "#        - the wildcard *, for default entry">>/etc/security/limits.conf
echo "#        - the wildcard %, can be also used with %group syntax,">>/etc/security/limits.conf
echo "#                 for maxlogin limit">>/etc/security/limits.conf
echo "#">>/etc/security/limits.conf
echo "#<type> can have the two values:">>/etc/security/limits.conf
echo "#        - \"soft\" for enforcing the soft limits">>/etc/security/limits.conf
echo "#        - \"hard\" for enforcing hard limits">>/etc/security/limits.conf
echo "#">>/etc/security/limits.conf
echo "#<item> can be one of the following:">>/etc/security/limits.conf
echo "#        - core - limits the core file size (KB)">>/etc/security/limits.conf
echo "#        - data - max data size (KB)">>/etc/security/limits.conf
echo "#        - fsize - maximum filesize (KB)">>/etc/security/limits.conf
echo "#        - memlock - max locked-in-memory address space (KB)">>/etc/security/limits.conf
echo "#        - nofile - max number of open files">>/etc/security/limits.conf
echo "#        - rss - max resident set size (KB)">>/etc/security/limits.conf
echo "#        - stack - max stack size (KB)">>/etc/security/limits.conf
echo "#        - cpu - max CPU time (MIN)">>/etc/security/limits.conf
echo "#        - nproc - max number of processes">>/etc/security/limits.conf
echo "#        - as - address space limit (KB)">>/etc/security/limits.conf
echo "#        - maxlogins - max number of logins for this user">>/etc/security/limits.conf
echo "#        - maxsyslogins - max number of logins on the system">>/etc/security/limits.conf
echo "#        - priority - the priority to run user process with">>/etc/security/limits.conf
echo "#        - locks - max number of file locks the user can hold">>/etc/security/limits.conf
echo "#        - sigpending - max number of pending signals">>/etc/security/limits.conf
echo "#        - msgqueue - max memory used by POSIX message queues (bytes)">>/etc/security/limits.conf
echo "#        - nice - max nice priority allowed to raise to values: [-20, 19]">>/etc/security/limits.conf
echo "#        - rtprio - max realtime priority">>/etc/security/limits.conf
echo "#">>/etc/security/limits.conf
echo "#<domain>      <type>  <item>         <value>">>/etc/security/limits.conf
echo "#">>/etc/security/limits.conf
echo >>/etc/security/limits.conf
echo "#*               soft    core            0">>/etc/security/limits.conf
echo "#*               hard    rss             10000">>/etc/security/limits.conf
echo "#@student        hard    nproc           20">>/etc/security/limits.conf
echo "#@faculty        soft    nproc           20">>/etc/security/limits.conf
echo "#@faculty        hard    nproc           50">>/etc/security/limits.conf
echo "#ftp             hard    nproc           0">>/etc/security/limits.conf
echo "#@student        -       maxlogins       4">>/etc/security/limits.conf
echo "*        soft    core        unlimited">>/etc/security/limits.conf
echo "*        hard    core        unlimited">>/etc/security/limits.conf
echo "*        soft    data        unlimited">>/etc/security/limits.conf
echo "*        hard    data        unlimited">>/etc/security/limits.conf
echo "*        soft    fsize       unlimited">>/etc/security/limits.conf
echo "*        hard    fsize       unlimited">>/etc/security/limits.conf
echo "*        soft    memlock     unlimited">>/etc/security/limits.conf
echo "*        hard    memlock     unlimited">>/etc/security/limits.conf
echo "*        soft    nofile      1024000">>/etc/security/limits.conf
echo "*        hard    nofile      1024000">>/etc/security/limits.conf
echo "*        soft    rss         unlimited">>/etc/security/limits.conf
echo "*        hard    rss         unlimited">>/etc/security/limits.conf
echo "*        soft    stack       unlimited">>/etc/security/limits.conf
echo "*        hard    stack       unlimited">>/etc/security/limits.conf
echo "yun      soft    nproc       102400">>/etc/security/limits.conf
echo "yun      hard    nproc       102400">>/etc/security/limits.conf
echo "*        soft    locks       unlimited">>/etc/security/limits.conf
echo "*        hard    locks       unlimited">>/etc/security/limits.conf
echo "*        soft    sigpending  unlimited">>/etc/security/limits.conf
echo "*        hard    sigpending  unlimited">>/etc/security/limits.conf
echo "*        soft    msgqueue    unlimited">>/etc/security/limits.conf
echo "*        hard    msgqueue    unlimited">>/etc/security/limits.conf
echo >>/etc/security/limits.conf
echo "# End of file">>/etc/security/limits.conf

cp /etc/security/limits.d/90-nproc.conf /etc/security/limits.d/90-nproc_conf_ori_bak
sed -i 's/.*soft    nproc.*/*          soft    nproc     102400/' /etc/security/limits.d/90-nproc.conf

cp /etc/sudoers /etc/sudoers_ori_bak
sed -i "s/Defaults    requiretty$/&\nDefaults:yun !requiretty/g" /etc/sudoers
sed -i "s/Defaults    requiretty$/&\nDefaults:yunwei !requiretty/g" /etc/sudoers
sed -i "s/Defaults    requiretty/#Defaults    requiretty/" /etc/sudoers
sed -i "s/commands anywhere.*$/&\nyunwei  ALL=(ALL)       NOPASSWD:ALL/g" /etc/sudoers

mv /usr/bin/sudo /usr/bin/ccpdo

setenforce 0
cp /etc/selinux/config /etc/selinux/config_ori_bak
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
service iptables stop
chkconfig iptables off
rm -f /etc/sysconfig/iptables
