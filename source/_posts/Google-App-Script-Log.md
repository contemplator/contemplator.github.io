---
title: Google App Script Log
date: 2017-10-01 22:21:43
categories:
    - Google
tags:
    - log
---

在上一篇文章 [angular 使用 google 試算表當資料庫](/blog/2017/10/01/angular-使用-google-試算表當資料庫/) 因為遇到 Google App Script 一直不知道接到的參數為何，所以亂找了一通，也發現有個工具可以使用，分享給大家。

<!--more-->

---

在 Google App Script 的工具列 -> 檢視 -> Stackdrive Logging 可以看到過去執行的紀錄，有人會問，看工具列 -> 檢視 -> 執行紀錄有什麼差別？
兩者都會在錯誤發生時記錄 log，但是如果是要遠端偵錯，可能就需要透過 Stackdrive Logging，因為我不管程式碼怎麼下，只要不使用 debug.gs 就不會出現在"執行記錄"

![Stackdrive Logging](/blog/images/toolStackdrive.png)

## 執行紀錄

```
Logger.log("log message");
```

![執行紀錄](/blog/images/toolLogHistoryView.png)

## 紀錄檢視器 Stackdriver

```
console.log({message: 'Function Input', initialData: JSON.stringify(e)});
```

![執行紀錄](/blog/images/toolStackdriveView.png)

---

## 參考資料

[Google App Script Class Logger](https://developers.google.com/apps-script/reference/base/logge)
[Google App Script Log](https://developers.google.com/apps-script/guides/logging)
