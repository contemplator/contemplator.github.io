---
title: Test Double (測試替身)
date: 2017-06-21 15:02:26
tags:
    - test
---

使用 Test Double 測試替身，可以解決要測試時會需要的複雜的元件，以及測試可能會測很久的問題，我們可以直接修改 Test Double，也可以讓資料集小一點。

<!--more-->

## 測試術語
> - SUT：System Under Test 或 Software Under Test 的簡寫，代表待測程式。
> - DOC：Depended Component 相依的元件，DOC 是 SUT 要使用時會需要的元件。

## 測試的相依問題

如果要測試 SUT，DOC 也必須要存在，如果 DOC 有很多，就會變得很複雜，不只測試方式，測試環境也很複雜。

## 解決問題

- 怎麼驗證 SUT 的邏輯有沒有問題就好，不要使用到 DOC
- DOC 資料太大，導致測試會測很久

使用 Test Double 測試替身，可以解決以上問題，我們可以直接修改 Test Double，也可以讓資料集小一點。

## 五種測試替身

### Dummy Object
> 不包含實作的物件，在測試中需要傳入，但卻不會用到的參數

### Test Stub
> 回傳固定值的實作

### Test Spy
> 回傳固定值的實作，但會記錄自身被呼叫的那些成員，以確認 SUT 與他的成員互動正確

### Fake Object 
> 提供接近原始物件，但是較簡單的實作。

### Mock Object
> 由假的程式庫動態建立
> 開發人員看不到實作 Test Double 的程式碼，只可設定 Mock 以提供回傳值、預期要使用的特定成員。

* Mock 是自動產生 Test Double 的技術

[參考來源](http://teddy-chen-tw.blogspot.tw/2014/09/test-double2.html)