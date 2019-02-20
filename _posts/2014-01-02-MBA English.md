---
layout:     post
title:      English
subtitle:   English
date:       2014-01-01
author:     Lulongji
header-img: img/post-bg-swift2.jpg
catalog: true
tags:
    - Enlish
---


# 英语

>可可英语 
>喜马拉雅


# 单词

>单词派 - 喜马拉雅





# 进阶篇

深度优先和广度优先搜索 
全排列
贪心算法
KMP算法
hash算法
海量数据处理

位运算

    用位运算实现加、减、乘、除、取余

```数据结构```

简单的数据结构

栈、队列、链表、数组、哈希表、

树

    二叉树
    字典树
    平衡树
    排序树
    B树
    B+树
    R树
    多路树
    红黑树


```设计模式```

实现AOP 实现IOC 不用synchronized和lock，实现线程安全的单例模式 nio和reactor设计模式

```网络编程```

tcp、udp、http、https等常用协议

    三次握手与四次关闭、流量控制和拥塞控制、OSI七层模型、tcp粘包与拆包

    http/1.0 http/1.1 http/2之前的区别 Java RMI，Socket，HttpClient cookie 与 session

cookie被禁用，如何实现session

用Java写一个简单的静态文件的HTTP服务器

实现客户端缓存功能，支持返回304 实现可并发下载一个文件 使用线程池处理客户端请求 使用nio处理客户端请求 支持简单的rewrite规则 上述功能在实现的时候需要满足“开闭原则”

了解nginx和apache服务器的特性并搭建一个对应的服务器 用Java实现FTP、SMTP协议 进程间通讯的方式 什么是CDN？如果实现？ 什么是DNS？ 反向代理
框架知识

Servlet线程安全问题 Servlet中的filter和listener Hibernate的缓存机制 Hiberate的懒加载 Spring Bean的初始化 Spring的AOP原理 自己实现Spring的IOC Spring MVC Spring Boot2.0

Spring Boot的starter原理，自己实现一个starter

Spring Security


# 高级篇

新技术

    Java 8

        lambda表达式、Stream API、

    Java 9

        Jigsaw、Jshell、Reactive Streams

    Java 10

        局部变量类型推断、G1的并行Full GC、ThreadLocal握手机制

Spring 5

    响应式编程

Spring Boot 2.0

    性能优化

    使用单例、
    
    使用Future模式、
    
    使用线程池、选择就绪、减少上下文切换、减少锁粒度、数据压缩、结果缓存

    线上问题分析

dump获取

    线程Dump、内存Dump、gc情况

dump分析

    分析死锁、分析内存泄露

自己编写各种outofmemory，stackoverflow程序

    HeapOutOfMemory、 
    Young OutOfMemory、
    MethodArea OutOfMemory、
    ConstantPool OutOfMemory、
    DirectMemory OutOfMemory、
    Stack OutOfMemory Stack OverFlow

常见问题解决思路

    内存溢出、
    线程死锁、
    类加载冲突

使用工具尝试解决以下问题，并写下总结

    当一个Java程序响应很慢时如何查找问题、

    当一个Java程序频繁FullGC时如何解决问题、

    如何查看垃圾回收日志、

    当一个Java应用发生OutOfMemory时该如何解决、

    如何判断是否出现死锁、

    如何判断是否存在内存泄露

编译原理知识

    编译与反编译 
    Java代码的编译与反编译 
    Java的反编译工具 
    词法分析
    语法分析（LL算法，递归下降算法，LR算法）
    语义分析
    运行时环境
    中间代码
    代码生成
    代码优化

操作系统知识

    Linux的常用命令 
    进程同步 
    缓冲区溢出 
    分段和分页 
    虚拟内存与主存

数据库知识

    MySql 执行引擎 
    MySQL 执行计划

    如何查看执行计划，如何根据执行计划进行SQL优化

    SQL优化 事务

    事务的隔离级别
    事务能不能实现锁的功能

    数据库锁

        行锁、
        表锁、
        使用数据库锁实现乐观锁、

    数据库主备搭建 binlog 内存数据库

h2

    常用的nosql数据库

    redis
    memcached

    分别使用数据库锁、
    NoSql实现分布式锁 
    性能调优



大数据知识

    Zookeeper

    基本概念、常见用法

    Solr，Lucene，ElasticSearch

    在linux上部署solr，solrcloud，，新增、删除、查询索引

    Storm，流式计算，了解Spark，S4

    在linux上部署storm，用zookeeper做协调，运行storm hello world，local和remote模式运行调试storm topology。

    Hadoop，离线计算

    HDFS、MapReduce

    分布式日志收集flume，kafka，logstash 数据挖掘，mahout

网络安全知识

什么是XSS

    XSS的防御

什么是CSRF 什么是注入攻击

    SQL注入、XML注入、CRLF注入

什么是文件上传漏洞 加密与解密

    MD5，SHA1、DES、AES、RSA、DSA

什么是DOS攻击和DDOS攻击

    memcached为什么可以导致DDos攻击、什么是反射型DDoS

    SSL、TLS，HTTPS 如何通过Hash碰撞进行DOS攻击 用openssl签一个证书部署到apache或nginx



# 架构篇

分布式

    数据一致性、
    服务治理、
    服务降级

分布式事务

    2PC
    3PC
    CAP
    BASE
    可靠消息最终一致性
    最大努力通知
    TCC

Dubbo

    服务注册、服务发现，服务治理

分布式数据库

    怎样打造一个分布式数据库
    什么时候需要分布式数据库
    mycat
    otter
    HBase
    

分布式文件系统

    mfs
    fastdfs

分布式缓存

    缓存一致性
    缓存命中率
    缓存冗余

微服务

    SOA、
    康威定律
    ServiceMesh Docker & Kubernets Spring Boot Spring Cloud

    高并发

    分库分表 
    CDN技术 
    消息队列

    ActiveMQ

监控

    监控什么

        CPU、内存、磁盘I/O、网络I/O等

监控手段

    进程监控、语义监控、机器资源监控、数据波动

监控数据采集

    日志、埋点

Dapper

负载均衡

tomcat负载均衡、Nginx负载均衡

DNS

    DNS原理、DNS的设计

CDN

数据一致性



# 扩展篇

云计算

    IaaS
    SaaS
    PaaS
    虚拟化技术
    openstack
    Serverlsess

搜索引擎

    Solr
    Lucene
    Nutch
    Elasticsearch

权限管理

    Shiro

区块链

    哈希算法
    Merkle树
    公钥密码算法
    共识算法
    Raft协议
    Paxos 算法与 Raft 算法
    拜占庭问题与算法
    消息认证码与数字签名

比特币

    挖矿
    共识机制
    闪电网络
    侧链
    热点问题
    分叉

以太坊 

    超级账本

人工智能

    数学基础
    机器学习
    人工神经网络
    深度学习
    应用场景。

    常用框架

        TensorFlow
        DeepLearning4J

其他语言

    Groovy
    Python
    Go
    NodeJs
    Swift
    Rust


