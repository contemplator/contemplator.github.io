---
title: angular 使用 google 試算表當資料庫
date: 2017-10-01 21:14:01
categories:
    - Angular
    - Google
tags:
    - proxy
---

最近一直想要試作一些個人用的 APP，然後試試看用 ionic 3 寫看看，看能不能每天自己用，然後慢慢改善、慢慢收集一些資料，做一些小功能的試做，不過用 ionic 3 開發，真的遇到蠻多問題的，像是我就不知道資料庫應該怎麼抉擇，一開始用 SQLite 結果開發起來好綁手綁腳的 ＱＱ

<!--more-->

---

*因為 ionic 2 之後是根據 Angular 架構設計的，所以兩者的程式碼和檔案架構會很像，我文章中 ionic 和 Angular 可能會切換來切換去的，請見諒。*

網路上 Google "使用 Google 試算表當作資料庫" 就可以找到很多資源，不過大家都是寫說怎麼使用 jQuery，因為寫網頁，用 jQuery 是最省事的，但是 Angular 本身就有 http 的模組可以使用，不必再靠 jQuery，但是我在參考網路上資源時遇到一些問題，後來解決了，分享給大家。

## Angular Service

這裡不多做 Angular Service 的介紹，只要知道 Angular 的 Service 主要是用來存取 App 內資料的，不管是透過 API 還是將資料寫死在 Service 都是常見的用法。

```
public addTrans(params): Observable<boolean>{
    return this.http.post("https://script.google.com/macros/s/AKfycbxDMcqskNOmuaRvku5A85Tauz-99ltopHyI8PVHQO5DZGrcadLR/exec", JSON.stringify(params))
        .map(res=>{
            return res.json();
        });
}
```

addTrans() 是一個將資料傳送給 Google App Script API 的函式。
Observable 是 Angular 使用 RXJS 經常會用到的物件類型，可以當作 Promise 進階應用。
this.http.post() 就是 Http Request 方法（method）指定為 POST 的函式，至少要傳兩個參數，第一個為 url，第二個為 data
JSON.stringify() 建議將參數使用字串的方式傳給 Google App Script API，也可以等後面介紹 Google App Script 實在自行決定。
map(res=> res.json()) 將 Google App Script API 回傳的結果以 json 格式回傳給呼叫 addTrans() 的對象。

[程式碼](https://github.com/contemplator/plan-consumption/blob/master/src/app/app.service.ts)

---

## Google 試算表

在自己的 Google 雲端硬碟建立一個試算表，記下該試算表的 id

![Google 試算表 id](/blog/images/googleSheetId.png)

---

## Google App Script

邏輯和網路上搜尋前幾名的做法一樣

1. 先取得 Angular Service 傳進來的參數
2. 設定要儲存的試算表 ID 和 試算表工作表名稱
3. 儲存資料

差別主要在於取得參數，原本是 e.parameters，要改為 e.postData.contents，程式碼如下：

```
function doPost(e) {
  // 取得 request 資料
  var params = JSON.parse(e.postData.contents);
  var id = params.id;
  var datetime = params.datetime;
  var price = params.price;
  ...
  
  // 取得指定的 google 試算表
  var spreadSheet = SpreadsheetApp.openById(sheetId);
  
  // 取得指定的工作表
  var sheet = spreadSheet.getSheetByName(sheetName);
  
  // 取得最後一行的行數
  var lastRow = sheet.getLastRow();
  
  // 儲存資料
  sheet.getRange(lastRow + 1, 1).setValue(id);
  sheet.getRange(lastRow + 1, 2).setValue(datetime);
  sheet.getRange(lastRow + 1, 3).setValue(price);
  ...
  
  // 回傳結果（結果須為字串）
  return ContentService.createTextOutput(result);
}
```

[完整程式碼](https://github.com/contemplator/plan-consumption/tree/master/src/google-scripts)

- JSON.parse()
> 因爲我 Angular Service 傳進來是 JSON 格式的字串，所以可以使用 JSON.parse() 再轉回 JSON 的物件，後面要取得比較容易。

- e.postData.contents
> 我是用 Google App Script 的 console.log() 才找到我傳進來資料的結構，才知道要從 postData.contents 取得
> [Google App Script Log](/blog/2017/10/01/Google-App-Script-Log/)
---

## Access-Control-Allow-Origin

因為是使用 ionic 的 serve 在運行，會運行在 http:localhost:8100 下，所以會遇到此情況，你可以選擇直接 build 成 App，應該就不會遇到此情況，可是每次 build 都要一陣子，你就可以使用 Proxy 解決這問題。

### ionic.config.json

這是 ionic serve 在運行時會來參考的一個設定檔，加入以下訊息：

```
"proxies": [
    {
      "path": "/goto",
      "proxyUrl": "https://script.google.com"
    }
  ]
```

其他設定不用動到，加入後記得要符合 json 格式

### Angular Service

```
public addTrans(params): Observable<boolean>{
    return this.http.post("/goto/macros/s/AKfycbxDMcqskNOmuaRvku5A85Tauz-99ltopHyI8PVHQO5DZGrcadLR/exec", JSON.stringify(params))
        .map(res=>{
            return res.json();
        });
}
```

** https://script.google.com/ 改為 /goto **

這樣 localhost:8100 的 domain 就會被認為是在 script.google.com 下向 API 執行 request

---

## 參考資料
[用 Google Apps Script 操作試算表 (1)製作資料庫 + 寫入資料](http://www.wfublog.com/2017/01/google-apps-script-spreadsheet-write-data.html)
[The Ionic 2 proxy](https://www.techiediaries.com/ionic-2-proxy/)
[Google App Script Log](/blog/2017/10/01/Google-App-Script-Log/)

---

## 完整程式碼

[GitHub](https://github.com/contemplator/plan-consumption)