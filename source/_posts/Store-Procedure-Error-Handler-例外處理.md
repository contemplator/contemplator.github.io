---
title: Store Procedure Error Handler 例外處理
date: 2019-03-04 23:54:39
categories:
  - MySql
tags:
  - store procedure
  - exception
---

```
  declare exit handler for sqlexception
  begin
    GET DIAGNOSTICS CONDITION 1
    @error_code = RETURNED_SQLSTATE,
    @error_msg = MESSAGE_TEXT;
    rollback;
    insert into log_sql (log) values(@error_msg);
    RESIGNAL;
  end;
```

<!--more-->

## 宣告 handler

使用 declare 宣告 handler 

for 後面接的是情況，可以接 sqlexception、sqlwarning、not found

## RESIGNAL

因為我們已經 catch 到 exception，等於外部執行這個 store procedure 明明遇到錯誤，可是錯誤訊息已經被 catch 住，如果需要回傳 mysql server 原始的錯誤訊息，可以使用 RESIGNAL 

## 注意事項

1. 要符合 declare 原則，在 set 還有操作 db 的 sql 語法之前
2. 要在 declare 一般變數之後

## 範例

```
drop procedure if exists removeProposalLabels;
delimiter #
create procedure removeProposalLabels (
	params JSON 
)
begin
  declare trello_id varchar(10) character set utf8;
  declare labels varchar(500) character set utf8;
  declare loop_index int default 0;
  declare label_id int;
  -- log 錯誤訊息
  declare exit handler for sqlexception
  begin
    GET DIAGNOSTICS CONDITION 1
    @error_code = RETURNED_SQLSTATE,
    @error_msg = MESSAGE_TEXT;
    rollback;
    insert into log_sql (log) values(@error_msg);
    RESIGNAL;
  end;

  set trello_id = JSON_UNQUOTE(JSON_EXTRACT(params, '$.trello_id'));
  set labels = JSON_EXTRACT(params, '$.labels');

  start transaction;
    while loop_index < JSON_LENGTH(labels) DO
      set label_id = JSON_EXTRACT(labels,CONCAT('$[',loop_index,']'));
      delete from proposal_label_mapping where proposal_label_mapping.trello_id = trello_id and proposal_label_mapping.label_id = label_id;

      select loop_index + 1 into loop_index;
    end while;
  commit;
end#

delimiter ;
```