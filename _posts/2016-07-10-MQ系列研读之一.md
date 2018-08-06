---
layout:     post
title:      MQ系列研读之一
subtitle:   MQ系列介绍和比较分析
date:       2016-07-10
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - linux
    - MQ
---

# 介绍

 MQ全称为Message Queue, 消息队列（MQ）是一种应用程序对应用程序的通信方法。MQ是消费-生产者模型的一个典型的代表，一端往消息队列中不断写入消息，而另一端则可以读取队列中的消息。常用MQ有RabbitMQ、ZeroMQ、ActiveMQ、Kafka、RocketMQ等。


# MQ使用场景
MQ使用场景。

### 异步通信
有些业务不需要立即处理的可以放入消息队列等待处理。

### 解耦
降低工程之间的强度依赖，如事物补偿机制。

### 冗余
规避数据丢失、数据安全保存。

### 扩展性
解耦的过程中，便于分布式扩容。

### 过载保护
在超负荷的突发访问情况加，消息队列可以顶住访问压力。

### 可恢复性
一个系统挂掉，不影响整个系统。降低了进程之间的耦合度，既一个消息挂掉后，在系统恢复后仍然可以继续处理。

### 顺序保证
有些场景需要按顺序处理、大部分消息队列本来就是排序的。

### 缓冲
消息队列可以通过缓冲层来帮助系统高效运行。


### 数据流处理
消息队列对海量数据的收集处理。


# MQ原理

### MQ模型
##### Pub/Sub发布订阅（广播）
使用topic作为通信载体。

##### PTP点对点
使用queue作为通信载体。

### MQ组成
- Broker: 消息服务器、作为server提供消息的唯一服务。
- Producer: 消费生产者，业务的发起方，负责生产消息传输给Broker。
- Consumer: 消息消费者，业务的处理方，负责从Broker中获取消息并处理相关业务逻辑。
- Topic: 主题，发布订阅模式下的消息统一汇集地，不同生产者向topic发送消息，由MQ服务器分发到不同的订阅者，实现消息的广播。
- Queue: 队列，PTP模式下，特定生产者向特定queue发送消息，消费者订阅特定的queue完成指定消息的接收。
- Message: 消息体，根据不同的通讯协议定义的固定格式进行编码的数据包，来封装业务数据，实现消息传输。

# MQ常用协议

### AMQP协议
AMQP即Advanced Message Queuing Protocol,一个提供统一消息服务的应用层标准高级消息队列协议,是应用层协议的一个开放标准,为面向消息的中间件设计。基于此协议的客户端与消息中间件可传递消息，并不受客户端/中间件不同产品，不同开发语言等条件的限制。

- 优点：可靠、通用

### MQTT协议

MQTT（Message Queuing Telemetry Transport，消息队列遥测传输）是IBM开发的一个即时通讯协议，有可能成为物联网的重要组成部分。该协议支持所有平台，几乎可以把所有联网物品和外部连接起来，被用来当做传感器和致动器（比如通过Twitter让房屋联网）的通信协议。

- 优点：格式简洁、占用带宽小、移动端通信、PUSH、嵌入式系统

### STOMP协议

STOMP（Streaming Text Orientated Message Protocol）是流文本定向消息协议，是一种为MOM(Message Oriented Middleware，面向消息的中间件)设计的简单文本协议。STOMP提供一个可互操作的连接格式，允许客户端与任意STOMP消息代理（Broker）进行交互。

- 优点：命令模式（非topic/queue模式）

### XMPP协议

XMPP（可扩展消息处理现场协议，Extensible Messaging and Presence Protocol）是基于可扩展标记语言（XML）的协议，多用于即时消息（IM）以及在线现场探测。适用于服务器之间的准即时操作。核心是基于XML流传输，这个协议可能最终允许因特网用户向因特网上的其他任何人发送即时消息，即使其操作系统和浏览器不同。

- 优点：通用公开、兼容性强、可扩展、安全性高，但XML编码格式占用带宽大


### TCP/IP协议

有些特殊框架（如：redis、kafka、zeroMq等）根据自身需要未严格遵循MQ规范，而是基于TCP/IP自行封装了一套协议，通过网络socket接口进行传输，实现了MQ的功能。

# MQ选型比较

### RabbitMQ

- Erlang编写
- 开源
- 支持协议：AMQP，XMPP, SMTP, STOMP

总结：对路由(Routing)，负载均衡(Load balance)、数据持久化都有很好的支持；非常重量级，更适合于企业级的开发.

### ZeroMQ
又称ØMQ、0MQ、ZMQ.

- 号称最快的消息队列。
- 专门为高吞吐量/低延迟的场景设计。
- 偏重于实时数据通信场景。
- 常用于金融界。
- ZMQ能够实现RabbitMQ不擅长的高级/复杂的队列，但是开发人员需要自己组合多种技术框架，开发成本高。
- 仅提供非持久性的队列，如果down机，数据将会丢失。

等等。


### ActiveMQ

- Apache下的一个子项目。
- 少量代码就可以高效地实现高级应用场景。
- 可插拔的传输协议支持。

### Redis

- 支持MQ功能
- 可以当做一个轻量级的队列服务来使用

比较：对于RabbitMQ和Redis的入队和出队操作，各执行100万次，每10万次记录一次执行时间。测试数据分为128Bytes、512Bytes、1K和10K四个不同大小的数据。实验表明：入队时，当数据比较小时Redis的性能要高于RabbitMQ，而如果数据大小超过了10K，Redis则慢的无法忍受；出队时，无论数据大小，Redis都表现出非常好的性能，而RabbitMQ的出队性能则远低于Redis。

### Kafka

- Apache下的一个子项目。
- scala实现。
- 分布式Publish/Subscribe消息队列。
- 快速持久化
- 高吞吐
- 高堆积
- 支持Hadoop数据并行加载


### RocketMQ

- 阿里系下开源
- 参照kafka设计思想，使用java实现
- 能够保证严格的消息顺序
- 提供针对消息的过滤功能
- 提供丰富的消息拉取模式
- 高效的订阅者水平扩展能力
- 实时的消息订阅机制
- 亿级消息堆积能力



网上的比较图（参考）：

![1](https://raw.githubusercontent.com/lulongji/lulongji.github.io/master/imgs/mq/mq.png)





