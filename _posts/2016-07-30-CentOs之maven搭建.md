---
layout:     post
title:      CentOs [Install maven]
subtitle:   CentOs之Maven搭建
date:       2016-07-30
author:     lulongji
header-img: img/post-bg-2015.jpg
catalog: true
tags:
    - maven
    - linux
---

# 下载

wget http://mirrors.hust.edu.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

# 解压

    tar -xvf apache-maven-3.3.9-bin.tar.gz

# 环境变量

    vim /etc/profile

    export MAVEN_HOME=/usr/local/apache-maven-3.3.9
    export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$MAVEN_HOME/bin:$PATH

# 生效

    source /etc/profile

