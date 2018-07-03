---
layout:     post
title:      SpringBoot搭建系列四
subtitle:   打包跳过测试
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



# 项目源码
```https://github.com/lulongji/springboot-demo.git```
