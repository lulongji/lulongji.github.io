---
layout:     post
title:      CentOs之telnet命令
subtitle:   telnet命令
date:       2016-01-10
author:     Lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - telnet
    - mac 
    - linux
---

# 安装

### 检测
    telnet localhost 

### 查找rpm包
    rpm -qa | grep telnet  
    rpm -qa xinetd

### yum安装telnet-server服务
    yum list |grep telnet
    yum install telnet-server.x86_64  
    yum install telnet.x86_64

### 检测
    rpm -qa | grep telnet
    rpm -qa xinetd 

### 安装 xinetd
    yum list |grep xinetd
    yum install xinetd.x86_64

### 加入开机启动
    systemctl enable xinetd.service
    systemctl enable telnet.socket

### 重启
    systemctl start telnet.socket
    systemctl start xinetd
    （或service xinetd start）
    

# 打赏

###### 微信

![微信](https://hys-parent.oss-cn-beijing.aliyuncs.com/test/wx1.png?x-oss-process=style/test)

###### 支付宝

![支付宝](https://hys-parent.oss-cn-beijing.aliyuncs.com/test/zfb1.png?x-oss-process=style/test)
