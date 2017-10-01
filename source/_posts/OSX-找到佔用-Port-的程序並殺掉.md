---
title: OSX 找到佔用 Port 的程序並殺掉
date: 2017-10-01 23:00:27
categories:
    - OSX
tags:
---

身為一個攻城屍，電腦的 Port 被佔是很常見的事情，但是每次都想不起來怎麼找到並殺掉..

<!--more-->

---

## 找到佔用 port 的程序

```
lsof -i tcp:3000 
```

tcp:3000 就是找到佔用 Port 3000 的條件

## 殺掉指定的 PID 程序

```
kill -9 <PID>

```

---

## 參考資料

[stackoverflow](https://stackoverflow.com/questions/3855127/find-and-kill-process-locking-port-3000-on-mac)