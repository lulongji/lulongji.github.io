---
layout:     post
title:      CentOs [Install nginx]
subtitle:   安装Nginx
date:       2016-01-12
author:     Lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - nginx
    - linux
---

# 准备

### 编译环境gcc g++ 开发库之类的需要提前装好:

    yum -y install make zlib zlib-devel gcc-c++ libtool  openssl openssl-devel

### 首先安装PCRE  pcre功能是让nginx有rewrite功能:

下载PCRE：

    wget http://downloads.sourceforge.net/project/pcre/pcre/8.35/pcre-8.35.tar.gz

解压安装包：

    tar zxvf pcre-8.35.tar.gz

进入安装包目录：

    cd pcre-8.35

编译：

    ./configure

安装：

    make && make install

　　查看安装版本：

    pcre-config --version  

 如果出现版本号，说明安装成功


# 安装nginx

下载nginx：

    wget http://nginx.org/download/nginx-1.6.2.tar.gz

解压安装包： 
    
    tar zxvf nginx-1.6.2.tar.gz

进入安装包目录：

    cd nginx-1.6.2

编译安装，默认地址 /usr/local/nginx：

    ./configure  

也可以自定义编译：

    ./configure --prefix=/usr/local/webserver/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre=/usr/local/src/pcre-8.35

安装：

    make && make install 


# 检测

    /usr/local/nginx/sbin/nginx -t


# https

[https://www.jianshu.com/p/9f756dbc39d4](https://www.jianshu.com/p/9f756dbc39d4)
    


# 说明

本文只做学习参考，如有任何不准确的地方欢迎指正。

我的邮箱：
- ```lulongji2011@163.com```



