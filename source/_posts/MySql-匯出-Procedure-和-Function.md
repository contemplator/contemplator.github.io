---
title: MySql 匯出 Procedure 和 Function
date: 2018-06-18 17:50:27
categories:
    - MySql
tags:
    - prodecure
    - export 
    - function
    - 匯出
    - 預儲程序
---

```
mysqldump -u user -p db-name --routines > export-file.sql
```

<!--more-->

---

## 匯出指令

過去的指令為

```
mysqldump -u <user> -p <db-name> > <file-name>.sql
```

之前匯出的指令包含 table 的 create，以及資料的 insert，但是後來嘗試開始使用 Procedure，發現並沒有一起匯出。

如果要一起將 Procedure 和 Function 一併匯出，需要加上 routines 參數

```
mysqldump -u <user> -p <db-name>  --routines > <file-name>.sql
```

PS. 也會將 Trigger 也匯出，只是我還沒有用過 Trigger

---

## mysqldump: insufficient privileges to show create function 

如果你遇到此問題，是因為登入 MySql 的使用者權限不足，假設登入的是 user01，而 user01 只有在某個 Database 有所有權限是不夠的。

請替 user01 增加預儲程序的權限

```
GRANT SELECT ON mysql.proc to 'user01';
```

記得要刷新權限

```
FLUSH PRIVILEGES;
```

---

## 參考資料

[description](http://www.ducea.com/2007/07/25/dumping-mysql-stored-procedures-functions-and-triggers/)

[description](https://stackoverflow.com/questions/30841351/mysqldump-insufficient-privileges-to-show-create-function-funcation-name/32765366)