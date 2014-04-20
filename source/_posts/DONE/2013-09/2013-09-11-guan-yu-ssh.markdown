---
layout: post
title: "关于linux常用命令"
date: 2013-09-11 16:23
comments: true
categories: [linux]
---

ssh这些linux常用的命令，大家应该都听过，但我自己一直不怎么会用...

现在在香港实习，就要多多的请教啊～～

<!--more-->

##ssh
ssh username@ServerDomain 然后输入密码就好...

##ssh key配置
在home下建立.ssh文件夹，然后通过下面的scp命令把本地的ssh pub key拷到这个文件下。
之后通过[chomd命令](http://blog.csdn.net/haydenwang8287/article/details/1753883)来给.ssh文件夹一些权限：
```
chmod 700 .ssh # 只有所有者有读和写以及执行的权限
```
之后使用cat命令把拷过来的pub key拷到.ssh下的authorized_keys文件中去
'''
cat _rsa.pub >> authorized_keys
'''
之后再ssh时就不用输入密码了。

##ssh -D
因为一些众所周知的原因，我们经常要翻来翻去。翻墙最快捷的方法还是物理翻墙，但如果暂时没办法物理翻，那就只能各种代理了。
`ssh -D`，传这个参数，就相当于在本地搞了个代理的端口，然后把网络流量导向这个端口就好。

##ssh Config
ssh时要输入用户名和密码。我们可以通过上面提到过的ssh key的办法来不输密码。同时，我们可以通过配置ssh config文件来不输入账号。
ssh config文件具体的位置是在`.ssh/config`，在里面直接写就好，可以写入多个账号。格式如下：
```
Host alias
HostName your_host_name
Port your_host_port
User your_user_name
ServerAliveCountMax 20
ServerdomainverAliveInterval 240
```
之后，就直接`ssh alias`，就相当于你输入了`ssh your_user_name@your_host_name`了。

##ssh -tt
经常会遇到要ssh两次的场景：第一次ssh到实验室里，第二次从实验室的机子ssh到集群机上。[金马](http://www.lijinma.com/index.html)教我了个命令，可以一次就从实验室外ssh到集群上：

1. 首先你要实现，A登陆B，B登陆C不需要密码（生成id_rsa.pub复制到对面机器的authorized_keys，具体参考上文）;

2. ssh yourname@B 'ssh -tt yourname2@C'

这个命令的关键就是要加参数-tt，否则会出现错误：Pseudo-terminal will not be allocated because stdin is not a terminal

3. 最后为了方便，我每次都会加个alias的

alias sshBC="ssh yourname@B 'ssh -tt yourname2@C'"

##scp
通过ssh，来从本地往远程服务器上拷数据，或者从远程往本地拷数据都用这个命令。
具体的介绍在[这里](http://www.vpser.net/manage/scp.html)。以下是我粘过来的部分内容。

1、获取远程服务器上的文件
'''
scp -P 2222 root@www.vpser.net:/root/lnmp0.4.tar.gz /home/lnmp0.4.tar.gz
'''
上端口大写P 为参数，2222 表示更改SSH端口后的端口，如果没有更改SSH端口可以不用添加该参数。 root@www.vpser.net 表示使用root用户登录远程服务器www.vpser.net，:/root/lnmp0.4.tar.gz 表示远程服务器上的文件，最后面的/home/lnmp0.4.tar.gz表示保存在本地上的路径和文件名。

2、获取远程服务器上的目录
'''
scp -P 2222 -r root@www.vpser.net:/root/lnmp0.4/ /home/lnmp0.4/
'''
上端口大写P 为参数，2222 表示更改SSH端口后的端口，如果没有更改SSH端口可以不用添加该参数。-r 参数表示递归复制（即复制该目录下面的文件和目录）；root@www.vpser.net 表示使用root用户登录远程服务器www.vpser.net，:/root/lnmp0.4/ 表示远程服务器上的目录，最后面的/home/lnmp0.4/表示保存在本地上的路径。

3、将本地文件上传到服务器上
'''
scp -P 2222 /home/lnmp0.4.tar.gz root@www.vpser.net:/root/lnmp0.4.tar.gz
'''
上端口大写P 为参数，2222 表示更改SSH端口后的端口，如果没有更改SSH端口可以不用添加该参数。 /home/lnmp0.4.tar.gz表示本地上准备上传文件的路径和文件名。root@www.vpser.net 表示使用root用户登录远程服务器www.vpser.net，:/root/lnmp0.4.tar.gz 表示保存在远程服务器上目录和文件名。

4、将本地目录上传到服务器上
'''
scp -P 2222 -r /home/lnmp0.4/ root@www.vpser.net:/root/lnmp0.4/
'''
上 端口大写P 为参数，2222 表示更改SSH端口后的端口，如果没有更改SSH端口可以不用添加该参数。-r 参数表示递归复制（即复制该目录下面的文件和目录）；/home/lnmp0.4/表示准备要上传的目录，root@www.vpser.net 表示使用root用户登录远程服务器www.vpser.net，:/root/lnmp0.4/ 表示保存在远程服务器上的目录位置。

5、可能有用的几个参数 :
```
-v 和大多数 linux 命令中的 -v 意思一样 , 用来显示进度 . 可以用来查看连接 , 认证 , 或是配置错误 .

-C 使能压缩选项 .

-4 强行使用 IPV4 地址 .

-6 强行使用 IPV6 地址 .
```

##history
使用这个命令可以查看输入的shell命令的历史。

##pip
用来安装python的包的，可以用`pip install XXX`来代替`sudo apt-get install python-XXX`。

具体看[这里](http://www.jsxubar.info/install-pip.html)。

注意:
* 要将文件安到当前用户的路径下时（即你没有root权限时），输入`pip install --user PackageName`就好。另外注意`pip install`这种子命令的`help`手册是在`pip`之外的。所以查`--user`参数时，要输入`pip install -h`来找。
* IE Dept.的服务器终端默认是跑比较老的终端版本。所以说，在~/.login最后加入一句`exec bash`。

## ps aux
查看系统当前进程。结合grep可以很方便的查找指定的进程。如`ps aux | grep mongo`就能找到mongoDB的进程。
参数中，a是指显示所有程序，包括其它用户的程序，u表示以用户为主的格式显示，x表示显示不以终端来区分程序。
我也不知道具体是什么意思...会用就好...
详细的参数可以查看[这里](http://www.360doc.com/content/11/0530/23/2104556_120606853.shtml)

## df
因为在香港做的东西很吃硬盘，所以说，要判断下硬盘的剩余空间够不够。可以用下面这句话来看/tmp的剩余空间
```
bash-4.1$ df | grep tmpfs | awk '{print $4}'
```
df就是查看硬盘空间了，grep是把tmp抓出来（/tmp就叫tmpfs这个名字），然后再用awk把第4列（注意这里的列数是从1开始的），也就是可用空间抓出来。

在python中调用以上命令，用[commands模块](http://www.cnblogs.com/xuxm2007/archive/2011/01/17/1937220.html)
```
>>> import commands
>>> dir(commands)
['__all__', '__builtins__', '__doc__', '__file__', '__name__', 'getoutput', 'getstatus','getstatusoutput', 'mk2arg', 'mkarg']
>>> commands.getstatusoutput("date")
(0, 'Wed Jun 10 19:40:41 CST 2009')
```

## du
这是一个查看文件大小的命令。常用`du -sh`来显示当前路径下所有文件的总的大小。

## awk
因为在Server上跑python时，想强行退出只能先Ctrl + z，于是就有了一堆进程在后台等待。
pili过来查看了下，直接输入一行命令，就干掉了所有的python进程：
```
ps aux | grep python | awk '{print $2}' | xargs kill -9
```
先说awk，它是一个很强大的文本分析工具，`awk '{print $2}'`就是把第二列取出来，更多的介绍可以查看[这里](http://www.cnblogs.com/ggjucheng/archive/2013/01/13/2858470.html)。

## xargs
另一个强大的工具，将之前命令产生的参数列表拆散成多个子串，然后对每个子串调用要执行的命令。
具体的来看[wikipedia](http://zh.wikipedia.org/wiki/Xargs)吧。

## kill
`kill -9 pid`，记得传-9这个参数，这样就直接干掉进程了（好残忍的感觉...)

## mkdir
这个命令就不多说了。只是用它建立新文件夹的时候，要建立多层的文件夹时，是加`-p`，而不是像其它命令一样是`-r`。
