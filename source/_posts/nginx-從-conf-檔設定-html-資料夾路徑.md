---
title: nginx 從 conf 檔設定 html 資料夾路徑
date: 2018-06-04 21:32:37
categories:
    - Nginx
tags:
---

```
server {
    listen       80;
    server_name  localhost;

    location / {
        root   html;
        index  index.html index.htm;
    }
}
```

改為

```
server {
    listen       80;
    server_name  localhost;

    location / {
        root   /Users/idlefox/Sites;
        index  index.html index.htm;
    }
}
```

在執行重新讀取設定檔指令

```
$ sudo nginx -s reload
```