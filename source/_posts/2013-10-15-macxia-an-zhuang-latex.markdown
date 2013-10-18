---
layout: post
title: "mac下安装LaTeX"
date: 2013-10-15 18:31
comments: true
categories: [tex, 各种折腾, 学习笔记]
---

LaTeX的重要性我就不多说了。这是最靠谱的写论文的方式，比Word靠谱多了。

我是参考[康同学的人人网日志](http://blog.renren.com/blog/279888129/773543899)，来配置的。

<!--more-->

在Mac下安装Tex非常的简单，首先从[源列表](http://tug.org/mactex/mirrorpage.html)里挑一个速度比较快的（我用的是日本的，平均500K的样子），然后打开安装就好。

安装后，打开TeXShop，就可以写TeX文档了。这时，我发现中文显示出来乱码，于是，[参考了这篇文章](http://blog.csdn.net/quantumpo/article/details/9317925)，在TeXShop中，在`宏`下面的`Encoding`中，选择`UTF-8 Unicode`，之后就可以正常使用中文了。

##关于参考文献和bibtex
折腾了一早上总算搞明白怎么在LaTeX里加入参考文献了。

其实很简单，比如说，你有两个文件，一个叫`main.tex`，一个叫`mybib.bib`，然后你要在前者中引用后者。后者是一个数据库，也就是说，你可以在后者中加入很多的东西，而不在tex中引用。我们编译的时候，也只针对tex编译，而不针对bib文件。

首先，在main.tex的\end{document}**之前**，加入
```
\bibliographystyle{model1-num-names} %选择bib的模板，也就是说，参考文献显示出来是什么样子。这种模板一般会由你要投稿的会议或期刊给出。
\bibliography{mybib} %指定你要引用的bib文件，注意，这里**不加**.tex
```

然后，是在你的bib文件中，写入你要引用的论文。在[scholar.google.com](scholar.google.com)中可以直接粘出来符合要求的bib格式的引用，直接粘到你的bib文件中就好。不同的论文之间空上一行就好。比如说，下面这篇是我的某篇论文的bib引用
```
@incollection{guo2013cuvim,
  title={CUVIM: extracting fresh information from social network},
  author={Guo, Rui and Wang, Hongzhi and Li, Kaiyu and Li, Jianzhong and Gao, Hong},
  booktitle={Web-Age Information Management},
  pages={351--362},
  year={2013},
  publisher={Springer}
}
```

接下来，就是要在你的tex文件中引用这个bib中的论文。直接在要引用的地方，输入`\cite{something}`就好。在上面的例子中，是`\cite{guo2013cuvim}`。

这时，你已经完成了tex源代码上的操作。下来就是编译。要编译好几次

```
latex main.tex
bibtex main %注意，这里是main，不是main.tex，也不是mybib或mybib.bib
pdftex main.tex
pdftex main.tex
```

###总结一下容易出错的地方
其实很多地方容易出错。
* 在tex中引用bib文件时，不加.bib
* 在latex和pdftex时，要加.tex缩写名
* 在bibtex时，是针对tex编译，而不是bib文件，另外，tex也不加缩写名。

