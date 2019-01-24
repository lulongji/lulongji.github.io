---
layout:     post
title:      SpringCloud搭建系列二
subtitle:   注册中心
date:       2018-06-02
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - SpringCloud
    - Spring
---


# 注册中心

1. 微服务的搭建必然会用到注册中心，注册中心是微服务最主要的基础服务器之一。为什么会用到注册中心呢？它的作用就是记录服务与服务地址的映射关系，在微服务框架中，当服务需要调用其他服务时就需要到注册中心去寻找相应的地址进行调用。（主要是服务的发现服务的注册）

2. 目前主流的注册中有Redis、Zookeeper、Spring Cloud Netflix Eureka、Spring Cloud Consul等。下面可以看一下Zookeeper 和 Eureka 两个代表类型的注册中心的差异和使用。

CAP理论说明一个分布式系统不可能同时满足C(一致性)、A(可用性)和P(分区容错性)这三个条件，所以从微服务来讲必须要满足分区容错性，所以只能选择CP 或者 AP的方式进行权衡了。Zookpeer 保证CP， Eureke保证了AP。

# Zookeeper

zookeeper通过选举机制保证注册中心的一致性。

    基本运转流程：
        选举leader；
        同步数据；
        选举leader过程中算法有很多（抢主算法有三种），但要达到的选举标准是一致的；
        leader要有更高的zxid；
        集群中大多数的机器得到响应并follow选出的leader。

但是会有一种情况，当master节点因为网络等原因发生故障与其它的节点失联，剩余的节点就会重新选取leader，当leader选举期间（约30 ~ 120s）整个集群是不可用的，这就导致在选举期间注册服务瘫痪。
所以zookeeper有很多优点也一定会有缺点。

上述问题可以采用master-salve模式，即salve监听主节点，主节点挂掉直接切换备节点（高可用方案）.
zookeeper的分布式锁机制完美的解决了监控切换的问题。


但是如果选择采用master-salve模式，也会产生脑裂的问题。脑裂的问题是如何产生的呢？如网络故障的时候，瞬间切换备机会到之后主机恢复后有两个主节点（双master），就会产生脑裂的问题，我们如何解决脑裂的问题呢？

salver在切换的时候不是在检查到master出现问题立马切换，而是先休眠一段足够的时间已确保老的master已经获知变更（休眠时间一般定义为与Zookeeper定义的超时时间就够了）。


# Eureke 

Eureke在设计的时候保证了可用性，也就是说Eureke各个节点都是平等的，挂掉几个节点不会影响正常的工作，剩余的节点依然可以执行注册和查询服务，只要有一台Eureke服务在就能保证服务的可用性，只不过查到的信息可能不是最新的（不保证强一致性）。

Eureke 还有客户端缓存功能，当极端情况下，所有的Eureke的节点全部失效，或者网络故障不能访问任何一台Eureke的服务，然Eureke的消费者仍然可以通过Eureke的客户端缓存来获取服务注册信息。



# 代码片段Code

### eureke-server

pom引入：

        <dependencies>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-starter-netflix-eureka-server</artifactId>
            </dependency>
        </dependencies>

        <build>
            <finalName>eureke-server</finalName>
            <plugins>
                <plugin>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-maven-plugin</artifactId>
                </plugin>
            </plugins>
        </build>

启动：

        @SpringBootApplication
        @EnableEurekaServer
        public class EurekaServerApplication {

            public static void main(String[] args) {
                SpringApplication.run(EurekaServerApplication.class, args);
            }
        }


配置文件：

        ###端口
        server.port=1111
        ###项目名称
        server.servlet.context-path=/EurekeServer


        #配置
        eureka.instance.hostname=localhost
        eureka.client.registerWithEureka=false
        eureka.client.fetchRegistry=false
        eureka.client.serviceUrl.defaultZone=http://${eureka.instance.hostname}:${server.port}/${server.servlet.context-path}/eureka/

        spring.application.name=eureke-server

### eureke-client

pom引入：

    <dependencies>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
        </dependency>
    </dependencies>

    <build>
        <finalName>eureke-client</finalName>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>


启动：


    @SpringBootApplication
    @EnableDiscoveryClient
    public class EurekaClientApplication {

        public static void main(String[] args) {
            SpringApplication.run(EurekaClientApplication.class, args);
        }
    }

配置：

    ###端口
    server.port=2222
    ###项目名称
    server.servlet.context-path=/EurekeClient


    #配置
    eureka.client.serviceUrl.defaultZone=http://localhost:1111/EurekeServer/eureka/
    spring.application.name=eureke-client


请求：

    @RestController
    @RequestMapping("/test")
    public class TestController {

        @Value("${server.port}")
        String port;

        @RequestMapping("/client")
        public String home(@RequestParam(value = "name", defaultValue = "Nick") String name) {
            return "hello world,name=" + name + ",port=" + port;
        }
    }

同时启动server端和client 端 ，访问http://localhost:1111/EurekeServer/ 就可以发现目前注册的client服务


# 参考代码

```https://github.com/lulongji/llj-springcloud.git```
















