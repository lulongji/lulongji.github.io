---
layout:     post
title:      SpringBoot搭建系列六
subtitle:   springBoot切面、过滤器和拦截器、MDC处理
date:       2018-05-04
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - SpringBoot
    - Spring
---

# 映射文件
spring boot 默认映射的文件夹有：

    classpath:/META-INF/resources

    classpath:/resources

    classpath:/static

    classpath:/public

上面这几个都是静态资源的映射路径，优先级顺序为：META-INF/resources > resources > static > public，我们可以通过修改spring.mvc.static-path-pattern来修改默认的映射**

### 静态资源过滤

- 代码形式

        @Configuration
        public class DemoSpringConfig extends WebMvcConfigurationSupport {

            /**
            * 静态资源处理
            **/
            @Override
            public void addResourceHandlers(ResourceHandlerRegistry registry) {
                //将所有/static/** 访问都映射到classpath:/static/ 目录下
                registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");
            }
        }

- 配置文件形式
在yml里添加：
spring：
    mvc:
        #静态资源过滤
        static-path-pattern: /static/**

```注意：通过spring.mvc.static-path-pattern这种方式配置，会使Spring Boot的默认配置失效，也就是说，/public /resources 等默认配置不能使用。```

# MDC
先看一下什么是MDC（Mapped Diagnostic Context，用于打LOG时跟踪一个“会话“、一个”事务“）。举例，有一个web controller，在同一时间可能收到来自多个客户端的请求，如果一个请求发生了错误，我们要跟踪这个请求从controller开始一步步都执行到了哪些代码、有哪些log的输出。这时我们可以看log文件，但是log文件是多个请求同时记录的，基本无法分辨哪行是哪个请求产生的，虽然我们可以看线程，但线程可能被复用，也是很难分辨出，这时MDC就派上用场了。

### LogBack 
在logback.xml增加如下参数：

    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <target>System.out</target>
        <encoder>
            <pattern>[%date{ISO8601}] [%-5level] - [%thread] [%X{requestId}] [%logger] [%X{akkaSource}] - %msg %rootException %n
            </pattern>

        </encoder>
    </appender>


# 切面
定义一个切面用来处理日志：

    @Aspect
    @Order(-99)
    @Configuration
    public class LogAspect {

        private static final Logger logger = LoggerFactory.getLogger(LogAspect.class);

        /**
        * 定义切点Pointcut
        * 第一个*号：表示返回类型， *号表示所有的类型
        * 第二个*号：表示类名，*号表示所有的类
        * 第三个*号：表示方法名，*号表示所有的方法
        * 后面括弧里面表示方法的参数，两个句点表示任何参数
        */
        @Pointcut("execution(* com.example.demo.controller..*.*(..))")
        public void executionService() {

        }


        /**
        * 方法调用之前调用
        *
        * @param joinPoint
        */
        @Before(value = "executionService()")
        public void doBefore(JoinPoint joinPoint) {
            //添加日志打印
            String requestId = String.valueOf(UUID.randomUUID());
            MDC.put("requestId", requestId);

            // 接收到请求，记录请求内容
            ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            HttpServletRequest request = attributes.getRequest();

            // 记录下请求内容
            logger.info("HTTP URL : " + request.getRequestURL().toString());
            logger.info("HTTP METHOD : " + request.getMethod());
            // 获取真实的ip地址
            logger.info("IP : " + IPAddrUtil.localAddress());
            logger.info("CLASS METHOD : " + joinPoint.getSignature().getDeclaringTypeName() + "."
                    + joinPoint.getSignature().getName());
            logger.info("PARAMS : " + Arrays.toString(joinPoint.getArgs()));
        }

        /**
        * 方法之后调用
        *
        * @param joinPoint
        * @param returnValue 方法返回值
        */
        @AfterReturning(pointcut = "executionService()", returning = "returnValue")
        public void doAfterReturning(JoinPoint joinPoint, Object returnValue) {

            logger.info("=====>@AfterReturning：响应参数为：{}", returnValue);
            // 处理完请求，返回内容
            MDC.clear();
        }

        /**
        * 统计方法执行耗时Around环绕通知
        *
        * @param joinPoint
        * @return
        */
        @Around("executionService()")
        public Object timeAround(ProceedingJoinPoint joinPoint) {

            //获取开始执行的时间
            long startTime = System.currentTimeMillis();

            // 定义返回对象、得到方法需要的参数
            Object obj = null;
            //Object[] args = joinPoint.getArgs();

            try {
                obj = joinPoint.proceed();
            } catch (Throwable e) {
                logger.error("=====>统计某方法执行耗时环绕通知出错", e);
            }

            // 获取执行结束的时间
            long endTime = System.currentTimeMillis();
            //MethodSignature signature = (MethodSignature) joinPoint.getSignature();
            //String methodName = signature.getDeclaringTypeName() + "." + signature.getName();
            // 打印耗时的信息
            logger.info("=====>处理本次请求共耗时：{} ms", endTime - startTime);
            return obj;
        }
    }



