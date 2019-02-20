---
layout:     post
title:      SpringBoot[redis]
subtitle:   打包跳过测试、redis集成
date:       2018-05-02
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - SpringBoot
    - Spring
---


# 说明
在部署项目打包的时候，往往要调过测试```mvn package -Dmaven.test.skip=true```，但是在程序每次打包的时候输入这么多会很麻烦，所以修改一下配置，使其调过test

### 加入如下代码

    <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
        <configuration>
            <finalName>***</finalName>
            <mainClass>***</mainClass>
        </configuration>
        <executions>
            <execution>
            <goals>
                <goal>repackage</goal>
            </goals>
            </execution>
        </executions>
    </plugin>


在```<project>标签下的<properties>```标签中加入```<skipTests>true</skipTests>```


# redis集成

### pom
        <!--redis-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>

### 配置文件
配置springboot的redis环境  application.yml 文件中：

    application:
        name: spring-boot-redis
    redis:
        database: 0
        ip: 192.168.6.205
        pwd:
        port: 6379
        # 连接超时时间 单位 ms（毫秒）
        timeout: 20000
        #cluster:
        #nodes: 192.168.211.134:7000,192.168.211.134:7001,192.168.211.134:7002
        #maxRedirects: 6

        #################redis线程池设置#################
        # 连接池中的最大空闲连接，默认值也是8。
        pool:
        maxIdle:  150
        #连接池中的最小空闲连接，默认值也是0。
        minIdle: 100
        # 如果赋值为-1，则表示不限制；如果pool已经分配了maxActive个jedis实例，则此时pool的状态为exhausted(耗尽)。
        maxActive: 1024
        # 等待可用连接的最大时间，单位毫秒，默认值为-1，表示永不超时。如果超过等待时间，则直接抛出JedisConnectionException
        max-wait: 1000
        #多长时间检查一次连接池中空闲的连接
        maxTotal: 150
        #当池内没有返回对象时，最大等待时间
        maxWait: 7000
        #当调用borrowObject方法时，是否进行有效性检查
        testOnBorrow: true
        #重新连接重试次数
        reconnectRetryCount: 50
        #重连等待时间
        reconnectRetryWaittime: 7000

### 启动
springboot集成redis有两种方式，为了使用方便，直接把原来封装直接拿过来用，在启动文件直接引用redis配置就行了：

    @ImportResource(locations = {"classpath:spring/spring-redis.xml"})
    public class DemoApplication {

        public static void main(String[] args) {

            SpringApplication.run(DemoApplication.class, args);
        }
    }

到此我们的redis就配置好了。


# 项目源码
```https://github.com/lulongji/springboot-demo.git```
