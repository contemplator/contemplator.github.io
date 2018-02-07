---
title: Nodejs 程序管理-pm2 (TB)
date: 2018-02-04 14:02:22
categories:
    - Nodejs
tags:
    - pm2
---

在一開始，如果要執行 nodejs 開發和運行的網站伺服器，都會使用 termial 終端機執行 node index.js 這樣的方式。現在使用 pm2 就可以管理 nodejs 的網站和其他程序。

<!--more-->

---

最簡單的用法

## start

啟動 nodejs 程式

切換到 nodejs 專案底下，看要執行的檔案是 index.js 還是 server.js，如果是 server.js 的話：

```
pm2 start server.js
```

## list 

顯示目前 nodejs 程式列表

```
pm2 list
```

## 


```