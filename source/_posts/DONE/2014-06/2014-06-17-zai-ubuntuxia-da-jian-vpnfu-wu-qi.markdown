---
layout: post
title: "在Ubuntu下搭建VPN服务器"
date: 2014-06-17 22:18
comments: true
categories: [VPN, Ubuntu]
---

人在天朝就活着特别艰难...我回来以后，因为不能访问Twitter的原因，我差点没办法演示我的基于Twitter的毕业设计。可恨这种时候，我也不能说，请到综合楼七楼找方老师...以前方老师和我的导师在同一个组里，自己人何苦为难自己人...

根据[这篇博客](http://yansu.org/2013/12/11/deploy-pptp-vpn-in-ubuntu.html)，为了在Ubuntu下搭建VPN服务器，我们需要

```
wget -c https://raw2.github.com/suyan/Scripts/master/Setup/pptp.sh
chmod +x pptp.sh
./pptp.sh
```

原作者把VPN的搭建写成了一个脚本，我和他都用的是`digitalocean`，我实测是可以用的。这是我在网上找到的第六篇教程，终于有一个能用的了...哎，一晚上就这么过去了...

注意： 上述的文章的VPN的账号和密码都是test，ip则为你自己的VPS的ip。
