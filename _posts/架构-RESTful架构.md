---
layout:     post
title:      RESTful架构
subtitle:   RESTful架构简述
date:       2017-01-19
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - java
    - RESTful
---

# 介绍

REST全称是Representational State Transfer，REST指的是一组架构约束条件和原则。" 如果一个架构符合REST的约束条件和原则，我们就称它为RESTful架构。

# 理解

首先，我们列举一些关键概念并加以解释：

- 资源与URI
- 统一资源接口
- 资源的表述
- 资源的链接
- 状态的转移

### 资源与URI

REST全称是表述性状态转移，那究竟指的是什么的表述? 其实指的就是资源。任何事物，只要有被引用到的必要，它就是一个资源。资源可以是实体(例如手机号码)，也可以只是一个抽象概念(例如价值) 。

要让一个资源可以被识别，需要有个唯一标识，在Web中这个唯一标识就是URI(Uniform Resource Identifier)。
URI既可以看成是资源的地址，也可以看成是资源的名称。如果某些信息没有使用URI来表示，那它就不能算是一个资源， 只能算是资源的一些信息而已。URI的设计应该遵循可寻址性原则，具有自描述性，需要在形式上给人以直觉上的关联。

下面让我们来看看URI设计上的一些技巧:

- 使用_或-来让URI可读性更好

曾经Web上的URI都是冰冷的数字或者无意义的字符串，但现在越来越多的网站使用_或-来分隔一些单词，让URI看上去更为人性化。 例如国内比较出名的开源中国社区，它上面的新闻地址就采用这种风格， 如http://www.oschina.net/news/38119/oschina-translate-reward-plan。

- 使用/来表示资源的层级关系
例如上述/git/git/commit/e3af72cdafab5993d18fae056f87e1d675913d08就表示了一个多级的资源， 指的是git用户的git项目的某次提交记录，又例如/orders/2012/10可以用来表示2012年10月的订单记录。

- 使用?用来过滤资源
很多人只是把?简单的当做是参数的传递，很容易造成URI过于复杂、难以理解。可以把?用于对资源的过滤， 例如/git/git/pulls用来表示git项目的所有推入请求，而/pulls?state=closed用来表示git项目中已经关闭的推入请求， 这种URL通常对应的是一些特定条件的查询结果或算法运算结果。

- 可以用来表示同级资源的关系
有时候我们需要表示同级资源的关系时，可以使用,或;来进行分割。例如哪天github可以比较某个文件在随意两次提交记录之间的差异，或许可以使用/git/git /block-sha1/sha1.h/compare/e3af72cdafab5993d18fae056f87e1d675913d08;bd63e61bdf38e872d5215c07b264dcc16e4febca作为URI。 不过，现在github是使用…来做这个事情的，例如/git/git/compare/master…next。


### 统一资源接口

RESTful架构应该遵循统一接口原则，统一接口包含了一组受限的预定义的操作，不论什么样的资源，都是通过使用相同的接口进行资源的访问。接口应该使用标准的HTTP方法如GET，PUT和POST，并遵循这些方法的语义。

#### GET

    安全且幂等
    获取表示
    变更时获取表示（缓存）
    200（OK） - 表示已在响应中发出
    204（无内容） - 资源有空表示
    301（Moved Permanently） - 资源的URI已被更新
    303（See Other） - 其他（如，负载均衡）
    304（not modified）- 资源未更改（缓存）
    400 （bad request）- 指代坏请求（如，参数错误）
    404 （not found）- 资源不存在
    406 （not acceptable）- 服务端不支持所需表示
    500 （internal server error）- 通用错误响应
    503 （Service Unavailable）- 服务端当前无法处理请求

#### POST

    不安全且不幂等
    使用服务端管理的（自动产生）的实例号创建资源
    创建子资源
    部分更新资源
    如果没有被修改，则不过更新资源（乐观锁）
    200（OK）- 如果现有资源已被更改
    201（created）- 如果新资源被创建
    202（accepted）- 已接受处理请求但尚未完成（异步处理）
    301（Moved Permanently）- 资源的URI被更新
    303（See Other）- 其他（如，负载均衡）
    400（bad request）- 指代坏请求
    404 （not found）- 资源不存在
    406 （not acceptable）- 服务端不支持所需表示
    409 （conflict）- 通用冲突
    412 （Precondition Failed）- 前置条件失败（如执行条件更新时的冲突）
    415 （unsupported media type）- 接受到的表示不受支持
    500 （internal server error）- 通用错误响应
    503 （Service Unavailable）- 服务当前无法处理请求

#### PUT

    不安全但幂等
    用客户端管理的实例号创建一个资源
    通过替换的方式更新资源
    如果未被修改，则更新资源（乐观锁）
    200 （OK）- 如果已存在资源被更改
    201 （created）- 如果新资源被创建
    301（Moved Permanently）- 资源的URI已更改
    303 （See Other）- 其他（如，负载均衡）
    400 （bad request）- 指代坏请求
    404 （not found）- 资源不存在
    406 （not acceptable）- 服务端不支持所需表示
    409 （conflict）- 通用冲突
    412 （Precondition Failed）- 前置条件失败（如执行条件更新时的冲突）
    415 （unsupported media type）- 接受到的表示不受支持
    500 （internal server error）- 通用错误响应
    503 （Service Unavailable）- 服务当前无法处理请求

#### DELETE

    不安全但幂等
    删除资源
    200 （OK）- 资源已被删除
    301 （Moved Permanently）- 资源的URI已更改
    303 （See Other）- 其他，如负载均衡
    400 （bad request）- 指代坏请求
    404 （not found）- 资源不存在
    409 （conflict）- 通用冲突
    500 （internal server error）- 通用错误响应
    503 （Service Unavailable）- 服务端当前无法处理请求


### 资源的表述

上面提到，客户端通过HTTP方法可以获取资源，是吧? 不，确切的说，客户端获取的只是资源的表述而已。 资源在外界的具体呈现，可以有多种表述(或成为表现、表示)形式，在客户端和服务端之间传送的也是资源的表述，而不是资源本身。 例如文本资源可以采用html、xml、json等格式，图片可以使用PNG或JPG展现出来。

资源的表述包括数据和描述数据的元数据，例如，HTTP头"Content-Type" 就是这样一个元数据属性。

那么客户端如何知道服务端提供哪种表述形式呢?

答案是可以通过HTTP内容协商，客户端可以通过Accept头请求一种特定格式的表述，服务端则通过Content-Type告诉客户端资源的表述形式。

### 在URI里边带上版本号

有些API在URI里边带上版本号，例如:

    http://api.example.com/1.0/foo
    http://api.example.com/1.2/foo
    http://api.example.com/2.0/foo

### 使用URI后缀来区分表述格式

当服务器不支持所请求的表述格式，那么应该怎么办？若服务器不支持，它应该返回一个HTTP 406响应，表示拒绝处理该请求。

### 资源的链接

我们知道REST是使用标准的HTTP方法来操作资源的，但仅仅因此就理解成带CURD的Web数据库架构就太过于简单了。
这种反模式忽略了一个核心概念："超媒体即应用状态引擎（hypermedia as the engine of application state）"。

### 状态的转移

有了上面的铺垫，再讨论REST里边的状态转移就会很容易理解了。

不过，我们先来讨论一下REST原则中的无状态通信原则。初看一下，好像自相矛盾了，既然无状态，何来状态转移一说?

其实，这里说的无状态通信原则，并不是说客户端应用不能有状态，而是指服务端不应该保存客户端状态。
