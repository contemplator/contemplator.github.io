---
title: Angular SSR TransferState (2) - 實務應用
date: 2022-12-15 11:57:13
categories:
    - Angular
tags:
    - SSR
    - Server Side Render
    - TranferState
---

如果要做 SSR，許多情境你就需要考量這邊在 Server Side Render 會不會有問題，像是沒有 window 物件可以用，沒有 localstorage 可以取得，你會不知道使用者的螢幕寬度等等，而快取是一件很少人提到的部分，因為每個情境不同，每套系統業務邏輯也差很多，我這邊會舉一些我碰到的例子。

<!-- more -->

---

如果你要做快取，你應該想是不是每個使用者進來，都應該拿到同一份 html 來做顯示？

如果你覺得 Client Side Render 時，js 會重新跑一次，應該不管怎樣，使用者最終都會拿到正確的結果吧？答案是不一定。這取決於你的 SSR 會執行到哪一個步驟，比如說：如果你每個頁面都有實作到 resolver，resolver 一定會被 SSR 執行到；但是如果你許多呼叫 API 是實作在 ngOnInit()，就不一定來，還要看你的 ngOnInit() 裡面的程式碼是馬上執行？還是有許多判斷或者非同步的處理？

所以在決定哪些需要快取時，你有兩個方向：

1. 從 Node server 取得該瀏覽的使用者及裝置的特徵，在 Angular App 中可以取得，並且做完完整的 Render 過程，並且全部 Cache 到 TransferState

2. 不同使用者造訪，會影響畫面上的資料或版面，就不要 Cache 到 TransferState，如呼叫取得使用者身份 API，變更 Header ，那取得使用者身份 API 就不 Cache。

---

# 從 Node server 取得該瀏覽的使用者及裝置的特徵

當初導入 SSR 的初期，會有個思考上的誤區，就是所有 http request 都是從 Node server 出去的，理應可以取得 API Server 所有回傳的資料，操控權限應該是很大的。但是又同時是 Client 端的 Angular App，處理 window、localstorage、cookie 等資料，應該也可以使用。

但是其實開發 SSR 時，開發者真的要很清楚，目前是在 Server 端還是 Client 端執行？一段程式碼會在 Server 和 Client 都執行到，流程的先後順序，以及不同環境，該做的處理、能做的處理也要很清楚。

如何從 Node server 取得 Browser 傳給 Node server 的資料，再傳入到 Angular App 中？

直接看程式碼：

## Node server

陽春版的 SSR

```
res.render(indexHtml, {
    req,
    providers: [{ provide: APP_BASE_HREF, useValue: req.baseUrl }],
});
```

調整後的 SSR 

```
res.render(
    indexHtml,
    {
        req,
        providers: [
            { provide: APP_BASE_HREF, useValue: req.baseUrl },
            { provide: RESPONSE, useValue: res }
        ],
    },
    (error: Error, html) => {
        if (error) {
            console.log(`[${req['id']}] catch render error: ${error}`);
            const htmlContent = readFileSync(join(distFolder, 'index.html'), { encoding: 'utf-8' });
            res.status(200).send(htmlContent);
            console.log(`[${req['id']}] response csr content`);
        }
        res.send(html);
    }
);
```

## Angular App Inteceptor

調整後

```
import { isPlatformServer } from '@angular/common';
import { HttpHandler, HttpInterceptor } from '@angular/common/http';
import { Inject, Injectable, Optional, PLATFORM_ID } from '@angular/core';
import { makeStateKey, StateKey, TransferState } from '@angular/platform-browser';
import { sha256 } from 'js-sha256';
import { throwError } from 'rxjs';
import { catchError, filter, tap } from 'rxjs/operators';
// 增加的部分
import { REQUEST, RESPONSE } from '@nguniversal/express-engine/tokens';
import { Request, Response } from 'express';

@Injectable()
export class UniversalInterceptor implements HttpInterceptor {
    constructor(
        private transferState: TransferState,
        @Inject(PLATFORM_ID) private platformId: any,
        @Optional() @Inject(REQUEST) protected request: Request,
        @Optional() @Inject(RESPONSE) protected response: Response
    ) { }

    // 太多應用，我就不寫完整的程式碼了 ...

    // 取得瀏覽器瀏覽網頁時，帶上來的 cookie
    const browserCookies = this.request.headers.cookie;
    
    // 在 SSR 完成後想要回應給 Browser 時，希望帶上的 cookie
    this.response.setHeader('set-cookie', [cookie1, cookie2]);
}

```

可以簡單想成，可以透過 Node server render 的 providers 提供 Angular App 外掛或者補充資料，在 Angular App 中，就可以透過 @Inject(tokenName) 取得，有些只有 Server 知道的東西，也可以讓 Angular App 取得，相當的彈性。

如果不這樣做會怎麼樣？

那你的 Angular App 在 Server Side 時，項 API Server 呼叫的 http request 就帶不上 cookie，如果你有 Session 或其他驗證機制，可能就會斷開。

或者是 API Server 在回應 API request 時，帶給你的 set-cookie 你就會無法完整的回覆給 Browser，你原先設計的流程就會斷開，Session 就會不連續。

---

## Node Server 的 Provider 補充

除了是一些環境變數和常見的 request 和 response 物件外，他也可以提供更多的外掛。

像是 Anuglar App 預設是使用 Axios 來進行 Http Request，如果你跟我一樣遇到 Axios 的 response 無法取得 API Response 給的 header，可以透過 Node Server provide 一個 request 套件，由 Node 這邊來發 http request 來做到取得 API Response 給的 header 的事情。

另外也可以透過 provide 一個 By Reference 的變數，讓 Node server 和 Angular 來互相傳遞和修改同一個變數。

還有還有，也可以實作出 watch value 的機制，這邊就不真的實作出程式碼了。

---

# 不 Cache 取得使用者 API 的結果

其實就是透過判斷式，如：if、swtich 等來控制哪些該 cache，只是在開發 SSR 時，特別提出來應該考慮的地方。

```
if (this.preventKeepTokenUrls.findIndex((regex) => regex.test(this.request.url)) === -1) {
    this.transferState.set(key, tokenResponse.body);
}
```

可以根據目前要求的 API url 判斷

也可以根據目前使用者要瀏覽的頁面 url 判斷

或者將兩者合併一起判斷。

如果有更多想要取得的資料加進來判斷，但是不知道如何取得，也可以在底下留言告訴我。

---

# 參考資料

久到不可考。
