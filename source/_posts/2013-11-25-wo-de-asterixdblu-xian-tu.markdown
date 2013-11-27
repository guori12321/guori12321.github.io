---
layout: post
title: "我的AsterixDB路线图"
date: 2013-11-25 10:27
comments: true
categories: [AsterixDB]
---

AsterixDB是UC Irvine大学主导开发的一款并行划，分布式的数据库。更多的介绍可以看[这里](http://asterixdb.ics.uci.edu/)。下面是我参与开发过程的一些记录。

##获得源代码

首先是下载源代码。在它的[Google Code的Source页面]()中，可以找到下面这句
```
git clone https://code.google.com/p/asterixdb/
```
这样你就可以把它的源代码下载下来了。

查看下，发现除了java文件外，就是XML这种结构文件。

##导入项目
因为源代码中没有`.projecr`文件，所以说，没办法像平时一样用Eclipse直接import进去。查来查去，在[stackoverflow](http://stackoverflow.com/questions/2638016/why-no-projects-found-to-import)应该这么做
```
Goto File > New > Java Project
Uncheck Use default location
Click on Browse to navigate to your source folder, or type in the path to your source
Click Finish
```
注意到一点，Eclipse有Bug: 如果你的项目的路径，在你的workspace下，那么，Eclipse会报错`folder overlaps the location of an existing project`，具体参考[这个问题](http://stackoverflow.com/questions/10368903/where-is-create-project-from-existing-source-in-eclipse-indigo)。把默认的workspace删了，别选Use default location，然后选asterixdb的文件夹，就可以了。之后再把workspace加回来。