# 过滤器
写一个过滤器，记录所有服务的处理时间。


    // 加入spring ioc容器
    @Component
    /*
    * @WebFilter将一个实现了javax.servlet.Filter接口的类定义为过滤器
    * 属性filterName声明过滤器的名称,可选
    * 属性urlPatterns指定要过滤 的URL模式,也可使用属性value来声明.(指定要过滤的URL模式是必选属性)
    */
    @WebFilter(filterName = "DemoTimeFilter", urlPatterns = "/*")
    //指定过滤器的执行顺序,值越大越先执行
    @Order(1)
    public class DemoTimeFilter implements Filter {

        @Override
        public void init(FilterConfig filterConfig) throws ServletException {
            System.out.println("Filter初始化成功了");
        }

        @Override
        public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
            Long time = new Date().getTime();
            System.out.println("Filter方法执行前时间:" + time);
            filterChain.doFilter(servletRequest, servletResponse);
            System.out.println("Filter方法执行后时间:" + new Date().getTime() + ",共耗时:" + (new Date().getTime() - time));
        }

        @Override
        public void destroy() {
            System.out.println("Filter销毁了");
        }
    }



# 拦截器

### DemoSpringConfig
创建DemoSpringConfig继承WebMvcConfigureAdapter类，覆盖其addInterceptors接口,注册我们自定义的拦截器。


    @Configuration
    public class DemoSpringConfig extends WebMvcConfigurationSupport {

        /**
        * 添加拦截器
        **/
        @Override
        public void addInterceptors(InterceptorRegistry registry) {

            //日志拦截器
            registry.addInterceptor(new LogInterceptor());
            super.addInterceptors(registry);
            //注册自定义拦截器，添加拦截路径和排除拦截路径
        }

    }


### LogInterceptor  
由于上面我们用切面的方式已经写了日志统一处理切面，在写一个LogInterceptor，用于统一处理MDC用以测试拦截器:

    @Component
    public class LogInterceptor implements HandlerInterceptor {
        /**
        * 日志
        */
        private static Logger logger = LogManager.getLogger(LogInterceptor.class.getName());

        private final static String REQUEST_ID = "requestId";


        /**
        * Handler执行之前调用这个方法
        */
        @Override
        public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
                throws Exception {

            String xForwardedForHeader = request.getHeader("X-Forwarded-For");
            String remoteIp = request.getRemoteAddr();
            String uuid = new UUIDGenerator().generate();
            logger.info("put requestId ({}) to logger", uuid);
            logger.info("request id:{}, client ip:{}, X-Forwarded-For:{}", uuid, remoteIp, xForwardedForHeader);
            MDC.put(REQUEST_ID, uuid);
            return true;
        }

        /**
        * Handler执行之后，ModelAndView返回之前调用这个方法
        */
        public void postHandle(HttpServletRequest request, HttpServletResponse response,
                            Object handler, ModelAndView modelAndView) throws Exception {
            String uuid = MDC.get(REQUEST_ID);
            logger.info("remove requestId ({}) from logger", uuid);
            MDC.remove(REQUEST_ID);
        }

        /**
        * Handler执行完成之后调用这个方法
        */
        public void afterCompletion(HttpServletRequest request,
                                    HttpServletResponse response, Object handler, Exception exc)
                throws Exception {

        }


    }


# 项目源码
```https://github.com/lulongji/springboot-demo.git```
