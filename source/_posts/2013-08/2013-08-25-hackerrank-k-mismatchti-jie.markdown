---
layout: post
title: "HackerRank K-mismatch题解"
date: 2013-08-25 14:39
comments: true
categories: [题解, hackerrank]
---
其实算不上题解，只是讲讲自己的解题的思路吧。最后也没做出来，50分拿了25分。

[题目地址](https://www.hackerrank.com/contests/quantium/challenges/k-mismatch)

给定一个字符串，对它的任意两个长度相同的子串，若这两个子串的同一位置处的不同的字符的个数少于一个阈值k，就将这两个子串统计下来。问，一共有多少个满足要求的子串对。

<!--more-->

同一个字符串，有很多子串，子串对就更多了。因此这道题目对算法的效率的要求就比较高了。最朴素的办法，是，先枚举子串的长度，再枚举第一个和第二个子串的起始位置，之后再比较两个子串的不同字符的个数。这样的话，是O(N^4)的复杂度。

分析下上面的思路，有哪里做了**重复工作**呢？是最后比较的那里，因为对于长度相同而位置只差一位的两个子串来说，它两只是错了一位而已，没必要全部重新比较下。我们可以用**扩展**的办法，来进行子串的比较。

具体就是：先枚举第一个和第二个子串起点的差值（即这两个子串的距离），再枚举第一，二个子串的起点。刚开始的时候，把两个子串所有位置都比较一次，把不同的字符的个数记录下来。之后，这两二个子串分别向后移动了一位，这时，只用比较移出去的那位字符，和移进来的新字符是否相同就好了，根据这两位字符的情况，在上一次的记录上加减就好了。这样对空间的要求也不高，只用了一个临时的记录不同字符的int而已。（事实上我先是开了很大的数组，后来才发现可以优化）

代码如下：
```
# -*- coding: utf-8 -*-

def mismatch(a, b):
    global K
    tot = 0
    for i in range(len(a)):
        if a[i] != b[i]:
            tot += 1
            if tot > K:
                return K+1
    return tot

K = int(raw_input())
S = raw_input()

ans = 0
team = []

#先计算小于 或 等于K的子串对
for i in xrange(1,K+1):
    ans += ((len(S) - i + 1)*(len(S) - i)) / 2

#枚举两个子串的位置的差值 边界值：第一个子串固定，第二个一直移动到最后
for i in xrange(1, len(S) - (K+1)+1):
    #misMatrix[0][i] = mismatch(S[0:K+1], S[i:i+K+1])
    mis0 = mismatch(S[0:K+1], S[i:i+K+1])
    if mis0 <= K:
        ans += 1

    #枚举第一个子串的其它位置，第二个子串和它距离为i
    for j in xrange(1, len(S)-(K+1)):
        if j+i+K >= len(S):
            break
        #misMatrix[j][j+i] = misMatrix[j-1][j+i-1]
        mis = mis0
        if S[j-1] != S[j+i-1]:
            mis -= 1
        if S[j+K] != S[j+i+K]:
            mis += 1
        if mis <= K:
            ans += 1

            zz = 0
            t = mis
            while j-zz >= 0 and t <= K:
                zz += 1
                if j-zz < 0:
                    break
                if S[j-zz] != S[j+i-zz]:
                    t += 1
                    if t <= K:
                        ans += 1
                    else:
                        break
                else:
                    ans += 1

        mis0 = mis
print ans
```

然后就只拿了25分...做这个题目花了很久的时间，加起来三四个小时了吧，因为一些边界和变量名打错的bug一直没调出来...写代码还是要头脑清醒啊。

谁会做告诉我下吧...谢谢...
