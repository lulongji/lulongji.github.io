---
layout:     post
title:      CentOs7之Ant安装
subtitle:   Ant
date:       2017-01-01
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - linux
---


# 安装

1. 从http://ant.apache.org 上下载tar.gz版ant
2. 复制到/usr下
3. 解压

    tar -vxzf apahce-ant-1.9.2-bin.tar.gz  

4. 改变权限 

    chown -R yjdabc apahce-ant-1.9.2  
    chown -R :users apahce-ant-1.9.2
    chmod -R +x apahce-ant-1.9.2

5. 修改系统配置文件 vi /etc/profile 

    #set Ant enviroment
    export ANT_HOME=/usr/apache-ant-1.9.2
    export PATH=$PATH:$ANT_HOME/bin

6. 立刻将配置生效 

    source /etc/proifle   
    
7. 测试ant是否生效

    ant -version   