---
title: MySql 忘記密碼
date: 2017-12-14 23:42:34
categories:
    - MySql
---

略過前情提要，反正這篇在說如果你忘記 MySql root 的密碼的話，你可以怎麼做。

<!--more-->

---

## 關閉 mysql

```
/etc/init.d/mysql stop
```

---

## 執行不用輸入密碼也可以登入 mysql 的模式

```
mysqld_safe --skip-grant-tables &
```

如果你遇到錯誤：
*mysqld_safe Directory '/var/run/mysqld' for UNIX socket file don't exists*

問題大概就是說：/var/run/mysqld 此路徑下的檔案不存在，只要去把該檔案建立起來就好

你可以參考此篇文章：[mysqld_safe Directory '/var/run/mysqld' for UNIX socket file don't exists
](https://stackoverflow.com/questions/42153059/mysqld-safe-directory-var-run-mysqld-for-unix-socket-file-dont-exists)

再重新執行一次指令就好

PS. 執行成功後請不要按任何鍵，也不要關閉終端機，讓他保留執行中的狀態

---

## 登入 mysql

另開一個終端機，然後執行 mysql 進行登入

```
mysql -u root 
```

---

## 修改 root 的密碼

在 mysql 內執行以下 sql 更新密碼

```
update mysql.user set authentication_string=password('root') where user='root';
flush privileges;
```

記得將 'root' 改成自己要的密碼

---

## 退出 mysql 

在 mysql 內

```
exit
```

退出 mysql 後重啟 mysql server

```
/etc/init.d/mysql stop
/etc/init.d/mysql start
```

---

## 測試是否更改成功

```
mysql -u root -p
```

輸入剛剛設定的密碼

---

參考資料：

[mysql修改密碼與忘記密碼重設](http://emn178.pixnet.net/blog/post/87659567-mysql%E4%BF%AE%E6%94%B9%E5%AF%86%E7%A2%BC%E8%88%87%E5%BF%98%E8%A8%98%E5%AF%86%E7%A2%BC%E9%87%8D%E8%A8%AD)

[Unknown column 'password' in 'field list'](http://blog.csdn.net/u010603691/article/details/50379282)
