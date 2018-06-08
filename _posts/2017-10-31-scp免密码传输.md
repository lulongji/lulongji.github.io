---
layout:     post
title:      scp免密码传输
subtitle:   scp免密码传输
date:       2017-10-31
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - linux
    - shell
---

# 介绍
最近在写自动化部署脚本，必要scp命令实行远程传输，但是实时输入密码很麻烦，所以加了一个免密码传输方式。

# 场景
这里假设主机A（192.168.1.1）用来获到主机B（192.168.1.2）的文件。

在主机A上执行如下命令来生成配对密钥：
`ssh-keygen -t rsa`

遇到提示回车默认即可，公钥被存到用户目录下.ssh目录，比如root存放在：

`/root/.ssh/id_rsa.pub`

将 .ssh 目录中的 id_rsa.pub 文件复制到 主机B 的 ~/.ssh/ 目录中，并改名为 authorized_keys，
到主机A中执行命令和主机B建立信任，例（假设主机B的IP为:192.168.1.2）：

`scp ~/.ssh/id_rsa.pub 192.168.1.2:/root/.ssh/authorized_keys`

下面就可以用scp、ssh命令不需要密码来获取主机B的文件了
`ssh 192.168.1.2 回车就不需要密码了。`

注：其实id_rsa.pub内容添加到对方机器的authorized_keys中就行了。