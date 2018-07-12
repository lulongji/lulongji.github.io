---
layout:     post
title:      SpringBoot搭建系列十
subtitle:   CentOS 部署
date:       2018-05-07
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - SpringBoot
    - Spring
---

# 项目部署

- 修改pom文件，添加默认启动类。

        <plugin>
            <artifactId>maven-assembly-plugin</artifactId>
            <version>2.2-beta-5</version>
            <configuration>
                <archive>
                    <manifest>
                        <addClasspath>true</addClasspath>
                        <mainClass>com.example.demo.DemoApplication.Main</mainClass>
                    </manifest>
                </archive>
                <descriptorRefs>
                    <descriptorRef>jar-with-dependencies</descriptorRef>
                </descriptorRefs>
            </configuration>
            <executions>
                <execution>
                    <id>assemble-all</id>
                    <phase>package</phase>
                    <goals>
                        <goal>single</goal>
                    </goals>
                </execution>
            </executions>
        </plugin>


- 部署脚本start.sh

        \#!/bin/bash

        PROJECTNAME=demo

        pid=`ps -ef |grep $PROJECTNAME |grep -v "grep" |awk '{print $2}'`

        if [ $pid ]; then

        ​    echo "$PROJECTNAME  is  running  and pid=$pid"

        else

        echo "Start success to start $PROJECTNAME ...."

        nohup java -jar  demo-0.0.1-SNAPSHOT.jar  >> catalina.out  2>&1 &

        fi


- 部署脚本stop.sh


        \#!/bin/bash

        PROJECTNAME=demo

        pid=`ps -ef |grep $PROJECTNAME |grep -v "grep" |awk '{print $2}' `

        if [ $pid ]; then

        ​    echo "$PROJECTNAME is  running  and pid=$pid"

        ​    kill -9 $pid

        ​    if [[ $? -eq 0 ]];then

        ​       echo "sucess to stop $PROJECTNAME "

        ​    else

        ​       echo "fail to stop $PROJECTNAME "

        ​     fi

        fi



# 项目源码
```https://github.com/lulongji/springboot-demo.git```
