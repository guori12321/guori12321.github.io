---
layout: post
title: "人人网点赞狂魔的开发"
date: 2013-12-28 10:19
comments: true
categories: [Tech, 乱七八糟]
---

之前在人人网上看到一张图，说点赞狂魔眼中的赞，已经不赞，而是`朕已阅`，于是，我就想搞这么个脚本，来实现这个功能~

<!--more-->

先上效果图：



我用的是[Tampermonkey](http://tampermonkey.net/)(简称TM，也就是俗称的油猴)这个Chrome插件来运行我的脚本。之前有直接写过Chrome插件，但是上架和推广比较麻烦，Chrome市场要收费，很坑。这么轻量级的功能，写个小脚本，然后用油猴来运行就好~

## 开发过程

* 找TM的Example

Tampermonkey的官网上竟然没有提供任何的example，这一点都不科学！[这位同学](http://hibbard.eu/tampermonkey-tutorial/)写出了很详尽的example。仿照它，我们就可以实现我们想做的功能了。

要注意，TM的程序头的那些，不是注释，而是有意义的类似配置文件的部分。比如说，脚本的名称，就是在`@name`这一行命名的，而不会在保存的时候输入名称。

* 查找结点
通过在人人网上审查元素，我发现，有关'赞'的控件的id都是以'ILike'开头的，于是，DFS找到匹配这些id的node，再改掉它的innerHTML就好了。实测每秒运行一次这个脚本更新innerHTML，不会太卡。

* 上架
在[userscripts.org](http://userscripts.org)上上架。[这里](http://userscripts.org/scripts/show/186905)是最终上架后的页面。

## TODO

1. 每秒运行一次脚本的话，效率太低。最好的办法应该是为人人网点赞的JS加上一小段更新innerHTML的部分。

2. 写一个用户友好的前端，然后把这个脚本上架到Chrome应用商店里。这样就可以让更多更小白的用户来使用这个脚本了。

以上两点现在还懒得搞...

## 源代码
已经上传至[我的Github](https://github.com/guori12321/clickZan)。

## 一些Debug的笔记

* 不友好的Debug

即使我一行代码也没写，Chrome加载完TM也会报错。事实上，有些网站本身在Console里就会报错。更严重的是，在Debug我的脚本的时候，TM只给出有错，但并不给出哪一行有错。非常不友好。

* 关于`match`部分

记得在域名的结尾处加上/*，就像下面这样
```
// @match      http://www.baidu.com/*
```
而像这样是**不行**的
```
// @match      http://www.baidu.com*
```
我觉得很奇怪，因为在正则表达式中`*`是[表示零个或多个字符](http://zh.wikipedia.org/wiki/%E6%AD%A3%E5%88%99%E8%A1%A8%E8%BE%BE%E5%BC%8F)。

* 注意你的输入法！

小心在JS中输入了汉语的，或者是全角的空格。这种错误是人眼不可见的。我曾经在某配置文件的行尾多打了个空格，导致整个十一假期都在调试，本来都订好去草原上露宿的帐篷了...

* DFS

刚开始的时候DFS一次全局元素，非常的慢，不过我也懒的改了...实测document.getElementsByClass()和JQuery中的$(".classname")都不好用，我不知道怎么把单独的一个元素拿出来再修改innerHTML。对于人人网主页，DFS一次的时间开销可以忽略。就这样吧...

* className

要取出来元素i的class，要用i.className而不是i.class

* TM的加载问题

有的时候在本地更新完脚本，TM那里并不会加载进去，这时候让TM检查下更新，还不行的话只能重启浏览器了
