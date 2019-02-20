---
layout:     post
title:      SpringBoot[五]
subtitle:   Ehcache集成
date:       2018-05-03
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - SpringBoot
    - Spring
---


# 说明
在 Spring Boot中，通过@EnableCaching注解自动化配置合适的缓存管理器（CacheManager），Spring Boot根据下面的顺序去侦测缓存提供者： 
* Generic 
* JCache (JSR-107) 
* EhCache 2.x 
* Hazelcast 
* Infinispan 
* Redis 
* Guava 
* Simple

关于 Spring Boot 的缓存机制： 
高速缓存抽象不提供实际存储，并且依赖于由org.springframework.cache.Cache和org.springframework.cache.CacheManager接口实现的抽象。 Spring Boot根据实现自动配置合适的CacheManager，只要缓存支持通过@EnableCaching注释启用即可。

### pom依赖

        <!--  cache -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-cache</artifactId>
        </dependency>

        <!-- ehcache 缓存 -->
        <dependency>
            <groupId>net.sf.ehcache</groupId>
            <artifactId>ehcache</artifactId>
        </dependency>

### ehcache配置

    <?xml version="1.0" encoding="UTF-8"?>
    <ehcache xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:noNamespaceSchemaLocation="http://ehcache.org/ehcache.xsd"
            updateCheck="false">

        <!--
        diskStore：为缓存路径，ehcache分为内存和磁盘两级，此属性定义磁盘的缓存位置。
        defaultCache：默认缓存策略，当ehcache找不到定义的缓存时，则使用这个缓存策略。只能定义一个。
        name:缓存名称。
        maxElementsInMemory:缓存最大数目
        maxElementsOnDisk：硬盘最大缓存个数。
        eternal:对象是否永久有效，一但设置了，timeout将不起作用。
        overflowToDisk:是否保存到磁盘，当系统当机时
        timeToIdleSeconds:设置对象在失效前的允许闲置时间（单位：秒）。仅当eternal=false对象不是永久有效时使用，可选属性，默认值是0，也就是可闲置时间无穷大。
        timeToLiveSeconds:设置对象在失效前允许存活时间（单位：秒）。最大时间介于创建时间和失效时间之间。仅当eternal=false对象不是永久有效时使用，默认是0.，也就是对象存活时间无穷大。
        diskPersistent：是否缓存虚拟机重启期数据 Whether the disk store persists between restarts of the Virtual Machine. The default value is false.
        diskSpoolBufferSizeMB：这个参数设置DiskStore（磁盘缓存）的缓存区大小。默认是30MB。每个Cache都应该有自己的一个缓冲区。
        diskExpiryThreadIntervalSeconds：磁盘失效线程运行时间间隔，默认是120秒。
        memoryStoreEvictionPolicy：当达到maxElementsInMemory限制时，Ehcache将会根据指定的策略去清理内存。默认策略是LRU（最近最少使用）。你可以设置为FIFO（先进先出）或是LFU（较少使用）。
            clearOnFlush：内存数量最大时是否清除。
            memoryStoreEvictionPolicy:可选策略有：LRU（最近最少使用，默认策略）、FIFO（先进先出）、LFU（最少访问次数）。
                FIFO，first in first out，这个是大家最熟的，先进先出。
                LFU， Less Frequently Used，一直以来最少被使用的。如上面所讲，缓存的元素有一个hit属性，hit值最小的将会被清出缓存。
                LRU，Least Recently Used，最近最少使用的，缓存的元素有一个时间戳，当缓存容量满了，而又需要腾出地方来缓存新的元素的时候，那么现有缓存元素中时间戳离当前时间最远的元素将被清出缓存。
        -->
        <defaultCache
                eternal="false"
                maxElementsInMemory="1000"
                overflowToDisk="false"
                diskPersistent="false"
                timeToIdleSeconds="0"
                timeToLiveSeconds="600"
                memoryStoreEvictionPolicy="LRU"/>

        <cache
                name="users"
                eternal="false"
                maxElementsInMemory="100"
                overflowToDisk="false"
                diskPersistent="false"
                timeToIdleSeconds="0"
                timeToLiveSeconds="300"
                memoryStoreEvictionPolicy="LRU"/>
    </ehcache>



