---
layout:     post
title:      Centos之RabbitMQ搭建
subtitle:   RabbitMQ搭建
date:       2019-01-03
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - RabbitMQ
---

# 安装

- RabbitMQ使用erlang语言开发（想要了解的可以自行google），所以我们首先安装erlang.

    rpm -Uvh http://www.rabbitmq.com/releases/erlang/erlang-18.1-1.el7.centos.x86_64.rpm 


- 安装RabbitMQ-Server

    rpm -Uvh 
    http://www.rabbitmq.com/releases/rabbitmq-server/v3.5.6/rabbitmq-server-3.5.6-1.noarch.rpm


- rpm -qa|grep rabbitmq 命令查看是否已经安装ok。


# 常用的命令

    service rabbitmq-server start
    service rabbitmq-server restart
    service rabbitmq-server stop
    rabbitmqctl status  # 查看状态

# 安装命令维护插件

    rabbitmq-plugins enable rabbitmq_management

# 开启远程访问

    #cd /etc/rabbitmq  
    #cp /usr/share/doc/rabbitmq-server-3.5.6/rabbitmq.config.example /etc/rabbitmq/   
    #mv rabbitmq.config.example rabbitmq.config 

    #vim /etc/rabbitmq/rabbitmq.config


在rabbitmq.config中添加   {loopback_users, []}或者将  %% {loopback_users, []}, 修改为 {loopback_users, []}   （修改时注意后面有个逗号要删掉）



通过在浏览器访问 http://ip:15672 时，进入一个管理界面,这样，我们就完成了RabbitMQ的安装。



