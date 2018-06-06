---
title: nginx 解決 403 forbidden
date: 2018-06-05 19:59:49
categories:
    - Nginx
tags:
    - 403
---

上次在 nginx.conf 修改預設的 html 資料夾之後，除了 index.html 之外，都是顯示 403 forbidden，完全看不到。

搜尋了一下資料，終於找到解法，一樣是對 nginx.conf 進行修改

```
#user  nobody;
```

改為

```
user  leo staff;
```

PS. leo 是我 mac 登入的 user 名稱，staff 是一定要加的

然後進行設定檔的測試

```
$ sudo nginx -t
```

測試通過之後，在進行設定檔的重新讀取

```
$ sudo nginx -s reload
```

<!--more-->

---

## 參考資料

[Nginx user 配置引发的血案](https://www.sunzhongwei.com/nginx-user-conf-and-endless-loop.html)

[nginx 代理本地的html](http://jiawu.iteye.com/blog/1390383)

[簡書 - nginx 403 Forbidden 排错记录](https://www.jianshu.com/p/e0dadb871894)