---
layout:     post
title:      CentOs之mysql搭建
subtitle:   mysql搭建
date:       2016-06-22
author:     lulongji
header-img: img/post-bg-2015.jpg
catalog: true
tags:
    - mysql
    - linux
---

# 开始
以下是mysql5.7 安装

# 下载yum源
访问MySQL Yum存储库的下载页面，地址为 http://dev.mysql.com/downloads/repo/yum/

# 检测
    rpm -qa | grep mysql

# 卸载
    rpm -e mysql　　//普通删除模式
    rpm -e --nodeps mysql　//强力删除模式，如果使用上面命令删除时，提示有依赖的其它文件，则用该命令可以对其进行强力删除

# 安装5.7源
    wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
    rpm -ivh mysql57-community-release-el7-9.noarch.rpm
 
# 查看可供安装的MySQL版本
    yum repolist all | grep mysql

# 安装
    yum install mysql-server

# 启动MySQL服务器

### 使用以下命令启动MySQL服务器：
    systemctl start mysqld

### 检查MySQL服务器的状态：
    systemctl status mysqld

### 查看日志获取密码
    sudo grep 'temporary password' /var/log/mysqld.log

### 初始化配置
    yum install mariadb-server mariadb 
#### mariadb数据库的相关命令是：
    systemctl start mariadb  #启动MariaDB
    systemctl stop mariadb  #停止MariaDB
    systemctl restart mariadb  #重启MariaDB
    systemctl enable mariadb  #设置开机启动

### 验证 MySQL 安装
    mysqladmin --version

### 通过使用生成的临时密码登录并尽快更改root密码并为超级用户帐户设置自定义密码：
    mysql -uroot -p
    ALTER USER 'root'@'localhost' IDENTIFIED BY '!QAZ2wsx3edc';

# 强制修改密码

- vim /etc/my.cnf
- 在[mysqld]的段中加上一句：```skip-grant-tables```

    [mysqld]
    datadir=/var/lib/mysql
    socket=/var/lib/mysql/mysql.sock
    skip-grant-tables

- 重新启动mysqld 
    service mysqld restart

- 登录并修改MySQL的root密码 
    mysql
    USE mysql;
    
- 修改密码（如果不好使换另外一种）
    update mysql.user set authentication_string=password('123456') where user='root'
    UPDATE user SET Password = password ( ‘new-password’ ) WHERE User = ‘root’ ;
- 刷新并退出
    flush privileges ;
    quit
- 删除刚刚my.conf 配置```skip-grant-tables```
- 重新启动mysqld 

# 实现远程连接(授权法)
- mysql -u root -p
- use mysql;
- grant all privileges  on *.* to root@'%' identified by "!QAZ2wsx3edc";
- flush privileges;

如果不能远程登录，则查看防火墙端口配置

# 更换端口不能启动
    setenforce 0


# Navicat 远程连接mysql乱码

Navicat里右击一个连接，选择连接属性，切换到高级选项卡，去掉“使用mysql字符集”前的对勾，在编码里选择utf-8，这种方法对于部分问题可能适合。如下图所示：

![1](https://raw.githubusercontent.com/lulongji/lulongji.github.io/master/imgs/mysql/mysql1.png)


或者：


![1](https://raw.githubusercontent.com/lulongji/lulongji.github.io/master/imgs/mysql/mysql2.png)



# 删除mysql

    sudo rm /usr/local/mysql
    sudo rm -rf /usr/local/mysql*
    sudo rm -rf /Library/StartupItems/MySQLCOM
    sudo rm -rf /Library/PreferencePanes/My*
    vim /etc/hostconfig  (and removed the line MYSQLCOM=-YES-)
    rm -rf ~/Library/PreferencePanes/My*
    sudo rm -rf /Library/Receipts/mysql*
    sudo rm -rf /Library/Receipts/MySQL*
    sudo rm -rf /var/db/receipts/com.mysql.*






