---
layout: post
title: "我的git路线"
date: 2013-08-18 01:13
comments: true
categories: 
---
Git是广大人民群众喜闻乐见的版本控制器。以前写代码的时候经常碰到这种情况：想尝试着加点新功能，结果发现出了很严重的bug，想回滚代码，却没有办法，只能根据回忆一点点删改新加入的代码。后来，每当要进行大的变动时，就把原来的代码打个包，备份下。这样做非常的笨。Git就解决了这种问题。

可是，虽然所有人都说git简单易用，但我入门时还是费了很多力气的。以下是我使用git的路线图：

* 入门教材：[看日记学git](http://www.21andy.com/blog/uploads/downloads/2010/12/git_tutorial.pdf)，这是我见过的最好的git学习资料了。看了前十几天的内容就好。

* `git rm`与`rm`的同步问题：在git下使用`rm`命令的时候，会将工作区的文件删掉，但是，git仓库中的文件并不会被删掉。也就是说，现在看来，文件确实是没了，但在commit之后再回滚回来，那些文件，又会出来了。解决办法是，用`git rm`命令，这样，仓库中的文件也被删掉。不过，我经常忘记用`git rm`，怎么办呢？很简单，下次add的时候，多加个参数：`git add -u`，这样会自动刷新暂存区，之后暂存区中的文件就与工作区中的文件一一对应了。git add -h中的介绍是
```
-u, --update          update tracked files
```

* `git reset`与`git revert`的区别：前者是撤销某次commit，后者是回滚代码到某一次commit。此外，前者会删改git的历史（比如说，你撤销了某次commit，这样的话，git的历史中就不会记录这次commit了），而后者不会（事实上，revert会把当前工作区中的代码恢复到以前的某次commit，然后新增加一次新的commit）。有点晕是吧，[stackOverflow上有很详细的讲解](http://stackoverflow.com/questions/8358035/whats-the-difference-between-git-revert-checkout-and-reset/8358039#8358039)。当然，更晕的是，通过加不同的参数，这两个命令，有时可以起同样的作用。不要研究太深，需要用到的时候再去查就好。

未完待续...
