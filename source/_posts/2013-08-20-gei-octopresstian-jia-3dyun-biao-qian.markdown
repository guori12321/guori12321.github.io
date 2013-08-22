---
layout: post
title: "给octopress添加3D标签云"
date: 2013-08-20 13:26
comments: true
categories: [各种折腾, octopress, 生活剪影, 学习笔记, 旅途分享, 各种折腾, 书评影评]
---

3D标签云的效果看右栏。很炫很神奇～

具体做法是：

1. 从我的github库中[下载源代码](https://github.com/guori12321/octopress-cumulus/archive/master.zip)

2. 把相应的文件粘到自己octopress，另外在边栏那里把它显示出来就好。具体参考我的github上的[README](https://github.com/guori12321/octopress-cumulus)。

## Octopress 3D categories/tags-cloud configuration for non-English tags

You can see my 3D categories-tag at the right sidebar. It's awesome! However, the origin version doesn't support **non-English** tags, so I revised the codes and put them in my github. It now works!

It's easy to configuration:

1. Download the source codes from my [github repo](https://github.com/guori12321/octopress-cumulus/archive/master.zip)

2. Copy the codes to your octopress. The detail is given at [my github repo README](https://github.com/guori12321/octopress-cumulus)

<!--more-->

##我之前碰到的问题

主要是不支持汉语标签。虽然这个插件的作者是中国人，但是他俩的博客都是全英文，所以不存在这个问题。我还是很想用汉语标签的。octopress本身支持汉语标签，点击汉语标签后，会发现它把路径中的汉字转成**拼音**了，所以说就不存在汉语路径的问题。

这个插件原本是直接用汉语作路径的，于是我就按照[这篇文章](http://notes.liyaos.com/blog/2013/01/18/octopress/)把标签的路径设定为汉语的了。在本地上preview没问题，但deploy到github上就无法识别，会报404错误。怀疑与github那边的编码方式有关。

既然无法用汉语作路径，那还是按octopress原先的办法，用拼音作路径吧。于是我对这个插件进行了[小小的改动](https://github.com/guori12321/octopress-cumulus/commit/0af2339ba1f2ce574a8a17d706e56b3aee6835a1)。终于，一切正常了～～
