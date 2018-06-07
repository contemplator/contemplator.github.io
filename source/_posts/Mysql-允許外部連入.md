---
title: Mysql 允許外部連入
date: 2018-06-06 11:01:52
categories:
    - MySql
tags:
    - access
    - remote
---

架了一個 VPS server，一般都不會想要登入進去在 VPS server 上直接操作，一是因為速度通常有點慢，二就是用的工具可能不順手，像是我就習慣用圖形介面工具操作 MySql。

我的 Mysql 版本 5.7

<!--more-->

---

## 安裝 Mysql

先假設你已經安裝了 Mysql Server，不知道可以參考這篇：[How To Install MySQL on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-16-04)

---

## 修改 Mysql 設定檔 - /etc/mysql/mysql.conf.d/mysqld.cnf

註解原本的 bind-address
```
# bind-address          = 127.0.0.1
```

改成自己 VPS 的 IP

```
bind-address            = <your-ip>
```

** 更新 2018-06-06 **

如果你的 Mysql Server 要允許外部連入，但是也要允許 localhost 連入，就直接把 bind-address 都註解就好，連 bind-address = VPS IP 都不要

## 重啟 mysql

```
$ sudo /etc/init.d/mysql restart
```

---

## 新增 mysql user

### 登入 MySql

先登入 mysql 

```
$ mysql -u root -p
```

會要求輸入 root 的密碼，密碼就是一開始安裝 MySql 時設定的，如果忘記了，也不必重新安裝，參考這一篇文章：[MySql 忘記密碼](https://contemplator.github.io/blog/2017/12/14/MySql-%E5%BF%98%E8%A8%98%E5%AF%86%E7%A2%BC/)

### 新增 User

登入之後開始新增 User

```
CREATE USER 'newuser'@'%' IDENTIFIED BY 'mypass';
```

newuser 是 user 登入的名稱
% 是允許 newuser 從任意 IP 登入
mypass 是 newuser 的密碼

### 查詢 Mysql 內的 User

```
select user, host from mysql.user;
```

結果會長這樣

```
+------------------+-----------+
| user             | host      |
+------------------+-----------+
| newuser          | %         |
| debian-sys-maint | localhost |
| mysql.session    | localhost |
| mysql.sys        | localhost |
| root             | localhost |
+------------------+-----------+
```

### 刪除不必要的 user

如果上一步做錯了，想要重來，就 Drop 掉 user 就好

```
DROP USER 'newuser'@'%';
```

### 修改 user 的 host

不建議這樣做，因為我修改了 root host 之後，可能導致 user 有兩筆資料

```
+------------------+-----------+
| user             | host      |
+------------------+-----------+
| root             | %         |
| root             | localhost |
+------------------+-----------+
```

結果搞了半天還是無法從我的筆電登入

### 修改 newuser 權限

```
GRANT ALL ON *.* TO 'newuser'@'%';
```

這意思是將所有 database 下的 table 都給予 newuser 所有權限

記得要將系統記錄的權限更新

```
FLUSH PRIVILEGES;
```

---

## 開通防火牆

```
$ /sbin/iptables -A INPUT -i eth0 -p tcp --destination-port 3306 -j ACCEPT
```

PS. eht0 是 網路卡名稱，像是我是在 Vultr 買的 VPS，查出來的結果是 ens3

查詢的方式，在 VPS server 輸入以下指令

```
$ ifconfig
```

![ifconfig result](/blog/images/ifconfig_result.pns)

---

## 測試

先回到自己的電腦上，也就是從 ssh login 登入

```
$ exit
```

MySql 遠端登入

```
mysql -u newuser -h <mysql-server-ip> -p
```

輸入當初新增 user 時設定的密碼，就可以了。

如果不行，就要查看錯誤訊息是什麼，歡迎留言。

### 測試是否可以連到 mysql，先不論帳號密碼和權限

```
telnet <your-mysql-ip> 3306
```

PS. 3306 是 mysql 預設的 port

---

## 參考資料

[How To Install MySQL on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-16-04)

[how-do-i-start-stop-mysql-server](https://askubuntu.com/questions/82374/how-do-i-start-stop-mysql-server)

[mysql-adding-user-for-remote-access](https://stackoverflow.com/questions/16287559/mysql-adding-user-for-remote-access)

[查詢 MySQL 對 此帳號 開放(GRANT)哪些權限](https://blog.longwin.com.tw/2009/06/query-mysql-show-grant-permission-2009/)

[enable-remote-mysql-connection-error-1045-28000-access-denied-for-user](https://stackoverflow.com/questions/8380797/enable-remote-mysql-connection-error-1045-28000-access-denied-for-user)

[how-do-i-enable-remote-access-to-mysql-database-server](https://www.cyberciti.biz/tips/how-do-i-enable-remote-access-to-mysql-database-server.html)

[DROP USER Syntax](https://dev.mysql.com/doc/refman/8.0/en/drop-user.html)

[CREATE USER Syntax](https://dev.mysql.com/doc/refman/8.0/en/create-user.html)

[How Do I Enable Remote Access To MySQL Database Server?](https://www.cyberciti.biz/tips/how-do-i-enable-remote-access-to-mysql-database-server.html)

[SET PASSWORD Syntax](https://dev.mysql.com/doc/refman/8.0/en/set-password.html)