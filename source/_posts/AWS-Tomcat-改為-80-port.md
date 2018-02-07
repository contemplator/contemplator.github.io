---
title: AWS Tomcat 改為 80 port
date: 2018-02-07 22:03:28
categories:
    - AWS
tags:
    - tomcat
    - prerouting
---

因為同事在 AWS 架了一個簡單的伺服器，專門處理測試中的網站專案，我們現在習慣都是架 Tomcat，Tomcat 預設運行在 8080 port，這篇要說的是我這次發現可以怎麼做

<!--more-->

---

原本我是到 tomcat 資料夾下的 server.xml 將 port 從 8080 改為 80。

在 AWS 的 linux 系統 server.xml 應該是放在 /var/lib/tomcat8/conf/ 下

打開會看到類似下面的內容

```
<Connector port="8080" protocol="HTTP/1.1"
    connectionTimeout="20000"
    URIEncoding="UTF-8"
    redirectPort="8443" />
```

我就試著把 port="8080" 改成 port="80"

透過 tomcat restart 重啟也是沒問題的，在 firewall 的規則也加上允許外部訪問 80 port 的規則，可是結果還是無法使用 80 port 開啟網頁。

後來找到了這篇文章：[Setting up an Amazon EC2 AWS Server with Tomcat7 (running on ports 80 & 443)](https://medium.com/@rijoalvi/setting-up-an-amazon-ec2-aws-server-with-tomcat7-running-on-ports-80-443-mysql-oracle-jdk-1-68bcc42bdb94)

雖然有幾個部份我操作起來有問題，可能是因為我們不是用 EC2 也不是安裝 Tomcat 7，但還是有給我解決問題的方向。

---

## 加入預路由的規則

```
// 將 8080 port 轉到 80 port
sudo /sbin/iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
// 將 8443 port 轉到 443 port
sudo /sbin/iptables -t nat -I PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 8443
```

---

## 儲存剛加入的規則

原本文章內的指令是

```
sudo /sbin/service iptables save
```

但因為我的 /sbin/ 下並沒有 service 所以才改成以下方式

```
sudo /sbin/iptables-save
```

---

## 重啟網路，套用剛剛加入的規則

原本文章內的指令是

```
sudo /etc/init.d/iptables restart
```

但因為我的 /etc/init.d/  下並沒有 iptable 及 firewall 所以才使用以下方式

```
sudo /etc/init.d/networking restart
```


按造以上步驟做完之後，我的 tomcat 就可以透過 ip:80 和 ip:8080 訪問了

---

以下是補充刪除規則的方法

## 查詢目前所有規則

```
sudo /sbin/iptables -L -n -t nat --line-numbers
```

--line-numbers 是查詢規則，順便依照加入順序編上編號，待會會用到

## 刪除指定規則

```
sudo /sbin/iptables -t -nat -D PREROUTING 1
```

PREROUNTING 可以替換成 INPUT, OUTPUT 等名稱，因為規則會依照使用情境不一樣去分類，我們這次加入的 PREROUTING。

1 是指編號為 1 的規則

---

參考資料：

[Setting up an Amazon EC2 AWS Server with Tomcat7 (running on ports 80 & 443)](https://medium.com/@rijoalvi/setting-up-an-amazon-ec2-aws-server-with-tomcat7-running-on-ports-80-443-mysql-oracle-jdk-1-68bcc42bdb94)

[how-to-remove-iptables-rule](https://stackoverflow.com/questions/21068727/how-to-remove-iptables-rule)

[iptables-how-to-delete-postrouting-rule](https://stackoverflow.com/questions/8239047/iptables-how-to-delete-postrouting-rule)

[iptables-forward-port-error-no-chain-target-match-by-that-name](https://askubuntu.com/questions/793272/iptables-forward-port-error-no-chain-target-match-by-that-name)

[delete-rule-by-chain-and-number](https://www.digitalocean.com/community/tutorials/how-to-list-and-delete-iptables-firewall-rules#delete-rule-by-chain-and-number)

[reloading-iptables](https://askubuntu.com/questions/91413/reloading-iptables)