---
layout:     post
title:      Git服务器搭建
subtitle:   Git
date:       2016-11-21
author:     lulongji
header-img: img/post-bg-2015.jpg
catalog: true
tags:
    - git
    - linux
---

# 安装git
yum install -y git

# 查看版本
git --version

# 服务器端创建git仓库
设置 /var/www/git/haoyisheng.git 为 Git 仓库
mkdir -p /var/www/git/haoyisheng.git

### 初始化git
git init --bare /var/www/git/haoyisheng.git

### 创建用户git 
useradd git
passwd git （haoyisheng123）

### 授权
cd  /var/www/git/    chown -R git:git haoyisheng.git/


### 进入 /etc/ssh 目录，编辑 sshd_config，打开以下三个配置的注释：

RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys

### 保存并重启 sshd 服务：
/etc/rc.d/init.d/sshd restart 或者 service sshd restart 


