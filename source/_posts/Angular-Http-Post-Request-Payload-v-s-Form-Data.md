---
title: Angular Http Post Request Payload v.s. Form Data
date: 2020-12-18 17:32:55
categories:
  - Angular
---

Angular Post Request 的 Header 下的 Content-Type 是 application/json，而且會把參數包在 payload 內。如果你的後端都是使用 request.body 去接參數的話，都會接到空。

<!-- more -->

---

以下是將 json 物件資料轉為 x-www-form-urlencoded 傳遞參數的方式

```
const options = {
  headers: new HttpHeaders({
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded;charset=utf8'
  })
};

const params = new URLSearchParams();
params.append('openId', 'user_open_id');
params.append('msg', 'hello world');

return this.httpClient.post<boolean>('https://www.example.com/path', params.toString(), options);
```