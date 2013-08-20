---
layout: post
title: "再次回到octopress"
date: 2013-08-05 10:21
comments: true
categories: [各种折腾, octopress]
---

一直有搭blog的念头，只可惜，总是反反复复，加上自己太懒。这次，我又回到了Octopress~

和上次一样，搭建Linux下的Octopress总会有各种各样的问题。又折腾了一个晚上，才搞定最基本的环境。

细数下我碰到的问题，也许对以后的各位有帮助吧。

<!-- more -->

* 安装RVM:我是通过RVM来安装Ruby的。按照[RVM的官方指南](https://rvm.io/rvm/install)，在执行
```
\curl -L https://get.rvm.io | bash
```
的时候报错：
```
ouldn't get RVM from https://github.com/wayneeseguin/rvm/archive/stable.tar.gz
Curl returned error 22
```
后来发现是下载时跳转到codeload.github上了，而这个域名下面的东西经常不能访问。不仅仅是在我这里（香港），而且[其它地方也经常不能访问](http://www.v2ex.com/t/76033)。找了半天也没找到那个包的其它下载方式。但是，虽然有报错安装失败，但我试了下，rvm的命令是好用的，也就是说已经安上了。总之这个问题莫名其妙的发生了，也莫名其妙的解决了。
PS: 今天早上再试了一下，就不存在这个问题了。

* 使用RVM install 命令的时候报错：
```
`RVM is not a function
```
最后在StackOverflow上查到了[答案](http://stackoverflow.com/questions/9336596/rvm-installation-not-working-rvm-is-not-a-function)：要用login形式的Shell.

* 安装依赖的问题:bundle install的时候报错如下
```
An error occured while installing RedCloth (4.2.9), and Bundler cannot continue.
Make sure that `gem install RedCloth -v '4.2.9'` succeeds before bundling.
```
同样在[Stackoverflow上找到了答案](http://stackoverflow.com/questions/12119138/failed-to-build-gem-native-extension-when-install-redcloth-4-2-9-install-linux)，但引起这个错误的原因有好几个，别人适用的方法自己不一定适用。我是安装了ruby 1.9.1 full后好用了
```
sudo apt-get install ruby1.9.1-full
```

* 版本库的分枝合并问题: 因为之前用过Octopress，所以这次再用的时候，发现没办法合并到原先的库中，因为要合并的两个分枝没有关联。我在octopress/Rakefile中找到了git push的语句，在其中加了个 -f 的参数，也就是强行push，就好了。

* github.com和github.io的关系:deploy到user.github.com库之后，浏览相应的域名，发现并没有发生变化。这是因为github把personal page从user.github.com移到user.github.io了。把.com的库删掉，重新开个.io的库，再deploy，就好了。

* Rakefile的修改：在octopress的根目录下修改Rakefile，在第88行加入
```
system "google-chrome 127.0.0.1:4000"
```
这样就可以在`rake preview`之后自动打开浏览器，来预览了。

##总体感觉

octopress的配置还是非常麻烦。我第一次用了两周才搞好，这次也花了一个晚上，碰到各种问题。总体来说ruby还不够成熟，除了安装的源不稳定外（我在墙外，所以不能怪GFW了），各个版本，各种依赖之间的关系也非常乱，整个Octopress是要求1.9.3以上的ruby的，但有些依赖，比如上面提到的Redcloth，就要求1.9.1。要解决这些问题，只能多查Stackoverflow和Google了，另外多用英语查询吧，汉语的资料太少。
