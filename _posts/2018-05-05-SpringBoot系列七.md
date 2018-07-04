---
layout:     post
title:      SpringBoot搭建系列七
subtitle:   事物处理
date:       2018-05-05
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - SpringBoot
    - Spring
---
# 说明
spring事物的处理之前有总结过[spring事物处理](http://blog.lulongji.cn/2015/11/26/%E6%80%BB%E7%BB%93%E4%B8%80%E4%B8%8Bspring%E4%BA%8B%E7%89%A9%E5%A4%84%E7%90%86/),不过之前用到的是tx模式，这次打算用注解方式，所以总结一下注解方式的规则。

事务具备ACID四种特性，ACID是Atomic（原子性）、Consistency（一致性）、Isolation（隔离性）和Durability（持久性）的英文缩写。

- （1）原子性（Atomicity）
事务最基本的操作单元，要么全部成功，要么全部失败，不会结束在中间某个环节。事务在执行过程中发生错误，会被回滚到事务开始前的状态，就像这个事务从来没有执行过一样。
- （2）一致性（Consistency）
事务的一致性指的是在一个事务执行之前和执行之后数据库都必须处于一致性状态。如果事务成功地完成，那么系统中所有变化将正确地应用，系统处于有效状态。如果在事务中出现错误，那么系统中的所有变化将自动地回滚，系统返回到原始状态。
- （3）隔离性（Isolation）
指的是在并发环境中，当不同的事务同时操纵相同的数据时，每个事务都有各自的完整数据空间。由并发事务所做的修改必须与任何其他并发事务所做的修改隔离。事务查看数据更新时，数据所处的状态要么是另一事务修改它之前的状态，要么是另一事务修改它之后的状态，事务不会查看到中间状态的数据。
- （4）持久性（Durability）
指的是只要事务成功结束，它对数据库所做的更新就必须永久保存下来。即使发生系统崩溃，重新启动数据库系统后，数据库还能恢复到事务成功结束时的状态。

# @Transactional属性

    
    属性	                 类型	                                    描述
    value	                String	                             可选的限定描述符，指定使用的事务管理器
    propagation	            enum: Propagation	                 可选的事务传播行为设置
    isolation	            enum: Isolation	                     可选的事务隔离级别设置
    readOnly	            boolean	                             读写或只读事务，默认读写
    timeout	                int (in seconds granularity)         事务超时时间设置
    rollbackFor	            Class对象数组，必须继承自Throwable	    导致事务回滚的异常类数组
    rollbackForClassName	类名数组，必须继承自Throwable	        导致事务回滚的异常类名字数组
    noRollbackFor	        Class对象数组，必须继承自Throwable	    不会导致事务回滚的异常类数组
    noRollbackForClassName	类名数组，必须继承自Throwable	        不会导致事务回滚的异常类名字数组



![springboot事物](https://raw.githubusercontent.com/lulongji/lulongji.github.io/master/imgs/springboot/sw.png)
    

# 隔离级别

### propagation属性
    public enum Isolation {  
        DEFAULT(-1),
        READ_UNCOMMITTED(1),
        READ_COMMITTED(2),
        REPEATABLE_READ(4),
        SERIALIZABLE(8);
    }
- DEFAULT ：这是默认值，表示使用底层数据库的默认隔离级别。对大部分数据库而言，通常这值就是： READ_COMMITTED 。
- READ_UNCOMMITTED ：该隔离级别表示一个事务可以读取另一个事务修改但还没有提交的数据。该级别不能防止脏读和不可重复读，因此很少使用该隔离级别。
- READ_COMMITTED ：该隔离级别表示一个事务只能读取另一个事务已经提交的数据。该级别可以防止脏读，这也是大多数情况下的推荐值。
- REPEATABLE_READ ：该隔离级别表示一个事务在整个过程中可以多次重复执行某个查询，并且每次返回的记录都相同。即使在多次查询之间有新增的数据满足该查询，这些新增的记录也会被忽略。该级别可以防止脏读和不可重复读。
- SERIALIZABLE ：所有的事务依次逐个执行，这样事务之间就完全不可能产生干扰，也就是说，该级别可以防止脏读、不可重复读以及幻读。但是这将严重影响程序的性能。通常情况下也不会用到该级别。

# 传播行为

### propagation属性
    public enum Propagation {  
        REQUIRED(0),
        SUPPORTS(1),
        MANDATORY(2),
        REQUIRES_NEW(3),
        NOT_SUPPORTED(4),
        NEVER(5),
        NESTED(6);
    }
- REQUIRED ：如果当前存在事务，则加入该事务；如果当前没有事务，则创建一个新的事务。
- SUPPORTS ：如果当前存在事务，则加入该事务；如果当前没有事务，则以非事务的方式继续运行。
- MANDATORY ：如果当前存在事务，则加入该事务；如果当前没有事务，则抛出异常。
- REQUIRES_NEW ：创建一个新的事务，如果当前存在事务，则把当前事务挂起。
- NOT_SUPPORTED ：以非事务方式运行，如果当前存在事务，则把当前事务挂起。
- NEVER ：以非事务方式运行，如果当前存在事务，则抛出异常。
- NESTED ：如果当前存在事务，则创建一个事务作为当前事务的嵌套事务来运行；如果当前没有事务，则该取值等价于 REQUIRED 。


# Transactional超时时间控制
一般是这样控制```@Transactional(timeout=2)```,超时时间为2毫秒，不过值得注意的是：

- ```mybatis定义了语句执行超时时间```
- ```数据库设置了等待超时时间，如mysql的配置文件(my.cnf)中，innodb_lock_wait_timeout=50```
- ```mybatis定义了语句执行超时时间```

```结论：spring的事务超时时间和mysql的事务超时时间是相互影响的```


# 项目源码
```https://github.com/lulongji/springboot-demo.git```
