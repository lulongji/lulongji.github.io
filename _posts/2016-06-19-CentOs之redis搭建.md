---
layout:     post
title:      CentOs [Install redis]
subtitle:   Redis搭建
date:       2016-06-19
author:     lulongji
header-img: img/post-bg-2015.jpg
catalog: true
tags:
    - redis
    - linux
---

# 环境安装

### 配置编译环境：
    sudo yum install gcc-c++
    
### 下载源码：
    wget http://download.redis.io/releases/redis-3.2.8.tar.gz

    其他版本查看：http://download.redis.io/releases/

### 解压源码：
    tar -zxvf redis-3.2.8.tar.gz

### 进入到解压目录：
    cd redis-3.2.8

### 执行make编译Redis：
    make MALLOC=libc

### 注意：make命令执行完成编译后，会在src目录下生成6个可执行文件，分别是
    redis-server、redis-cli、redis-benchmark、          
    redis-check-aof、redis-check-rdb、redis-sentinel。

### 安装Redis：
    make install 
    
### 配置Redis能随系统启动:
    ./utils/install_server.sh

### 显示结果信息如下：
    Welcome to the redis service installer
    This script will help you easily set up a running redis server

    Please select the redis port for this instance: [6379] 
    Selecting default: 6379
    Please select the redis config file name [/etc/redis/6379.conf] 
    Selected default - /etc/redis/6379.conf
    Please select the redis log file name [/var/log/redis_6379.log] 
    Selected default - /var/log/redis_6379.log
    Please select the data directory for this instance [/var/lib/redis/6379] 
    Selected default - /var/lib/redis/6379
    Please select the redis executable path [/usr/local/bin/redis-server] 
    Selected config:
    Port           : 6379
    Config file    : /etc/redis/6379.conf
    Log file       : /var/log/redis_6379.log
    Data dir       : /var/lib/redis/6379
    Executable     : /usr/local/bin/redis-server
    Cli Executable : /usr/local/bin/redis-cli
    Is this ok? Then press ENTER to go on or Ctrl-C to abort.
    Copied /tmp/6379.conf => /etc/init.d/redis_6379
    Installing service...
    Successfully added to chkconfig!
    Successfully added to runlevels 345!
    Starting Redis server...
    Installation successful!


### Redis服务查看、开启、关闭:
``` a.通过ps -ef|grep redis命令查看Redis进程```
```b.开启Redis服务操作通过/etc/init.d/redis_6379 start命令，也可通过（service redis_6379 start）```
```c.关闭Redis服务操作通过/etc/init.d/redis_6379 stop命令，也可通过（service redis_6379 stop）```

### 配置redis 远程连接 vim redis.conf
- 1.bind 127.0.0.1改为 #bind 127.0.0.1
- 2.protected-mode yes 改为 protected-mode no

### 去掉密码连接redis-cli
    config set requirepass 123456

### 如果远程链接还是不行，请查看防火墙端口



# redis命令

Redis默认的配置会生成db0~db15共16个db，切分出16个db的一个作用是方便不同项目使用不同的db，防止的数据混淆，也为了方便数据查看



基本命令：

flushdb命令清除数据，只会清除当前的数据库下的数据，不会影响到其他数据库。

flushall命令会清除这个实例的数据。在执行这个命令前要格外小心。


auth password
　　有时候处于安全性考虑，我们可以使用密码来保护redis服务器，每次连接需要使用auth命令解锁后才可以使用其他的redis命令，不过即便有密码保护，还是不建议把redis暴露出去，因为根据redis的高性能特点，任然可以通过密码猜测攻击来猜测密码。我们可以通过config set requirepass password命令来设置密码，如：config set requirepass 123456这是就把密码设置为123456，下次执行redis的其他命令之前，你就需要使用auth 123456验证后再进行登录，至于config的讲解，会在下章的服务器配置中进行介绍。

echo mseeage
　　输出一段信息，比如echo 123时客户端会输出123，说是用于测试，目前我还没有想到此命令的作用。 

ping
　　用于测试服务器的连通性，如果服务器运行正常的话，会返回一个pong，若是客户端连接异常，会返回一个异常，感觉这个pong很有意思，不知道是什么梗。

quit
　　请求服务器关闭与当前客户端的连接，当所有等待中的回复顺利写入到客户端，连接就会关闭。 

select index
　　redis的数据库默认有16个，从db0到db15，默认使用0号数据库，如果我们想进行切换，直接使用select命令即可，如select 1就将数据库切换到了db1，执行完此命令后，后续命令均在db1中进行操作，如果你想切回0号数据库再使用select 0即可。


