---
title: MySql 建立和使用 function
date: 2018-06-16 12:06:45
categories:
    - MySql
tags:
    - function
---

Sql 現在除了預存程序，可以直接執行複雜的 Sql 語法之外，還可以使用 function 處理一些更常使用的功能。

<!--more-->

---

## 公式

```
drop function if exists <functionName>;
delimiter #
create function <functionName> (<parameter> <paramType>) returns <returnType>
begin
  <expr>
  return <result>;
end#

delimiter ;

select <functionName>(paramter);
```

<> 內是要修改的地方

functionName 是呼叫的名稱

paramter 是 function 執行需要的參數，可以不只一個，但記得型態要正確

returnType 在是否要回傳結果的限制 function 和 procedure 不一樣，function 是一定要回傳一個結果

expr 是你的邏輯的部份，如果裡面有 select 的語法，是無法直接當作結果回傳的，一定要使用 return 的語法

---

## 實作

```
drop function if exists getMemberName;
delimiter #
create function getMemberName (id int) returns varchar(20)
begin
  declare member_name varchar(20) default '';
  select a.name into member_name from member a where a.id = id;
  return member_name;
end#

delimiter ;
select getMemberName(123);
```

主要就是透過一個唯一值 ID 取得他的其他資訊

注意：select sth into variable 的用法，select 出來的東西只能是一筆結果而已，如果是多筆，會有問題

---

## 參考資料

[CREATE PROCEDURE and CREATE FUNCTION Syntax](https://dev.mysql.com/doc/refman/8.0/en/create-procedure.html)