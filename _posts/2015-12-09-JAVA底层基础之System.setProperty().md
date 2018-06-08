---
layout:     post
title:      JAVA底层基础之System.setProperty()
subtitle:   System.setProperty()
date:       2015-12-09
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - java
---

# 开始

最近看了一下框架底层代码实现，涉及到一些知识总结。

### Java中System.setProperty()用法

#### 说明
- prop - 系统属性的名称。
- value - 系统属性的值。
- 返回：系统属性以前的值，如果没有以前的值，则返回 null。
- 注：这里的system，系统指的是 JRE (runtime)system，不是指 OS。


#### 实例 

    /** 这样就把第一个参数设置成为系统的全局变量！可以在项目的任何一个地方 通过System.getProperty("变量");来获得，  
  
    System.setProperty 相当于一个静态变量，存在内存里面！**/

    public class SystemTest {
        
        static {
            setValue();
        }

        public static void setValue() {
            System.setProperty("name", "张三");
            System.setProperty("age", "28");
        }
        
        public static void main(String[] args) {
            System.out.println(System.getProperty("name"));
            System.out.println(System.getProperty("age"));
        }
    }


