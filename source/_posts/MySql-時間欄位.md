---
title: MySql 時間欄位
date: 2018-06-16 12:42:46
categories:
    - MySql
tags:
    - date
    - datetime
    - timestamp
---

在資料表設立一個修改資料的時間欄位

```
create table if not exists sound(
  id varchar(50) not null,
  name varchar(100) not null,
  modify_datetime datetime default current_timestamp on update current_timestamp,
  url varchar(500),
  graph longblob,
  primary key (id)
);
```

<!--more-->

default current_timestamp 預設建立時間為現在時間

on update current_timestamp 在修改時，修改為現在時間

---

## 取得現在時間

| 函式                | 結果                |
|---------------------|---------------------|
| CURDATE()           | 2018-06-16          |
| CURTIME()           | 12:49:51            |
| CURRENT_TIMESTAMP() | 2018-06-16 12:50:04 |
| NOW()               | 2018-06-16 12:50:04 |
| UNIX_TIMESTAMP()    | 1529124630          |

---

## 參考資料

[mysql日期和時間函數不求人](http://wen198599.pixnet.net/blog/post/22450019-mysql%E6%97%A5%E6%9C%9F%E5%92%8C%E6%99%82%E9%96%93%E5%87%BD%E6%95%B8%E4%B8%8D%E6%B1%82%E4%BA%BA)

[mysql日期時間函數大全](http://fecbob.pixnet.net/blog/post/39089591-mysql%E6%97%A5%E6%9C%9F%E6%99%82%E9%96%93%E5%87%BD%E6%95%B8%E5%A4%A7%E5%85%A8)