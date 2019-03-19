---
layout:     post
title:      CentOs [Install svn & svn command]
subtitle:   svn仓库搭建与svn命令总结
date:       2016-01-26
author:     Lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - svn
    - linux
---

# 介绍
    以下是svn仓库的搭建过程，记录一下。

### 开始
    yum安装方式
    yum -y install subversion

#### 建立版本目录
    mkdir -p /var/www/svndata

#### 创建一个svn项目目录outside
    mkdir -p  /var/www/svndata/outside

#### 创建svn
    svnadmin create /var/www/svndata/outside

#### 配置访问用户
    vi /var/www/svndata/outside/conf/svnserve.conf

    #内容
    anon-access=none    #不允许匿名用户访问
    auth-access=write   #通过验证的用户可以读和写
    password-db=passwd  #/opt/svn/etc/svn-user.conf #可配用户保存文件
    authz-db = authz     #/opt/svn/etc/svn-authz.conf #可配权限管理文件

    vi /var/www/svndata/outside/conf/passwd
    #内容 用户名=密码  （自定义）
    username=password


    #权限
    vi /var/www/svndata/outside/conf/authz

    [groups]
    [/]
    username =rw

#### svn 访问
    svn co svn://ip/outside

#### 服务器开关
    svn服务的关闭：
        killall svnserve
    svn开启：
        svnserve -d -r /var/www/svndata




# 常用命令

    svn list http://svn.test.com/svn     #查看目录中的文件。
    svn list -v http://svn.test.com/svn  #查看详细的目录的信息(修订人,版本号,文件大小等)。
    svn list [-v]                        #查看当前当前工作拷贝的版本库URL。

    svn cat -r 4 test.c     #查看版本4中的文件test.c的内容,不进行比较。

    svn diff         #什么都不加，会坚持本地代码和缓存在本地.svn目录下的信息的不同;信息太多，没啥用处。
    svn diff -r 3          #比较你的本地代码和版本号为3的所有文件的不同。
    svn diff -r 3 text.c   #比较你的本地代码和版本号为3的text.c文件的不同。
    svn diff -r 5:6        #比较版本5和版本6之间所有文件的不同。
    svn diff -r 5:6 text.c #比较版本5和版本6之间的text.c文件的变化。
    svn diff -c 6 test.c    #比较版本5和版本6之间的text.c文件的变化。


    svn log         #什么都不加会显示所有版本commit的日志信息:版本、作者、日期、comment。
    svn log -r 4:20 #只看版本4到版本20的日志信息，顺序显示。
    svn log -r 20:5 #显示版本20到4之间的日志信息，逆序显示。
    svn log test.c  #查看文件test.c的日志修改信息。
    svn log -r 8 -v #显示版本8的详细修改日志，包括修改的所有文件列表信息。
    svn log -r 8 -v -q   #显示版本8的详细提交日志，不包括comment。
    svn log -v -r 88:866 #显示从版本88到版本866之间，当前代码目录下所有变更的详细信息 。
    svn log -v dir  #查看目录的日志修改信息,需要加v。
    svn log http://foo.com/svn/trunk/code/  #显示代码目录的日志信息。

    svn　info　文件名
    例子：
    svn info test.php


    svn add file
    例如：svn add test.php(添加test.php)
    svn add *.php(添加当前目录下所有的php文件)


    svn commit -m “LogMessage“ [-N] [--no-unlock] PATH　(如果选择了保持锁，就使用–no-unlock开关)
    例如：svn commit -m “add test file for my test“ test.php
    简写：svn ci


    svn lock -m “LockMessage“ [--force] PATH
    例如：svn lock -m “lock test file“ test.php
    svn unlock PATH

    svn update -r m path
    例如：
    svn update如果后面没有目录，默认将当前目录以及子目录下的所有文件都更新到最新版本。
    svn update -r 200 test.php(将版本库中的文件test.php还原到版本200)
    svn update test.php(更新，于版本库同步。如果在提交的时候提示过期的话，是因为冲突，需要先update，修改文件，然后清除svn resolved，最后再提交commit)
    简写：svn up



# 说明

本文只做学习参考，如有任何不准确的地方欢迎指正。

我的邮箱：
- ```lulongji2011@163.com```
