---
title: MySql 使用 JSON 當作預存程序參數
date: 2018-02-11 14:08:40
categories:
    - MySql
tags:
    - JSON
---

如果你像我一樣在 Rest API 不想要每個 controller 都個別指定需要什麼參數，想要資料傳進來直接當作預存程序的參數整包傳入，可以把預存程序改成接受 JSON 格式的資料。

<!--more-->

---

上一篇我已經介紹過在 MySql 怎麼寫預存程序：[MySql Procedure 預存程序](/blog/2018/02/11/Mysql-Procedure-預存程序/)

首先你要檢查你的 MySql 版本是否已經在 5.7 以上，像我的就是 5.7.16，根據官方說法，已經開始支援部分 JSON 的 function，為什麼是部分可以看官方 API 文件。[官方 API](https://dev.mysql.com/doc/refman/5.7/en/json-function-reference.html)

---

先直接上 Sample Code

```
drop procedure if exists jsonParams;
delimiter #
create procedure jsonParams (
	params JSON 
)
begin
    declare date varchar(10) default ""; 
    declare keyword varchar(10) default "";
    declare num int unsigned default 0;
    
    set date = JSON_EXTRACT(params, '$.date');
    set keyword = JSON_EXTRACT(params, '$.keyword');
    set num = JSON_EXTRACT(params, '$.order');

	select date, keyword, num;
end#

delimiter ;
call jsonParams
('{"date": "2018-02-09", "keyword": "mysql", "order": 1}');
```

上面的 sql 一樣可以在 MySql 執行。

---

## 指定傳入參數為 JSON 資料

```
create procedure jsonParams (
	params JSON 
)
```

將參數格式定義為 JSON 就好。

有了 JSON 格式的資料，你應該不需要第二個參數，只是應該，你應該還是要視情況去設定你的傳入參數的方式。

---

## 取得 JSON 參數內的資料

```
declare keyword varchar(10) default "";
set keyword = JSON_EXTRACT(params, '$.keyword');
```

先用 declare 宣告一個變數的存在，你可以給他 default 預設值，也可以不要，重要的是一樣要<font color='#d9534f'>定義資料格式</font>
然後再使用 set 方式將 JSON 物件內的資料指定到變數內，<font color='#d9534f'>記得要加單引號在第二個參數</font>。

JSON_EXTRACT() 就是將 JSON 物件資料取出的 function

## 資料都有用雙引號包著怎麼辦？

```
declare date varchar(12) default ""; 
set date = JSON_EXTRACT(params, '$.date');
```

如果你在 JSON 物件內塞入一個日期字串，想要在 sql query 裡面當作 where 的日期比對條件，可是不知道為什麼總是比對錯誤。

你會發現 JSON_EXTRACT 出來的日期資料 varchar(10) 完全裝不下，至少要 varchar(12)。

看了官方 API 之後發現還有 JSON_UNQUOTE() 這個函式可以用，他是用來將雙引號給拿掉。

那什麼情況會遇到需要把雙引號拿掉？

我目前只有在要比對日期時。

PS. 原本以為是 JSON_EXTRACT() 拿出來都會加上雙引號，像是可能也會把數字給轉成字串，但是好像數字進去，就是數字出來。

所以改成下面這樣子：

```
declare date varchar(10) default ""; 
set date = JSON_UNQUOTE(JSON_EXTRACT(params, '$.date'));
```

你在 select 結果就可以看到差異，如果你要比對日期欄位的資料時也不會比對不成功了。

PS. 原本要宣告 order 或 index 時都會遇到問題，因為 index 和 order 都是 sql 的保留字。（但是不知道為什麼 date 就沒問題）

---

## 傳入 JSON 資料

```
call jsonParams
('{"date": "2018-02-09", "keyword": "mysql", "order": 1}');
```

括號內還是傳入字串格式，只是這個字串內是 JSON 的格式。

如果你像我一樣在 Nodejs 想要這樣傳入就會有問題：

```
let name = 'jsonParams';
let data = {"date": "2018-02-09", "keyword": "mysql", "order": 1};

this.db.query(`call ${name}('${data)');`, (error, rows, fields) => {...}
```

實際的 query 會變成 call jsonParams('Object [object]')

要加上 JSON.stringify() 轉成字串格式

```
let name = 'jsonParams';
let data = {"date": "2018-02-09", "keyword": "mysql", "order": 1};

this.db.query(`call ${name}('${JSON.stringify(data)}');`, (error, rows, fields) => {...}
```

---

參考資料：

[官方 API](https://dev.mysql.com/doc/refman/5.7/en/json-function-reference.html)
[json-and-mysql-stored-procedures](http://www.jonathanlevin.co.uk/2016/12/json-and-mysql-stored-procedures.html)