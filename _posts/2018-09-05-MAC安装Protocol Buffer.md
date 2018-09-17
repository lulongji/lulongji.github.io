---
layout:     post
title:      Protocol Buffer安装
subtitle:   Protocol Buffer
date:       2018-09-05
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
   - mac
   - Protocol Buffer
---

# 介绍

目前公司im模块需要使用Protocol Buffer作为数据传输，所以在网上查了一下，什么情况下选择使用Protocol Buffer，为什么不选择Json、xml？

```传输数据量大 & 网络环境不稳定 的数据存储、RPC 数据交换 的需求场景```

```
    Protobuf拥有多项比XML更高级的串行化结构数据的特性，Protobuf：

    · 更简单

    · 小3-10倍

    · 快20-100倍

    · 更少的歧义

    · 可以方便的生成数据存取类

```

在什么场景下使用：

```如 即时IM （QQ、微信）的需求场景```

- Protobuf 优点

1. 比XML更简洁、高效

2. 跨平台、跨语言

3. 向下兼容、易升级

4. 代码自动生成、不用手写

- Protobuf 缺点

1. 应用不够广

2. 二进制格式导致可读性差

3. 缺乏自描述


# 安装

### 下载Protocol Buffer

[官网下载：https://github.com/protocolbuffers/protobuf/releases/tag/v2.6.1](https://github.com/protocolbuffers/protobuf/releases/tag/v2.6.1)

### 安装 HOMEBREW（已安装的可以跳过）

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


### 安装 Protocol Buffer

- 安装依赖

    brew install autoconf automake libtool curl

- 开始安装

    cd Desktop/protobuf-2.6.1
    // Step2：进入 Protocol Buffer安装包 解压后的文件夹（我的解压文件放在桌面）

    ./autogen.sh
    // Step3：运行 autogen.sh 脚本

    ./configure
    // Step4：运行 configure.sh 脚本

    make
    // Step5：编译未编译的依赖包

    make check
    // Step6：检查依赖包是否完整

    make install
    // Step7：开始安装Protocol Buffer



### 检查 Protocol Buffer 是否安装成功

    protoc --version


# 使用


    //生成Java类
    protoc --java_out=./ JianshuUserMsg.proto


``` 注意空格```



