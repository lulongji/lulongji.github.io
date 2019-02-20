---
layout:     post
title:      RabbitMQ
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

    # 查看当前所有用户
    $ sudo rabbitmqctl list_users
    
    # 查看默认guest用户的权限
    $ sudo rabbitmqctl list_user_permissions guest
    
    # 由于RabbitMQ默认的账号用户名和密码都是guest。为了安全起见, 先删掉默认用户
    $ sudo rabbitmqctl delete_user guest
    
    # 添加新用户
    $ sudo rabbitmqctl add_user username password
    
    # 设置用户tag
    $ sudo rabbitmqctl set_user_tags username administrator
    
    # 赋予用户默认vhost的全部操作权限
    $ sudo rabbitmqctl set_permissions -p / username ".*" ".*" ".*"
    
    # 查看用户的权限
    $ sudo rabbitmqctl list_user_permissions username

# 安装命令维护插件

    rabbitmq-plugins enable rabbitmq_management

# 开启远程访问

    #cd /etc/rabbitmq  
    #cp /usr/share/doc/rabbitmq-server-3.5.6/rabbitmq.config.example /etc/rabbitmq/   
    #mv rabbitmq.config.example rabbitmq.config 

    #vim /etc/rabbitmq/rabbitmq.config


在rabbitmq.config中添加   {loopback_users, []}或者将  %% {loopback_users, []}, 修改为 {loopback_users, []}   （修改时注意后面有个逗号要删掉）

    #只允许admin用户本机访问
    {loopback_users, ["admin"]}

    
# 端口

记得要开放5672和15672端口


    /sbin/iptables -I INPUT -p tcp --dport 5672 -j ACCEPT
    /sbin/iptables -I INPUT -p tcp --dport 15672 -j ACCEPT


通过在浏览器访问 http://ip:15672 时，进入一个管理界面,这样，我们就完成了RabbitMQ的安装。



