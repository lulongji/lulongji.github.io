---
layout:     post
title:      SpringBoot[logback]
subtitle:   logback
date:       2018-05-01
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - SpringBoot
    - Spring
---


# 日志文件

### 说明
SpringBoot 的日志文件放在resources目录下，在resources目录下新建logback.xml.

### logback.xml配置及说明
    <?xml version="1.0" encoding="UTF-8"?>
    <!--
        Copyright 2010-2011 The myBatis Team
        Licensed under the Apache License, Version 2.0 (the "License");
        you may not use this file except in compliance with the License.
        You may obtain a copy of the License at
            http://www.apache.org/licenses/LICENSE-2.0
        Unless required by applicable law or agreed to in writing, software
        distributed under the License is distributed on an "AS IS" BASIS,
        WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
        See the License for the specific language governing permissions and
        limitations under the License.
    -->
    <configuration>
        <!--定义日志文件的存储地址 勿在 LogBack 的配置中使用相对路径-->
        <property name="LOG_HOME" value="/Users/lu/Desktop"/>


        <!-- 彩色日志 -->
        <!-- 彩色日志依赖的渲染类 -->
        <conversionRule conversionWord="clr" converterClass="org.springframework.boot.logging.logback.ColorConverter"/>
        <conversionRule conversionWord="wex"
                        converterClass="org.springframework.boot.logging.logback.WhitespaceThrowableProxyConverter"/>
        <conversionRule conversionWord="wEx"
                        converterClass="org.springframework.boot.logging.logback.ExtendedWhitespaceThrowableProxyConverter"/>
        <!-- 彩色日志格式 -->
        <property name="CONSOLE_LOG_PATTERN"
                value="${CONSOLE_LOG_PATTERN:-%clr(%d{yyyy-MM-dd HH:mm:ss.SSS}){faint} %clr(${LOG_LEVEL_PATTERN:-%5p}) %clr(${PID:- }){magenta} %clr(---){faint} %clr([%15.15t]){faint} %clr(%-40.40logger{39}){cyan} %clr(:){faint} %m%n${LOG_EXCEPTION_CONVERSION_WORD:-%wEx}}"/>
        <!-- Console 输出设置 -->
        <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
            <encoder>
                <pattern>${CONSOLE_LOG_PATTERN}</pattern>
                <charset>utf8</charset>
            </encoder>
        </appender>
        
        <!-- 按照每天生成日志文件 -->
        <appender name="DAYINFO" class="ch.qos.logback.core.rolling.RollingFileAppender">
            <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
                <!--日志文件输出的文件名-->
                <FileNamePattern>${LOG_HOME}/TestSpringBoot_info.log.%d{yyyy-MM-dd}.log</FileNamePattern>
                <!--日志文件保留天数-->
                <MaxHistory>30</MaxHistory>
            </rollingPolicy>
            <filter class="ch.qos.logback.classic.filter.LevelFilter">
                <level>info</level>
                <onMatch>ACCEPT</onMatch>
                <onMismatch>DENY</onMismatch>
            </filter>
            <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
                <!--格式化输出：%d表示日期，%thread表示线程名，%-5level：级别从左显示5个字符宽度%msg：日志消息，%n是换行符-->
                <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>
            </encoder>
            <!--日志文件最大的大小-->
            <triggeringPolicy class="ch.qos.logback.core.rolling.SizeBasedTriggeringPolicy">
                <MaxFileSize>10MB</MaxFileSize>
            </triggeringPolicy>
        </appender>

        <appender name="DAYERROR" class="ch.qos.logback.core.rolling.RollingFileAppender">
            <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
                <!--日志文件输出的文件名-->
                <FileNamePattern>${LOG_HOME}/TestSpringBoot_error.log.%d{yyyy-MM-dd}.log</FileNamePattern>
                <!--日志文件保留天数-->
                <MaxHistory>30</MaxHistory>
            </rollingPolicy>
            <filter class="ch.qos.logback.classic.filter.LevelFilter">
                <level>error</level>
                <onMatch>ACCEPT</onMatch>
                <onMismatch>DENY</onMismatch>
            </filter>
            <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
                <!--格式化输出：%d表示日期，%thread表示线程名，%-5level：级别从左显示5个字符宽度%msg：日志消息，%n是换行符-->
                <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>
            </encoder>
            <!--日志文件最大的大小-->
            <triggeringPolicy class="ch.qos.logback.core.rolling.SizeBasedTriggeringPolicy">
                <MaxFileSize>10MB</MaxFileSize>
            </triggeringPolicy>
        </appender>

        <!-- 日志输出级别 -->

        <root level="INFO">
            <appender-ref ref="STDOUT"/>
            <appender-ref ref="DAYERROR"/>
            <appender-ref ref="DAYINFO"/>
        </root>
    </configuration>

### pom文件

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-logging</artifactId>
        </dependency>



### 控制台颜色说明

- 1.第一点，颜色%black %red等等 ，需要用括号将你要显示本颜色的子模块括起来

- 2.第二点，%red颜色等，前面要与上一个模块 空格隔开

- 3.同样可以定义一个变量然后直接引用在<pattern>标签中


        <pattern>%black(控制台-) %red(%d{yyyy-MM-dd HH:mm:ss}) %green([%thread]) %highlight(%-5level) %boldMagenta(%logger{10}) - %cyan(%msg%n)</pattern>


# 项目源码
```https://github.com/lulongji/springboot-demo.git```
