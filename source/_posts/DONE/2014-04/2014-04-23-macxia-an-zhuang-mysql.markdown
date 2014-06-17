---
layout: post
title: "Mac下安装MySQL"
date: 2014-04-23 23:57
comments: true
categories: [MySQL]
---

今天被MySQL坑了...记载一下...

<!--more-->

## 安装

首先是下载 ，从[Oracle的官网](http://dev.mysql.com/downloads/mysql/)下载(丫的下载还要注册...)，然后就是dmg包安装。具体的教程请看[这里](http://blog.mclaughlinsoftware.com/2011/02/10/mac-os-x-mysql-install/)，但到了18步就不用往下看了，下面的操作也太高端点了...

安装其实是个很简单的操作，就是记得把安装包中的两个pkg都点了安上就行（一个是安装MySQL，另外一个是开机自动启动）。以上都很简单。坑的是下面：

当我`create database newdatabase`的时候报错
```
CREATE DATABASE failed; error: 'Access denied for user: '@localhost'
```
因为是用root登录进MySQL的，而且`show databases;`命令也没有问题。我就以为是MySQL之前的设置出问题了，删了又安，又重启电脑好几次。结果，参考[这篇博客](https://drupal.org/node/34335)，才发现，root如果没有密码的话，就不能create database，但是可以show databases，这是要多坑爹...Mac下安装默认是没有密码的，而且也没有什么提示，直接deny了，搞的我一直以为是MySQL的安装出问题了。

## 添加密码

上述的博客中就给了解决办法：
```
$ mysqladmin -u root password mypassword (obviously don't take that literally! Change 'mypassword' into your password!)
```
注意，password这个词是参数，但是不带`-`。

之后，create就没问题了。

## 导入与导出

直接在shell中输入以下命令就好，导入和导出是大于或小于号
```
$ mysql -uUserName -pPassword abc < abc.sql
$ mysql -uUserName -pPassword abc > abc.sql
```

## 其它常用操作

```
show databases;
create databases;
```

待续...
