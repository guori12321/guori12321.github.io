---
layout: post
title: "About Hadoop"
date: 2013-12-23 17:21
comments: true
categories: [Tech, Hadoop]
---

在海量数据计算研究中心一年多了，类似"大数据"这种专业词汇也听了不知道多少次了。只可惜自己还是一知半解，只知道拿着实验室各位老板的名号出来骗人...现在总算有一点时间了，来安心的研究Hadoop和Prege什么的吧~

<!--more-->

## Mac下安装Hadoop

显然用`homebrew`安装是最省事的。[这篇博客](http://importantfish.com/how-to-install-hadoop-on-mac-os-x/)中有详细的介绍。

## 概览

Hadoop号称是并行划计算的框架。我之前一直以为，我们把程序的源代码直接扔进去，它就会帮我们来并行的执行了。事实上，我们需要把源代码重新改写，然后Hadoop才能去并行化的执行代码。

我们也可以把Hadoop看成一个类库。每个应用Hadoop的程序，总是要包含大量的Hadoop的包。而为了执行Hadoop中的Map和Reduce这两个步骤，我们需要继承一些类和接口，实现它们中的一些方法。此外，我们的输入和输出文件，还需要放在所谓的Hadoop Distributed File System(HDFS)。

做完以上几步，也就能运行简单的基于Hadoop的程序了。当然，进阶一些的话，还有关于诸如cache之类的我们要细致调整的部分。那些内容等到需要的时候再慢慢研究就好。

## 官方的教程

Hadoop的资料非常多。当然，我们最先要看的，肯定是[Hadoop的官方教程了](http://hadoop.apache.org/index.pdf)。一共42页。这是一部面向**使用者**的教程。当然，后期开发中，也要参考[官方的文档](http://hadoop.apache.org/docs/r0.18.3/)。

看完这个教程，我发现，Hadoop远比我想象中的要复杂：涉及到太多的模块了。但是，别害怕，我们只是想做一些Hadoop上的应用，而不是进行Hadoop的开发，我们只要按着别人给出的例子，修改修改，做出我们想做的功能就好了。

## 官方教程的笔记

以下是我自己的笔记，仅供参考...我的子标题，与教程中的子标题是对应的。

### Overview

* Hadoop的输入输出，都在HDFS中。

* 每个Hadoop网络(由集群机中的各个结点组成的网络)，都有一个叫作`JobTracker`的结点，它负责向各个子结点分配任务，监视各个子结点的状态，并重复执行失败的任务。而每个子结点，都有一个`TaskTracker`，它负责多进程\线程地执行`JobTracker`分配给它的任务。

* 虽然Hadoop本身是用Java写的，但基于它的应用，可以用其它语言，比如C/C++来写。

### Inputs and Outputs

正常的输入输出过程是这样：
```
(input)<k1, v1> -> **map** -> <k2, V2> -> **combine** -> <k2, v2> -> **reduce** -> <k3, v3>(output)
```

可以看出，每一步都是键值对(比如<k1, v1>)。就像关系型数据库用table来表示数据之间的关系，Hadoop使用这种键值对。于是，就有了个问题：所有的输入和输出，都能拆成这样的键值对吗？我问过老师，老师说，大家都是想办法拆出来的，很多时候还是在硬拆...另一方面，老师也说过，大数据的解决方案中，只有Hadoop是相对成熟的。总之，这就是Hadoop的运行规则。也许以后大家会找到更好的解决方案呢~

此外，可以看出，除了map和reduce这两步，中间还多出一个combine。map这一步，是把输入，映射到一个中间层(intermedia)，原先的输入，可能是一个映射到一个，也有可能是多个映射到一个，所以说，map后会比较乱，这时可能需要把映射后的产物合并或排序，这就是所谓的combine。

PS: 我不知道Hadoop的Map能不能一映射多(Prege中应该是可以)，如有知道的同学，请告诉我，谢谢...

### Example: WordCount V1.0

官方的教程给了这么个统计单词个数的例子。

InputFile01:
```
Hello World Bye World
```

InputFile02:
```
Hello Hadoop Goodbye Hadoop
```

Output:
```
Bye 1
Goodbye 1
Hadoop 2
Hello 2
World 2
```

以下是这个例子的源代码。一共58行，不算长。我会在代码中加入汉语的注释来进行解说：
```
package org.myorg;

import java.io.IOException;
import java.util.*;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapred.*;
import org.apache.hadoop.util.*;

//可以看出，是import了很多

//像其它Java程序一样，我们写的程序，也就是一个WordCount类，其中会有一个main函数。
public class WordCount {

    //关于Mapper，[官方的文档](https://hadoop.apache.org/docs/stable/api/org/apache/hadoop/mapred/Mapper.html)的解释是: Interface Mapper<K1,V1,K2,V2>，也就是确定一下这四个变量(输入和输出)的类型，类似于C++中的模板
    public static class Map extends MapReduceBase implements Mapper<LongWritable, Text, Text, IntWritable> {
    //关于final，是指只可被赋值一次的变量。final类型的变量，永远指向同一个object，但这个object本身可能会改变。更多的内容，参考[Java的文档](http://docs.oracle.com/javase/specs/jls/se7/html/jls-4.html#jls-4.12.4)
      private final static IntWritable one = new IntWritable(1);

      private Text word = new Text();

      public void map(LongWritable key, Text value, OutputCollector<Text, IntWritable> output, Reporter reporter) throws IOException {
        String line = value.toString();
        StringTokenizer tokenizer = new StringTokenizer(line);
        while (tokenizer.hasMoreTokens()) {
          word.set(tokenizer.nextToken());
          output.collect(word, one);
        }
      }
    }

    public static class Reduce extends MapReduceBase implements Reducer<Text, IntWritable, Text, IntWritable> {
      public void reduce(Text key, Iterator<IntWritable> values, OutputCollector<Text, IntWritable> output, Reporter reporter) throws IOException {
        int sum = 0;
        while (values.hasNext()) {
          sum += values.next().get();
        }
        output.collect(key, new IntWritable(sum));
      }
    }

    public static void main(String[] args) throws Exception {
      JobConf conf = new JobConf(WordCount.class);
      conf.setJobName("wordcount");

      conf.setOutputKeyClass(Text.class);
      conf.setOutputValueClass(IntWritable.class);

      conf.setMapperClass(Map.class);
      conf.setCombinerClass(Reduce.class);
      conf.setReducerClass(Reduce.class);

      conf.setInputFormat(TextInputFormat.class);
      conf.setOutputFormat(TextOutputFormat.class);

      FileInputFormat.setInputPaths(conf, new Path(args[0]));
      FileOutputFormat.setOutputPath(conf, new Path(args[1]));

      JobClient.runJob(conf);
    }
}
```

翻译一下官方的解释吧，这几十行实在看不大懂：

这几行代码真是简洁明快(你妹！)，Mapper类中，通过map方法，每次处理一行(这些输入的行的类型，在main方法中定义了(TextInputFormat))。之后，它把每行都通过空格来分割(通过StringTokenizer)，然后生成一个类似于`< <word>, 1>`的键值对。

第一个输入文件在map后会生成

```
< Hello, 1>
< World, 1>
< Bye, 1>
< World, 1>
```

第二个文件

```
< Hello, 1>
< Hadoop, 1>
< Goodbye, 1>
< Hadoop, 1>
```

再之后，是**排序**并把上述的中间结果进行**combine** (main方法中定义了combine的方法)。注意，这里是每个文件的结果各自combine。这里的combine，也可以看作是map。

第一个文件会变成

```
< Bye, 1>
< Hello, 1>
< World, 2>
```

第二个文件

```
< Goodbye, 1>
< Hadoop, 2>
< Hello, 1>
```

再之后就是reduce了。它对应的代码与map类似。这时候，两个文件产生的中间结果，就会被排序并合并/缩减到最终的结果：

```
< Bye, 1>
< Goodbye, 1>
< Hadoop, 2>
< Hello, 2>
< World, 2>
```

## 教材中的其它部分

在上面的例子之后，教材中详细讲了怎样运行这个例子，这一部分需要一些命令行的知识，传的参数也是非常的多。再之后，则是讲Mapper和Reducer等具体和哪些Hadoop中的类相关。这些内容就非常具体了，大家慢慢看就好。

写到这里，不知道算不算有用呢？有需要的时候我再回来补充吧。
