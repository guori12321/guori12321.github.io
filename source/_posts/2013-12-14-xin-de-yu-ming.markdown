---
layout: post
title: "新的域名"
date: 2013-12-14 17:45
comments: true
categories: [乱七八糟]
---

挑来挑去，最后在淘宝上花30块钱买了一年的`ruiguo.me`的域名。`ruiguo.net`和`ruiguo.com`都已经被抢注了。可恨的是，我付完钱才想起来问“以后续费是不是都是30块一年”？回答“不是的，以后是180块一年”...坑啊！不过，一年后的事情，谁说的准呢。就先这么用着吧。

<!--more-->

参考octopress的[自主域名配置](http://octopress.org/docs/deploying/github/)。注意，域名生效要24小时左右，因为各级DNS之间的缓存是过一段时间才会更新一次的。

**注意**: 等了一天，这个域名还是不能用。参考了一下别人的博客中的教程([教程1](http://fancyoung.com/blog/host-to-github/)，[教程2](http://www.cnblogs.com/rubylouvre/archive/2012/06/10/2543706.html))，发现他们都是绑定到`207.97.227.245`，而不是[Octopress官方教程](http://octopress.org/docs/deploying/github/)中的`204.232.175.78`。

另外，注意`www.ruiguo.me`是二级域名，而`ruiguo.me`是一级域名。

补充两点：

* 我给Octopress的作者写信了，他说，根据官方的文档，似乎是204.232.175.78是正确的。总之我用207.97.227.245能正常使用。

* 一直以来有个困惑的地方，就是Github Page中的CNAME文件。实际上，用户自定义的域名，是指向Github Page的服务器，然后Github的服务器，去查找所有git库中的CNAME文件，找到和当前域名匹配的CNAME文件后，就认为这个CNAME文件所在的Github Page，就是这个域名对应的page。同样，在直接输入Github Page的原来的域名时，也会跳转到这个自定义的域名。但这样就有一个问题：如果其它人把我的域名放到他们的CNAME文件中的话，不就把我的域名给劫持了吗？这样，我的域名就会跳转到他们的Github Page那里。写信问了下Github Page的工作人员，他们说，同一个域名只能出现在一个CNAME文件中（我实测一个CNAME中可以写多个域名，但只有第一个域名会被识别出来。此外，Github Page只支持一个自定义域名），如果其它人也用这个域名的话，他们的Github Page在build的时候会失败。我又问，如果他们真的抢先在CNAME中使用我的域名呢？工作人员回答，这时他们就人工来判断和解决这个问题了。
