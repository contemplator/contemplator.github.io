---
title: Store Procedure with Transaction 交易功能
date: 2019-03-05 00:22:31
categories:
  - MySql
tags:
  - store procedure
  - transaction
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

  set trello_id = JSON_UNQUOTE(JSON_EXTRACT(params, '$.trello_id'));
  set trello_name = JSON_UNQUOTE(JSON_EXTRACT(params, '$.trello_name'));
  set customer = JSON_UNQUOTE(JSON_EXTRACT(params, '$.customer'));

  start transaction;
    insert into proposal_trello (id, name, customer)
    values (trello_id, trello_name, customer);
  commit;
```

<!--more-->

---

## start transaction;

告知準備開始交易功能的敘述

## commit

如果都成功的話，就把剛剛做的交易都執行

## handler for sqlexception

如果在這隻 store procedure 遇到例外不能執行完成，就會進入這個 handler

## rollback;

將剛剛暫存的交易都回滾，當作沒有發生

`注意，如果宣告 errorcode 和 errormsg 暫存的處理放在 rollback 之後，會取得不了，因為連錯誤都被回滾洗掉了`

## RESIGNAL

重新發出一次 sql 執行錯誤的訊息給外部執行者