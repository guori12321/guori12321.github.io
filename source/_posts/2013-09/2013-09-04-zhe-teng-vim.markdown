---
layout: post
title: "折腾vim"
date: 2013-09-04 10:38
comments: true
categories: [vim]
---
现在用vim仅仅是比用记事本高效，很多功能还没搞明白...

配置vim是个很折腾的过程，我用的是[spf13](https://github.com/spf13/spf13-vim)，只可惜用这个配置，一样有很多地方要改动。[我的.vimrc.local](https://gist.github.com/guori12321/7211967)。我的使用习惯是：

<!--more-->

* 在它的.vimrc中把所有'nowrap'改为'wrap'。写代码的时候不自动折行还好，但写日志等文本内容，不折行就没法用了。

* spf13中每次保存的时候都会自动帮你编译一下，并报出所有的语法错误。只是这种做法带来很多问题：语法检查过于严格，声明完变量不使用都会报错；报错时会新建一个分栏，每次报错后我都要自己关掉它；最不能忍的是，有时候保存一下，然后vim就会自动退出。解决：`echo let\ g:pymode_lint\ =\ 0 >> ~/.vimrc.local`。

* Close the Code Checking \ syntastic in spf13: `echo let\ g:pymode_lint\ =\ 0 >> ~/.vimrc.local`。

* 我习惯在Insert中把<C-H>绑定为向左，<C-L>为向右。在.vimrc或.vimrc.local中设置都会失效。解决：用`imap <C-H> <Left>`而不要用`inoremap`，怀疑是内部的键位绑定冲突。
