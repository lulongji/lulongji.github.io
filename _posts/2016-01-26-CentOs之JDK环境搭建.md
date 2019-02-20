---
layout:     post
title:      CentOs [Install jdk]
subtitle:   Jdk环境搭建
date:       2016-01-26
author:     Lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - svn
    - linux
---

# 介绍
    CentOs环境下jdk搭建过程，记录一下。

# 开始
目前使用jdk一定要用oracle版本的，不要使用openJdk，oracle官网 [http://www.oracle.com/](http://www.oracle.com/)

![1](https://raw.githubusercontent.com/lulongji/lulongji.github.io/master/imgs/jdk/1.png)
![2](https://raw.githubusercontent.com/lulongji/lulongji.github.io/master/imgs/jdk/2.png)
![3](https://raw.githubusercontent.com/lulongji/lulongji.github.io/master/imgs/jdk/3.png)
![4](https://raw.githubusercontent.com/lulongji/lulongji.github.io/master/imgs/jdk/4.png)
![5](https://raw.githubusercontent.com/lulongji/lulongji.github.io/master/imgs/jdk/5.png)

# 根据需求下载相应jdk版本
    wget http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz

# 解压
    tar txvf jdk-8u171-linux-x64.tar.gz

# 环境变量
    vim /etc/profile

```
    export JAVA_HOME=/usr/local/jdk-8u171-linux-x64
    export JRE_HOME=$JAVA_HOME/jre
    export CLASSPATH=$JAVA_HOME/lib/:$JAVA_HOME/lib/jer/lib:$CLASSPATH
    export PATH=${JAVA_HOME}/bin:$PATH
```
# 执行生效
    source /etc/profile

# 查看安装
    java -version

# 打赏

###### 微信

![微信](https://hys-parent.oss-cn-beijing.aliyuncs.com/test/wx1.png?x-oss-process=style/test)

###### 支付宝

![支付宝](https://hys-parent.oss-cn-beijing.aliyuncs.com/test/zfb1.png?x-oss-process=style/test)


