---
layout: post
title: "Vim自动更新Tags"
date: 2014-04-20 21:01
comments: true
categories: ['vim']
---

毕业设计做到现在，函数比较多，自己一点点用文本查找的方式来跳转就比较慢了。之前一直知道有个叫`ctags`的东西，但一直没用。这次就试试吧~~

<!--more-->

首先，你要安装它。在Mac下
```
brew install ctags
```

然后，在你要生成tag的地方，比如说你的项目的根目录下，输入
```
ctags -R .
```

这样，整个项目的tag就都生成好了。ls一下，可以看到有个叫`tag`的文件。这就是生成的tag。

如果不想生成整个项目的tag，可以用
```
ctags fileName
```
来生成fileName文件的tag。

之后，你想查看某个函数定义的时候，就可以按`Ctrl + ]`来跳转到光标所在处的函数的定义处了。想跳回来，要按`Ctrl + T`。按`<Leader>''`可以在屏幕右侧打开一个小面板，显示左边的函数的定义。在右边的函数处按<CR>（其实就是回车），就可以跳转到左边的函数定义处。

## 如何自动生成tag?

tag用起来是挺方便，但是，每次都要手动更新，很多人，比如我，都会觉得很麻烦。怎么解决这个问题呢？？

查了挺多资料，最后还是决定用[easy-tags](https://github.com/xolox/vim-easytags)插件。我是通过Vundle来安装的。话说Vundle更新了一下，结果命令都从Bundle变成了Plugin了...好不习惯...在vimrc中自己的Vundle的位置，加上
```
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-easytags'
```
之后在Vim中输入`:BundleInstall`命令，就安好了。之后重启Vim就好。

## 总结
这么个问题搞了一个晚上...本来是想写码，结果光折腾了...折腾的很累...真是过了折腾的年纪了...
