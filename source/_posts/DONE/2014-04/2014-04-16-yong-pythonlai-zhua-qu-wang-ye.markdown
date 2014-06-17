---
layout: post
title: "用Python来抓取网页"
date: 2014-04-16 19:08
comments: true
categories: [Python]
---

最近有些工作要用到Python来抓取网页的内容。就在博客上记篇笔记吧。因为是笔记，所以就比较零散...

<!--more-->

主要用到的Python库是[requests](http://docs.python-requests.org/en/latest/)，ggithub上有些很些Nice的人，在我遇到问题的时候热心帮助我，比如说[被python和json坑了](https://github.com/kennethreitz/requests/issues/1974)的帖子...Requests这个库最大的好处就是，封装的很人性化，就像它号称的for humans。很多的项目都用这个库，它在github上已经有9000多个star了。

另外，主要的教程是[这位同学的博客](http://blog.csdn.net/column/details/why-bug.html)，是山东大学软件工程的一位同学。不过他的教程中用的是urllib2之类的库，比requests底一个层次，写起来也要麻烦一点。但看看他对抓取过程的分析，还是非常有帮助的。教程就应该像他这样写，写的具体一些，看起来更明白。其中给出的代码，我试过的都能运行。

## 抓取过程

Python抓取网页的过程，和我们用浏览器打开网页的过程是一样的，都是通过HTTP协议来通信。也就是说，发一个请求过去，收到一些数据回来。我们要抓取的东西，也就是网页的源代码，在Chrome之类的浏览器中，直接右键就有查看源代码的选项。

但有些时候，会遇到Ajax的情况。也就是说，我们直接抓取到的，是含有ajax的js代码，浏览器的真实数据，是不时的通过这些js代码，来发送新的请求，来局部更新页面的数据。我们抓取到的ajax代码对我们来说没有用，我们要抓取的是数据，而不是代码。这个时候，就要我们自己模拟http请求，来获取这些信息。

如何模拟呢？在Chrome中，右键有`审查元素`的选项，其中第二个标签页是`Network`，打开以后，会发现有各种各样的`GET`和`POST`请求。这些就是Ajax为了局部更新页面而进行的通信了。我们要做的，就是模拟这些通信，来获取数据。

## 举个例子吧~

就拿[W3School](http://www.w3school.com.cn/ajax/ajax_example.asp)的ajax例子来练习抓取好了。大家可以看到，页面中间有个按钮`通过 AJAX 改变内容`，按下它，按钮上方的文字会改变（但是注意，按下文字就改不回来了...只能刷新页面了。只能说写这个例子的人太懒...）。

如果我们直接抓取这个页面，就抓取不到改变后的文字，只能抓取到改变前的文字。通过查看`Network`选项，我们会发现，其实也就是`GET`了`http://www.w3school.com.cn/ajax/test1.txt`，所以我们也来GET一下就好了...以下就是简单的代码...

```
>>> import requests
>>> r = requests.get('http://www.w3school.com.cn/ajax/test1.txt')
>>> r.text
u'<p>AJAX is not a programming language.</p>\r\n<p>It is just a technique for creating better and more interactive web applications.</p>'
```

## 那，如果要传参数呢？

上面这个例子太过简单，很多时候我们想抓取一些需要提交数据的东西。那就简单的把在Network中的headers，data，都封装到requests中就好。

如
```
import requests
headers = {
'Host': 'matrix.itasoftware.com',
'Connection': 'keep-alive',
'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36',
'Accept-Encoding': 'gzip,deflate,sdch',
'Accept-Language': 'en,en-US;q=0.8,zh-CN;q=0.6,zh;q=0.4,zh-TW;q=0.2'
}

url = 'http://matrix.itasoftware.com/'
r = requests.get(url, headers = headers, allow_redirects = False)
cookie = r.headers['set-cookie']
```
就是去抓取第一次访问`url = 'http://matrix.itasoftware.com/'`时产生的cookie。为什么要抓取这个cookie呢？因为后面有用~

## 举个实际抓取的例子~~

还是上面的那个网站http://matrix.itasoftware.com/，我想抓取上面的机票的信息。我们首先要做的，就是分析浏览器是如何从这个网站中得到机票信息的。我们打开上面提到的Network工具，来进行分析。

可以看到，有大量的HTTP请求。其中，只有一个POST，其它的都是GET。我们当然重点关注这个POST了。可以观察到，它POST过去了一堆东西，然后得到了一个很长很长的JSON文件。观察一下那个JSON文件，会发现，它就是我们要的机票的结果~~

先不管POST过去的东西有什么意义，我们先把Network里的的Request Headers都放到Python中的一个dict中(就叫这个dict变量headers吧)。同样把Request中的data部分放入一个叫data的dict变量中。然后就
```
r = requests.post(url, data = data, headers = headers, allow_redirects=False)
```
上面语句中的allow_redirects参数可以不加，因为默认就是False。它的作用我们后面再讲。

好了，在经过十多秒的等待后，我们的程序终于执行完了。可以看出，以上POST命令达到了我们的目的，抓取到了我们想要的数据。接下来是分析Requests的headers和data。我们发现，除了要我们输入的信息（如出发城市和出发日期）之外，还有两个部分，一部分是cookie，一部分是session，这两个数据是我们不能确定的。那么，这两个数据是抓取时一定需要的吗？经过测试，我们发现，cookie是一定要的，session这部分可以不要。

于是，cookie是从哪里得到的呢？我刚开始的时候，是在按下`Search`按钮的时候才开始监听Network的。但这样的话，得到的第一条HTTP请求中就已经有cookie了。也就是说，cookie是在按下`Search`之前就已经存在了。于是，我打开了一个空白的标签页，先打开Network工具，之后再输入这个网站的网址，发现，cookie还是已经存在了的...别急，我们先把cookie清空一下，然后再从空白标签页开始，重复上述操作，这下发现，第一次访问这个网站的时候，会自动生成一个cookie。这样，我们就拿到这个cookie了~~之后就可以进行抓取了。

在用Python抓取这个cookie的时候，我们发现，会报错，超过30个redirects之类的错误。查了下官方的文档，解决办法是，GET的时候，传一个allow_redirects = True的参数。因为这个GET的过程中是有跳转的（HTTP编码302的操作）。具体我不清楚是怎样的原理。对于POST，如果我们也传一个True进去，反而会报错，所以那里就不传，或者传False了。

我知道上面讲的很粗糙，一篇好的教程应该是很详细，有每步的截图的。但我也知道，我的这个博客也没多少人看...就先这样吧。之后有需要再补。另外，代码我想等项目结束的时候，再开源。

## 总体的感受

用Python来抓取数据，比我想像的要底层一些，也要烦琐一些。首先要做的，还是分析浏览器获取数据的过程。这就需要进行一些底层的分析，如浏览器提交表单时，是以什么格式，向哪个地址提交的。而不是像我之前想的，像按键精灵一样，直接在浏览器中填写表单，然后得到浏览器返回的结果。应该是有能模拟浏览器的Python的库，但是我没找到大家比较公认的库，而requests这个库，大家都评价很高。

低层有低层的好处，如对session或cookie的操作就非常简单。高层的话就不好办了。但是，因为这个订票的网站非常复杂，非常多的HTTP请求，网站的JS也是拆成了几十块，搞的我没办法分析`Search`按钮按下时到底把数据提交到了哪里。但后来发现，不用搞明白这些，就可以抓取到数据。当然，这之间也是花了很多时间的。

总之，通过这次抓取，掌握了不少东西~
