---
title: MySql 檔案還原
date: 2020-12-18 17:23:14
categories:
  - MySql
tags:
---

我原本在本地 Docker 運行一個 redmine 的實體，可是後來某次重開機，mariadb 就一直重啟，無法正常運行，試了很多種方法，就放棄把它運行起來了。

後來看到好險當初有把硬碟掛載到外面，所以 mariadb 的檔案我還取得的到。

<!-- more -->

---

mariadb 的 db 剛好會包成一個資料夾，下面會有一堆 .frm, .ibd 的檔案，跟 mysql 一模一樣。我就想說把這個資料夾搬到我另外一個本地運行的 mysql 就好了。

以下是我遇到的問題

# 權限不對

因為複製過去後，我的資料夾及檔案權限會變成我電腦的使用者，而不是 _mysql。

只要使用 chown 及 chmod 就可以解決

chown：變更資料夾或檔案的擁有者

```
$ sudo chown -R mysql:mysql /data/[db_folder]
```

-R 是遍歷資料夾下所有檔案的意思

chomd：變更資料夾或檔案的使用者權限

```
$ sudo chmod -R 755 /data/[db_folder]
```

# 表格不存在

處理好權限不對問題後，就可以在 DB Tool 看到該資料庫（我最近在用 QueryPie 覺得很好用），可是準備要點開各個 Table 檢查資料後，就被提示 Table dosen't exist 的錯誤，請教了一下 google 大神找到這篇文章：[https://www.itread01.com/content/1547499247.html](https://www.itread01.com/content/1547499247.html)

所以我就把原本舊 DB 下的 ibdata1 這個檔案複製到我新 DB 下，就可以開起來啦～
