---
title: 在 VS Code 執行 mysql query
date: 2018-02-10 15:51:28
categories:
    - Visual Studio Code
tags:
    - Mysql
---

今天要介紹一個可以直接在 VS code 執行 Mysql SQL 指令的套件。除了可以直行 query 之外，也會支援 mysql 的 sql 語法，不然沒有安裝擴充套件，mysql 的許多指令都會被當作錯誤 T^T

<!--more-->

---

## 安裝套件

打開擴充功能，搜尋 vscode-database，點開後看到這個就是了：[vscode-database](https://marketplace.visualstudio.com/items?itemName=bajdzis.vscode-database)

---

## 連上 Mysql Server 

使用快捷鍵 Command ⌘ + Shift ⇧ + P 叫出指令輸入視窗

先輸入 sql 或圖片上顯示的關鍵字查詢連上 Mysql Server 的功能

![sql connect to Mysql](/blog/images/sql connect to Mysql.png)

依照順序輸入需要的資料：

mysql

可以選擇連接 mysql 或 postgres 

host name

如果要連上本地端的 Mysql 就是輸入 localhost

user name

登入 mysql 的帳號

password

剛剛輸入帳號的密碼

成功之後就會跳出一則訊息告知你現在是 

![Mysql connect success](/blog/images/mysql connect success.png)

---

## 編輯一個 sql 檔案

建立一個 test.sql。

最重要的是副檔名要是 .sql 

然後試著輸入簡單的 sql，像是：

```
select 1+7;
```

PS. 當你輸入 select 會有自動完成的提示，目前我還沒研究出他為什麼會這麼難用

---

## 執行 sql query 

在 test.sql 選起剛剛輸入的 query 指令，或者使用 Command ⌘ + A 全選起來，

然後使用快捷鍵 Command ⌘ + Shift ⇧ + E 就可以執行選起的 sql query。

然後你就可以在下方的輸出頁籤看到結果

![sql query result](/blog/images/sql query result.png)

---

參考資源：

[vscode-database](https://marketplace.visualstudio.com/items?itemName=bajdzis.vscode-database)