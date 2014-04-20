---
layout: post
title: "MongoDB路线图"
date: 2013-09-02 15:48
comments: true
categories: [学习笔记, MongoDB]
---
`MongoDB`是非常有名的No SQL数据库，话说还真是适应不了No SQL的思维，每次都想着先建表...。以下是我学习MongoDB的路线图：

<!--more-->

**2013-10-31 一定要小心使用collection.update()!!!这个命令并不是说，把新的属性加上，而是把档案直接update为你要更新的值!!在程序跑到一半的时候，我查看了下，结果发现数据全丢了！！！心脏都要停止跳动了！！！**

## 路线图

1. 首先肯定是看看[官网的资料了](http://www.mongodb.org/)。这里面有最初级的教程，以及最详细权威的文档。走一遍它的教程后，相信你会对MongoDB有最初步的了解，学习深入后，再来这里查询文档。只是，这里没有难度适中的教程。要么有太多的细节，要么太过简略了。

2. 一篇很好的[中文简易教程](http://www.eduyo.com/database/nosql/805.html)，看一遍就知道MongoDB有哪些神奇的功能了～

3. [python使用Mongo的教程](http://blog.nosqlfan.com/html/2989.html)

## 关于Mongod和Mongo命令

听pili讲了好一会，才有了一点概念：Mongod比Mongo高一层，Mongod可以指定路径(--dbpath)，Mongo则是指定端口。同一个Mongod可以有好几个Mongo。总体感觉Mongod相当于SQL中的connection，如果两个Mongod指向不同的路径，那么它俩就没有交互，可以独立的读写，而不用担心读和写同时进行，而让数据乱掉。

我现在对它俩的关系的理解就是，Mongod相当于C++中的流，Mongo就是具体的文件。

可以为Mongod和Mongo指定端口。不同的Mongod必须使用不同的端口。不同的Mongo可以使用同一端口。当Mongo和Mongod使用同一端口的时候，这个Mongo就挂到Mongod上了。具体在python中，Mongod相当于一个connection。

## 其它要注意的

* MongoDB的索引值只能为**string**，很神奇~

* 要想指定ObjectID，只用在插入的时候，指定"_id"参数就好

* 关于同一个collection的大小：之前在用MySQL存微博上的数据的时候，同一张表中存入10万条微博，读写的速度都在0.04秒左右，一旦上百万级，就要5秒左右，完全不可以接受。当时把百万级的数据分成了十个表。关于MongoDB存多少合适，我的实验结果是四亿条数据（每条数据都只有一个_id和一个int型的属性值）内都没有问题，一早上插入了4亿条数据，耗时在0.1秒以内就找到了，整个库有50多G。在测试时，每插入5万条左右的数据，就会卡那么一秒，之后再接着插入。应该是MongoDB内部在新建一些结构吧。

* Mongodb的索引只能是string类型，但_id的类型可以是int

未完待续...

