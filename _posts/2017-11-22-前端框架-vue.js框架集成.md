---
layout:     post
title:      使用Vue.js的前端框架集成
subtitle:   前端框架集成
date:       2017-11-22
author:     lulongji
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - 前端
    - vue
    - JS
---


# 说明
由于目前项目渲染页面都是用的FreeMaker模板引擎，主要由后端来完成；由于后端资源紧张，则把部分项目功能移到前端渲染。

# 问题
- 不支持SEO
- 不支持IE8

# 开始

### vue.js 环境搭建
到[VUE官网](https://router.vuejs.org/zh-cn/installation.html)查看项目文档，以下是简要的搭建过程。

###### 安装vue
    $ cd /AppHtml/  
    $ npm install vue
    
###### 全局安装 vue-cli
    $ npm install --global vue-cli

###### 创建一个基于 webpack 模板的新项目
    $ vue init webpack my-project

###### 安装依赖，走你
    $ cd my-project
    $ npm install
    $ npm run dev

# 目录结构

- build：最终发布的代码存放位置。
- config：配置目录，包括端口号等。我们初学可以使用默认的。
- node_modules：npm 加载的项目依赖模块
- src：这里是我们要开发的目录，基本上要做的事情都在这个目录里。里面包含了几个目录及文件：
```
    assets: 放置一些图片，如logo等。
    components: 目录里面放了一个组件文件，可以不用。
    App.vue: 项目入口文件，我们也可以直接将组件写这里，而不使用 components 目录。
    main.js: 项目的核心文件。
```
- static:静态资源目录，如图片、字体等。
- test:初始测试目录，可删除
- index.html:首页入口文件，你可以添加一些 meta 信息或同统计代码啥的。
- package.json:项目配置文件。
- README:项目的说明文档，markdown 格式


# 内功心法

- Vuex:增加[Vuex](https://vuex.vuejs.org/zh-cn/intro.html)插件，为 Vue.js 应用程序开发的状态管理模式。
- ECMAScript6：需要学习[ES6](http://es6.ruanyifeng.com/)的语法结构。