### 将ehcache的管理器暴露给spring的上下文容器

    @Configuration
    // 标注启动了缓存
    @EnableCaching
    public class DemoCacheConfig {

        /*
        * ehcache 主要的管理器
        */
        @Bean(name = "appEhCacheCacheManager")
        public EhCacheCacheManager ehCacheCacheManager(EhCacheManagerFactoryBean bean){
            return new EhCacheCacheManager (bean.getObject ());
        }

        /*
        * 据shared与否的设置,Spring分别通过CacheManager.create()或new CacheManager()方式来创建一个ehcache基地.
        */
        @Bean
        public EhCacheManagerFactoryBean ehCacheManagerFactoryBean(){
            EhCacheManagerFactoryBean cacheManagerFactoryBean = new EhCacheManagerFactoryBean ();
            cacheManagerFactoryBean.setConfigLocation (new ClassPathResource ("conf/ehcache-app.xml"));
            cacheManagerFactoryBean.setShared (true);
            return cacheManagerFactoryBean;
        }
    }

### Ehcache 常用注解说明
使用ehcache主要通过spring的缓存机制，上面我们将spring的缓存机制使用了ehcache进行实现，所以使用方面就完全使用spring缓存机制就行了。

    具体牵扯到几个注解：

    　　　　@Cacheable：负责将方法的返回值加入到缓存中，参数3
    　　　　@CacheEvict：负责清除缓存，参数4

    　　　　　参数解释：

    　　　　value：缓存位置名称，不能为空，如果使用EHCache，就是ehcache.xml中声明的cache的name
    　　　　key：缓存的key，默认为空，既表示使用方法的参数类型及参数值作为key，支持SpEL
    　　　　condition：触发条件，只有满足条件的情况才会加入缓存，默认为空，既表示全部都加入缓存，支持SpEL

    　　　　allEntries：CacheEvict参数，true表示清除value中的全部缓存，默认为false


### 使用

    @Service("userService")
    public class UserServiceImpl implements UserService {
        /**
        * 缓存的key
        */
        public static final String THING_ALL_KEY = "\"thing_all\"";
        /**
        * value属性表示使用哪个缓存策略，缓存策略在ehcache.xml
        */
        public static final String DEMO_CACHE_NAME = "users";

        @Autowired
        private UserDao userDao;


        @CacheEvict(value = DEMO_CACHE_NAME, key = THING_ALL_KEY)
        @Override
        public void addUser(User user) throws Exception {
            userDao.addUser(user);
        }

        @CachePut(value = DEMO_CACHE_NAME, key = "#user.getId()+'thing'")
        @CacheEvict(value = DEMO_CACHE_NAME, key = THING_ALL_KEY)
        @Override
        public void updateUser(User user) throws Exception {
            userDao.updateUser(user);
        }

        @CacheEvict(value = DEMO_CACHE_NAME)
        @Override
        public void deleteUser(User user) throws Exception {
            userDao.deleteUser(user);
        }

        @Override
        public User getUser(User user) throws Exception {
            return userDao.getUser(user);
        }

        @Cacheable(value = DEMO_CACHE_NAME, key = "#user.getId()+'thing'")
        @Override
        public User getUserById(User user) throws Exception {
            System.err.println("没有走缓存！" + user.getId());
            return userDao.getUserById(user);
        }

        @Cacheable(value = DEMO_CACHE_NAME, key = THING_ALL_KEY)
        @Override
        public List<User> getUserList(User user) throws Exception {
            return userDao.getUserList(user);
        }
    }

# 项目源码
```https://github.com/lulongji/springboot-demo.git```
