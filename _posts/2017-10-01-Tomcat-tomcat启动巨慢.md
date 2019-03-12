---
layout:     post
title:      Tomcat [Very slow startup]
subtitle:   tomcat启动特别慢
date:       2017-10-01
author:     Lulongji
header-img: img/post-bg-blog.jpg
catalog: true
tags:
    - tomcat
---


# 问题

这两天由于公司有个新项目，所以在阿里云购买了一些新的服务器，环境搭建完成之后，启动tomcat的时候发现巨慢。
![图一](https://raw.githubusercontent.com/lulongji/lulongji.github.io/master/imgs/tomcat/1.jpg)

![图二](https://raw.githubusercontent.com/lulongji/lulongji.github.io/master/imgs/tomcat/2.jpg)

可以看到启动的毫秒数有多久...

# 分析

**为了找出原因，首先打印日志，把log4j2的日志层级全都打印了出来，但是没有发现有报错信息。之后我查看了一下启动进程，发现进程是启动了的，所以排除jvm退出引起的。那么，为什么程序会被阻塞呢？继续分析，我排除了CPU、内存不足引起的问题，排除了硬盘空间不足引起的问题，天呐‼️ 还是没有找到原因，接着分析，同一个环境在其他的服务器上是正常的（搭建的集群），所以几乎可以确定是linux服务器的原因。**

_确定是linux系统的原因，那么有一个命令`strace` ,于是Google一下它的用法。_

	'' -c 统计每一系统调用的所执行的时间,次数和出错的次数等. 
	'' -d 输出strace关于标准错误的调试信息. 
	'' -f 跟踪由fork调用所产生的子进程. 
	'' -ff 如果提供-o filename,则所有进程的跟踪结果输出到相应的filename.pid中,pid是各进程的进程号. 
	'' -F 尝试跟踪vfork调用.在-f时,vfork不被跟踪. 
	'' -h 输出简要的帮助信息. 
	'' -i 输出系统调用的入口指针. 
	'' -q 禁止输出关于脱离的消息. 
	'' -r 打印出相对时间关于,,每一个系统调用. 
	'' -t 在输出中的每一行前加上时间信息. 
	'' -tt 在输出中的每一行前加上时间信息,微秒级. 
	'' -ttt 微秒级输出,以秒了表示时间. 
	'' -T 显示每一调用所耗的时间. 
	'' -v 输出所有的系统调用.一些调用关于环境变量,状态,输入输出等调用由于使用频繁,默认不输出. 
	'' -V 输出strace的版本信息. 
	'' -x 以十六进制形式输出非标准字符串 
	'' -xx 所有字符串以十六进制形式输出. 
	'' -a column 
	'' 设置返回值的输出位置.默认 为40. 
	'' -e expr 
	'' 指定一个表达式,用来控制如何跟踪.格式如下: 
	'' [qualifier=][!]value1[,value2]... 
	'' qualifier只能是 trace,abbrev,verbose,raw,signal,read,write其中之一.value是用来限定的符号或数字.默认的 qualifier是 trace.感叹号是否定符号.例如: 
	'' -eopen等价于 -e trace=open,表示只跟踪open调用.而-etrace!=open表示跟踪除了open以外的其他调用.有两个特殊的符号 all 和 none. 
	'' 注意有些shell使用!来执行历史记录里的命令,所以要使用\\. 
	'' -e trace=set 
	'' 只跟踪指定的系统 调用.例如:-e trace=open,close,rean,write表示只跟踪这四个系统调用.默认的为set=all. 
	'' -e trace=file 
	'' 只跟踪有关文件操作的系统调用. 
	'' -e trace=process 
	'' 只跟踪有关进程控制的系统调用. 
	'' -e trace=network 
	'' 跟踪与网络有关的所有系统调用. 
	'' -e strace=signal 
	'' 跟踪所有与系统信号有关的 系统调用 
	'' -e trace=ipc 
	'' 跟踪所有与进程通讯有关的系统调用 
	'' -e abbrev=set 
	'' 设定 strace输出的系统调用的结果集.-v 等与 abbrev=none.默认为abbrev=all. 
	'' -e raw=set 
	'' 将指 定的系统调用的参数以十六进制显示. 
	'' -e signal=set 
	'' 指定跟踪的系统信号.默认为all.如 signal=!SIGIO(或者signal=!io),表示不跟踪SIGIO信号. 
	'' -e read=set 
	'' 输出从指定文件中读出 的数据.例如: 
	'' -e read=3,5 
	'' -e write=set 
	'' 输出写入到指定文件中的数据. 
	'' -o filename 
	'' 将strace的输出写入文件filename 
	'' -p pid 
	'' 跟踪指定的进程pid. 
	'' -s strsize 
	'' 指定输出的字符串的最大长度.默认为32.文件名一直全部输出. 
	'' -u username 
	'' 以username 的UID和GID执行被跟踪的命令


**我用的是 strace -f -o strace.out ./catalina.sh run 命令。这样我们就能找到在哪一块被阻塞了。 strace 非常聪明它不仅仅给出了System Call还给出了传递的参数和返回值，read读取的是51号文件句柄，没有返回成功(unfinished)。 顺着这条路，我们看一下51号文件句柄是什么 /dev/random 是Linux下的随机函数生成器，读取它相当于生成随机数字。Google 一下终于知道原因了。**

### 结论

_其中Tomcat 的SessionId 是通过 SHA1算法计算得到的，在计算sessionId的时候必须有个秘钥，而这个秘钥就是随机数生成器生成的，所以现在有两种解决办法了。_

#### 第一种：通过修改Tomcat启动文件
    修改Tomcat启动文件catalina.sh文件中加入 此行代码
	`-Djava.security.egd=file:/dev/urandom`

#### 第二种：通过修改JRE中的
    `$JAVA_PATH/jre/lib/security/java.security`文件 
	`securerandom.source=file:/dev/urandom`

 **当然，前两种办法肯定不可靠，我的开发生涯中几乎没有这么改过tomcat的，再说jvm开发人员又不是二百五，他们没有选择`/dev/urandom` 肯定是有原因的，于是Google了一下，大略就是安全性的问题，如有兴趣可以自己去查看。那么第三种解决办法呼之欲出，那就是增增大/dev/random的熵池。** 

问题的原因是由于熵池不够大，所以增大它是最彻底的方法

#### 第三种：增大熵池

-         查看熵池大小：`cat /proc/sys/kernel/random/entropy_avail`
-         查看cpu是否支持：`cat /proc/cpuinfo | grep rdrand`
-             一般都支持，如果不支持就用`/dev/unrandom`来做“熵源”。以Centos7为例：
1.             `yum install rngd-tools`
2.             `systemctl start rngd`
3.             `cp /usr/lib/systemd/system/rngd.service /etc/systemd/system`
4.             编辑 `/etc/systemd/system/rngd.service` service小结， `ExecStart=/sbin/rngd -f -r /dev/urandom`
5.             `systemctl daemon-reload` 重新载入服务
6.             `systemctl restart rngd `重启服务



