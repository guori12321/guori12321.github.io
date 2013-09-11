---
layout: post
title: "关于ssh"
date: 2013-09-11 16:23
comments: true
categories: [linux]
---

ssh这些linux常用的命令，大家应该都听过，但我自己一直不怎么会用...

现在在香港实习，就要多多的请教啊～～

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

