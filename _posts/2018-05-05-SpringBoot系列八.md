---
layout:     post
title:      SpringBoot搭建系列八
subtitle:   集成Freemaker模板引擎、程序热部署
date:       2018-05-05
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - SpringBoot
    - Spring
---

# 说明

# Freemaker模板引擎

### 引入pom依赖

    <!-- 引入freeMarker的依赖包. -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-freemarker</artifactId>
    </dependency>    

### 配置application.yml

    spring:
    freemarker:
        allow-request-override: false
        cache: false
        settings:
        template_update_delay: 0
        check-template-location: true
        charset: UTF-8
        content-type: text/html
        expose-request-attributes: false
        expose-session-attributes: false
        expose-spring-macro-helpers: false
        templateEncoding: UTF-8
        templateLoaderPath: classpath:/templates/
        prefix:
        suffix: .html

### 测试

- 在templates新建test.html：

    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8"/>
        <title>Insert title here</title>
    </head>
    <body>
        Hello,${nameKey}
    </body>

    </html>


- TestController

    @RequestMapping("/test1")
    public String test1(Map<String, Object> map) {
        map.put("nameKey", path);
        return "test";
    }


- 启动程序访问即可

```http://localhost:8080/test1```


# 热部署
- 在maven中加入devtools的依赖

        <!-- 热部署，不用重启 -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <optional>true</optional>
        </dependency>

- project 中添加spring-boot-maven-plugin,主要在eclipse中起作用，idea不需要加此配置,springboot 项目的话，应该是有此配置，加里面的内容即可。

        <build>
                <plugins>
                    <plugin>
                        <groupId>org.springframework.boot</groupId>
                        <artifactId>spring-boot-maven-plugin</artifactId>
                        <configuration>
                            <fork>true</fork>
                        </configuration>
                    </plugin>
                </plugins>
        </build>

- application.yml中设置禁用模板引擎缓存

    spring:
        freemarker:
            cache: false
            template_update_delay: 0

- 打开 Settings –> Build-Execution-Deployment –> Compiler，将 Build project automatically.勾上。

- 点击 Help –> Find Action..，或使用快捷键 Ctrl+Shift+A来打开 Registry…，将其中的compiler.automake.allow.when.app.running勾上。

- 全部设置完毕，重启一下IDEA。现在你就不必每次都手动的去点停止和启动了。


# 项目源码
```https://github.com/lulongji/springboot-demo.git```
