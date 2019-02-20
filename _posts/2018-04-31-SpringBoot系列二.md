---
layout:     post
title:      SpringBoot[Mybatis & Oracle & pagehelper]
subtitle:   项目结构搭建（基础增删改查）、整合Mybatis、oracle数据库、pagehelper分页器
date:       2018-04-31
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - SpringBoot
    - Spring
---


# 项目分层

### 说明
mvc的设计模式依旧是日常开发中上使用最多的一种设计模式，所以今天我们还是用这种模式设计。

- domain层：模型层，实体类。
- api层：对外接口。
- service层：业务层。
- dao层：持久层。
- Controller层：视图层。


### 框架接口代码整合
基础增删改查代码请到github查看。
```https://github.com/lulongji/springboot-demo.git```
### 框架配置

    #默认使用配置
    spring:
    profiles:
        active: dev


    #公共配置与profiles选择无关
    mybatis:
    typeAliasesPackage: com.example.demo.domain
    mapperLocations: classpath*:com/example/demo/dao/**/*Mapper.xml

    ---

    #开发配置
    在resources目录下新建application.yml配置文件，添加如下配置：

        server:
        port: 8080

        spring:
        profiles: dev

        datasource:
            url: jdbc:oracle:thin:@192.168.6.205:1521:orcl
            username: test
            password: test
            driver-class-name: oracle.jdbc.driver.OracleDriver
            druid.initialSize: 5
            druid.maxActive: 100
            druid.minIdle: 10
            druid.maxWait: 60000
            #使用druid数据源
            type: com.alibaba.druid.pool.DruidDataSource


        #分页的配置
        pagehelper:
            helperDialect: oracle
            reasonable: true
            supportMethodsArguments: true
            params: count=countSql
            offset-as-page-num: true
            row-bounds-with-count: true


### pom文件

        <!-- druid -->
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid</artifactId>
            <version>${druid.version}</version>
        </dependency>


        <!-- oracle-jdbc -->
        <dependency>
            <groupId>com.oracle</groupId>
            <artifactId>ojdbc14</artifactId>
            <version>${oracle.drive.version}</version>
        </dependency>

        <!-- 集成druid，使用连接池-->
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid</artifactId>
            <version>1.1.0</version>
        </dependency>

        <!-- MyBatis -->
        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter</artifactId>
            <version>1.3.1</version>
        </dependency>

        <!--mapper-->
        <dependency>
            <groupId>tk.mybatis</groupId>
            <artifactId>mapper-spring-boot-starter</artifactId>
            <version>1.2.4</version>
        </dependency>

        <!--pagehelper-->
        <dependency>
            <groupId>com.github.pagehelper</groupId>
            <artifactId>pagehelper-spring-boot-starter</artifactId>
            <version>1.2.3</version>
        </dependency>


# 项目源码
```https://github.com/lulongji/springboot-demo.git```