---
layout:     post
title:      SpringBoot[十]
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

### 部署脚本

    #!/bin/bash

    #JDK指定
    JAVA_HOME=$JAVA_HOME
    #项目目录
    APP_HOME="/app/springboot_wxrest"
    #项目jar名称
    APP_NAME=wxrest
    #项目配置文件路径
    APP_CONF="$APP_HOME/conf/application-pro.properties"
    #关闭debug模式则设置为空
    #APP_DEBUGE=
    APP_DEBUGE="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8899"

    #JVM参数
    JAVA_OPTS='-Xms2048M -Xmx2048M -XX:PermSize=256M -XX:MaxPermSize=512M -XX:NewRatio=4 -XX:+UseParallelGC -XX:ParallelGCThreads=8 -XX:+UseAdaptiveSizePolicy -verbose:gc -XX:+PrintGCTimeStamps -XX:+PrintGCDetails -XX:-HeapDumpOnOutOfMemoryError -Xloggc:verbose-gc-sp.txt'
    JAR_FILE=$APP_HOME/$APP_NAME.jar
    pid=0
    APP_CONF="--spring.config.location=file:$APP_CONF  --spring.profiles.active=pro"

    start(){
    checkpid
    if [ ! -n "$pid" ]; then
        $JAVA_HOME/bin/java -jar $APP_DEBUGE $JVM_OPTS $JAR_FILE $APP_CONF  &
        echo "---------------------------------"
        echo "启动完成，按CTRL+C退出日志界面即可>>>>>"
        echo "---------------------------------"
        sleep 2s
    else
        echo "$APP_NAME is runing PID: $pid"
    fi

    }

    status(){
    checkpid
    if [ ! -n "$pid" ]; then
        echo "$APP_NAME not runing"
    else
        echo "$APP_NAME runing PID: $pid"
    fi
    }

    checkpid(){
        pid=`ps -ef |grep $JAR_FILE |grep -v grep |awk '{print $2}'`
    }

    stop(){
        checkpid
        if [ ! -n "$pid" ]; then
        echo "$APP_NAME not runing"
        else
        echo "$APP_NAME stop..."
        kill -9 $pid
        fi
    }

    restart(){
        stop
        sleep 1s
        start
    }

    case $1 in
            start) start;;
            stop)  stop;;
            restart)  restart;;
            status)  status;;
                *)  echo "require start|stop|restart|status"  ;;
    esac



# 用户组管理

    groupadd springboot
    groupadd java
    useradd -g springboot -G java
    passwd java

    #赋予root权限
    usermod -g root java


    #创建文件夹
    mkdir -p /usr/local/springboot

    #授权
    chown -R java:springboot /usr/local/springboot

    #软连
    ln -s /webserver/springboot/ /usr/local/
    


# 项目源码
```https://github.com/lulongji/springboot-demo.git```
