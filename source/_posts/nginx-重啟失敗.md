---
title: nginx 重啟失敗
date: 2018-06-04 21:14:21
categories:
    - Nginx
    - OSX
tags:
---

在 mac 執行 nginx 重啟時

```
$ sudo nginx -s reopen
```

出現錯誤：nginx: [error] invalid PID number "" in "/usr/local/var/run/nginx.pid"

```
$ sudo nginx -c /usr/local/etc/nginx/nginx.conf
```

重新指定 nginx configuration(設定檔)

```
$ sudo nginx -s reload
```

重新讀取 nginx 的設定

---

## 參考資料

[极客世杰: nginx: [error] invalid PID number “” in “/usr/local/var/run/nginx/nginx.pid”](https://blog.csdn.net/github_33644920/article/details/51733436)