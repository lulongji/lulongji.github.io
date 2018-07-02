---
layout:     post
title:      SpringBoot搭建系列一
subtitle:   SpringBoot
date:       2018-04-30
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - SpringBoot
    - Spring
---


# 开始
目前SpringBoot比较热门，之前一直没有时间去研究，正好这些天不太忙，就想花些时间来研究研究。

# 项目
构建一个Sping Boot的Maven项目，强烈推荐Spring Initializr,它从本质上来说就是一个Web应用程序，它能为你生成Spring Boot项目结构。


- 地址：```http://start.spring.io/```
- Jdk版本最好选择1.7以上 推荐1.8

![springboot](https://raw.githubusercontent.com/lulongji/lulongji.github.io/master/imgs/springboot/springboot1.png)



- 如你所见，项目里面基本没有代码，除了几个空目录外，还包含如下几样东西。
```
    pom.xml：Maven构建说明文件。
    DemoApplication.java：一个带有main()方法的类，用于启动应用程序（关键）。
    DemoApplicationTests.java：一个空的Junit测试类，它加载了一个使用Spring Boot字典配置功能的Spring应用程序上下文。
    application.properties：一个空的properties文件，你可以根据需要添加配置属性。

```

# 构建项目
创建TestController类，添加如下代码。


    @RestController
    @EnableAutoConfiguration
    public class TestController {

        @RequestMapping("/")
        public String test() {
            return "Hello world";
        }
    }

# 启动程序
在DemoApplication.java 文件点击右键运行main方法，之后运行http://localhost:8080/就会看到 ```Hello world```了。

- 注意一点：DemoApplication这个启动类必须放在最外层，要不会抱一个错误```Whitelabel Error Page```,详细解释也可以看官网```http://docs.spring.io/spring-boot/docs/current-SNAPSHOT/reference/htmlsingle/#using-boot-structuring-your-code```


# 项目代码

