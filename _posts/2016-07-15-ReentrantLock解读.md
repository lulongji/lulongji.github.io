---
layout:     post
title:      ReentrantLock 
subtitle:   ReentrantLock
date:       2016-07-15
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - java
    - ReentrantLock
---

# 说明

在java中实现锁的方式有两种，一种是synchronized关键字，另一种是Lock。Lock的实现主要有ReentrantLock、ReadLock和WriteLock，后两者接触的不多，所以简单分析一下ReentrantLock的实现和运行机制。


# ReentrantLock
ReentrantLock是基于AQS实现的，AQS的基础又是[CAS]()。

### AbstractQueuedSynchronizer

ReentrantLock实现的前提就是```AbstractQueuedSynchronizer```，简称AQS，是```java.util.concurrent```的核心.AQS是基于FIFO队列的实现，因此必然存在一个个节点，Node就是一个节点，Node里面有：





