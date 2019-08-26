---
layout:     post
title:      elasticsearch
subtitle:   elasticsearch
date:       2019-08-26
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - elasticsearch
    - linux
---

# 安装

- [elasticsearch](https://www.elastic.co/cn/downloads/elasticsearch)官网下载：https://www.elastic.co/cn/downloads/elasticsearch


# 开始

- 解压

    tar -zxvf elasticsearch-7.3.1.tar.gz 
    mv elasticsearch-7.3.1 elasticsearch

- 创建用户组

    groupadd es

    创建用户，-e代表把es用户分配到es用户组中，-p代表给es用户设置密码为123456：
    useradd es -g es -p 123456

    修改权限
    chown -R es:es /usr/local/elasticsearch

- 安装

    su es
    cd /usr/local/elasticsearch/bin
        

    查看是否运行成功：
    curl http://localhost:9200

# 配置

    vim elasticsearch.yml


    node.name: node-1 
    network.host: 0.0.0.0
    cluster.initial_master_nodes: ["node-1"]

    增加外网访问：
    http.cors.enabled: true
    http.cors.allow-origin: "*"


- 切换root用户

    vim  etc/sysctl.conf 
    
    添加

    vm.max_map_count=655360

    保存后执行

    sysctl -p

    vim /etc/security/limits.conf
    添加

    elasticsearch soft nofile 65536
    elasticsearch hard nofile 65536
    elasticsearch soft nproc 4096
    elasticsearch hard nproc 4096

- 切换es用户 

    重启动
    ./elasticsearch



# 声明
本文只做学习参考，如有任何问题的地方欢迎指正。

我的邮箱：
- ```lulongji2011@163.com```