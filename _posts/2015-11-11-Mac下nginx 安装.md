---
layout:     post
title:      Mac下安装nginx 和管理
subtitle:   安装nginx
date:       2015-11-11
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - nginx
    - mac
---

# 说明
Mac环境需要有brew命令：
- [Mac下brew安装](http://blog.lulongji.cn/2015/11/11/Mac%E4%B8%8Bbrew-%E5%AE%89%E8%A3%85/)

# 安装
    $ brew search nginx

    $ brew install nginx


# 配置说明
    /usr/local/etc/nginx/nginx.conf （配置文件路径）

    /usr/local/var/www （服务器默认路径）

    /usr/local/Cellar/nginx/1.8.0 （安装路径）

# 命令
    nginx -s quit 退出

    nginx -s reload 重新加载

    nginx -t 测试nginx.conf配置


# linux 下nginx常用配置


