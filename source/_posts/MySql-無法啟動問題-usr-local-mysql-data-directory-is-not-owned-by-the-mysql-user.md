---
title: MySql 無法啟動問題 - /usr/local/mysql/data directory is not owned by the mysql user
abstract: 此文章已經被加密，進入後請輸入密碼
date: 2020-09-08 10:54:35
categories:
  - MySql
tags:
---

主因是因為之前試做一些 python 程式時，因為需要調整環境變數時，動到 /usr/local 的權限了。

/usr/local 資料夾以及下面的檔案及資料夾擁有者和權限都更動到，導致 /usr/local/mysql/data 的擁有者不再是 mysql

在 terminal 執行已指令就可以了

```
sudo chown -R mysql /usr/local/mysql/data
```

可以使用 ls -la 檢查擁有者及權限

參考資料：https://www.itread01.com/content/1544114825.html
