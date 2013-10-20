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

这时，你已经完成了tex源代码上的操作。下来就是编译。要编译好几次(以下操作也可以在TeXShop中完成)

```
pdflatex main.tex %注意，是pdflatex，不是pdftex
bibtex main %注意，这里是main，不是main.tex，也不是mybib或mybib.bib
pdflatex main.tex
pdflatex main.tex
```

###总结一下容易出错的地方
其实很多地方容易出错。

* 在tex中引用bib文件时，不加.bib
* 在latex和pdftex时，要加.tex缩写名
* 在bibtex时，是针对tex编译，而不是bib文件，另外，tex也不加缩写名。
* 编译时，如果用pdftex而不是pdflatex，会报错。具体参考[这里](http://www.latex-community.org/forum/viewtopic.php?f=5&t=3164)。

另外，在写tex时，有以下容易犯的错误

* 对于下标，如a_b，如果不对单词b加{}，则latex只默认b中的第一个字母为a的下标，其它的字母是和a并列的。也就是说，当单词b多于一个字母的时候，我们要对它加{}。

##在LaTeX中引用URL
写论文的时候，有时候要在参考文献中引用一些网址（比如Stanford的SNAP组的数据）。[这里](http://tex.stackexchange.com/questions/35977/how-to-add-a-url-to-a-latex-bibtex-file)很清楚的讲解了这个问题。

首先在tex中，/usepackage{url}，之后就在bib中插入下面的代码就好
```
@misc{bworld,
  author = {Ingo Lütkebohle},
  title = {{BWorld Robot Control Software}},
  howpublished = "\url{http://aiweb.techfak.uni-bielefeld.de/content/bworld-robot-control-software/}",
  year = {2008},
  note = "[Online; accessed 19-July-2008]"
}
```

##在LaTeX中用Mathtype
简单的公式，我也就手写了。可是，复杂的公式，手写完自己都读不懂了。还是老实的用Mathtype吧。

Mac下的Mathtype的安装也十分简单。只是，在Mathtype中写好公式，要粘到LaTeX中，要专门设置一下，不然粘出来的东西很奇怪。

在Mathtype中，找到`Preference`，再选`Cut and Copy Preference`，之后选中第二栏`MathML or TeX`，下拉菜单中选`Plain TeX`,下面的两个打勾的框都不要打勾。这样，在Mathtype中写好公式，就能直接粘到tex文件中。

##在LaTeX中引用图像
首先引用包
```
\usepackage{graphicx}
```
然后就可以使用以下的语句在需要的地方引用图像了。我只试过png图像(在figures文件夹下的figure1.png)是可以的，其它的[参考这里](http://bbs.sjtu.edu.cn/bbstcon,board,TeX_LaTeX,reid,1254670022.html)。

```
\begin{figure}
    \centering
    \includegraphics[width=1\textwidth]{figures/figure1}
    \caption{The Updating Ratio of an Inactive Account}
    \label{figure:inactive}
\end{figure}
```
之后引用图像的时候，用`Figure ~\ref{figure:inactive}`就能引用了。

##使用表格

下面是一个使用表格的例子
```
\begin{table}
\centering
    \begin{tabular}{|c|c|c|c|}
            \hline
            Weight & Message Number & Total Crawl Time & Avg \#Msg. with 1 crawling \\
            \hline
            0.9 & 1451435 & 50421 & 28.79 \\
            \hline
    \end{tabular}
    \caption{The Hash Model Experiment Results}
    \label{table:hash}
\end{table}
```
与图表一样，之后引用的时候，用`Table ~\ref{table:hash}`。

##引用伪代码
[这篇清华科协的人人网日志](http://blog.renren.com/share/302655693/15587298311)讲的非常清楚。如果安装MacTeX时，是安装的完整版，则不用下载要用的包，MacTeX本身就已经带了。

[伪代码包的文档](http://www.cs.dartmouth.edu/~thc/clrscode/clrscode.sty)，也许需要用。
