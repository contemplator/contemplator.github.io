---
title: MySql Procedure 預存程序
date: 2018-02-11 13:34:48
categories:
    - MySql
tags:
    - procedure
---

SQL Procedure 就是把 SQL Query 的邏輯寫在 DB 裡面，要使用時直接 call procedure 的名稱就好，視情況丟參數進去

<!--more-->

---

## Hello world

先看簡單的 Procedure 範例

```
drop procedure if exists test;
delimiter #
create procedure test ()
begin
    select 1+7;
end#

delimiter ;
call test();
```

以上的 SQL 可以貼到你的 Mysql DB 內測試，你應該會看到結果是 8;

---

### 判斷是否存在

```
drop procedure if exists test;
```

這是在建立 procedure 時判斷同名稱的 procedure 是否存在，有時不建議你加入這個判斷，萬一如果已經存在了同名稱的 procedure，但是兩個邏輯完全不一樣，你應該另外命名，而不是直接蓋掉

PS. 所以你可以不寫這一行的判斷，讓系統自己告知你這個 Procedure 是否已經有同名的存在

---

### 切換分隔符號

```
delimiter #
...
delimiter ;
```

在寫 Mysql Procedure 時一定要加入這一行的邏輯，意思就是要將分隔符號切換成分號 ";" 之外的符號，建議就是不容易和其他符號意義衝突的，不然你直接寫 Procedure 會直接一直收到拼法錯誤。

PS. 最後記得要再改回去分號 ";"

---

### 開始寫邏輯

```
begin
    statement...
end#
```

begin 和 end# 中間就是你的 sql 邏輯

---

### 使用 Procedure

```
call test();
```

這是呼叫 Procedure 的方式，就像是 call function 一樣。

---

## 加入參數

```
drop procedure if exists getParams;
delimiter #
create procedure getParams (
	search_date date,
	keyword varchar(10)
)
begin
	select search_date, keyword;
end#

delimiter ;
call getParams('2018-02-11', 'google');
```

---

### 接收參數

```
create procedure getParams (
	search_date date,
	keyword varchar(10)
)
```

差別就在於原本 ProcedureName 後面的括號指定要接什麼型態的資料

### 傳入參數

```
call getParams('2018-02-11', 'google');
```

就真的和呼叫函式一樣，在括號內依照需要的參數順序傳入就好

### 資料格式錯誤

如果我已經指定第一個參數要是 date 格式，結果你傳入錯誤格式或資料，他也會像是一般 sql query 告訴你錯誤

![incorrect date value](/blog/images/incorrect date value.png)

### 參數少傳或多傳

如果傳入的參數數量和指定要接受的參數數目不對，也會報錯

![incorrect number of arguments](/blog/images/incorrect number of arguments.png)