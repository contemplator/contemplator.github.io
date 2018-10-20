---
title: 修改 Ubuntu 時區
date: 2018-07-10 09:54:15
categories:
    - Ubuntu
tags:
    - timezone
---

查看機器現在時間

```
$ date
```

顯示如下：

```
Tue Jul 10 09:53:12 CST 2018
```

叫出修改時區的程式

```
sudo dpkg-reconfigure tzdata
```

如果我要修改成台灣時區，就是先選 Asia(亞洲) -> Taipei(台北)

然後再次執行 date 查看目前時間是否如自己預期