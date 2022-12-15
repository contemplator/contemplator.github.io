---
title: Angular SSR TransferState (1) - 簡介
date: 2022-12-15 10:57:13
categories:
    - Angular
tags:
    - SSR
    - Server Side Render
    - TranferState
---

過去用了 Angular 4-5 年，完全沒有想過真的會需要用到 Universal 這個模式來開發，因為換工作的原因，不得不學習相關知識，但因為真的太多坑了，覺得可以寫一篇文章來分享給以後的自己或其他苦手。

<!-- more -->

---

一般來說，如果不使用 SSR 模式開發，是不需要使用 TransferState 的，因為 TransferState 主要是將某些資料快取住，讓下一次呼叫 API 時，可以從 TransferState 中取得，不需要真的再跟 API Server 呼叫一次。而最主要的應用場景，就是因為 Server Side Render 已經呼叫了需要的 API，但是如果 Client Side 又重複打，除了會有造成不必要的資源浪費，也有畫面閃跳的問題。

大概的程式碼邏輯如下：

```
intercept(){
    if (isServerSide()) {
        transferState.set(key, value);
    } else {
        transferState.get(key, defaultValue);
    }
}
```

另外講解一個可能某些人不會用到的機制: Interceptor，Interceptor 是一個介面，需要時做出 intercept()，在 Anuglar 叫做 HttpInterceptor，其主要用途是攔截每個 HttpClient 出去的 API，出去之前會攔截，回來之後但是在回到 Component 呼叫之前也會攔截。所以在 CSR 模式，也可以在 Interceptor 中實作統一 header 的邏輯。而把 TransferState 實作在 Interceptor 中，也是因為此機制的關係。

所以在 Server Side 如果有呼叫過 API，並且有快取住，到 Client Side 時，Component 內可以做 console.log 檢查到有呼叫的動作，但是如果在 Chrome 的開發者工具中的 Network 或者在 API Server 的 access log 中就不會看到紀錄，因為他在 Interceptor 中如果有取得快取，就直接回傳給 Component，就不會在對外部請求資源。

附上簡單的程式碼：

```
import { isPlatformServer } from '@angular/common';
import { HttpHandler, HttpInterceptor } from '@angular/common/http';
import { Inject, Injectable, Optional, PLATFORM_ID } from '@angular/core';
import { makeStateKey, StateKey, TransferState } from '@angular/platform-browser';
import { sha256 } from 'js-sha256';
import { throwError } from 'rxjs';
import { catchError, filter, tap } from 'rxjs/operators';

@Injectable()
export class UniversalInterceptor implements HttpInterceptor {
    constructor(
        private transferState: TransferState,
        @Inject(PLATFORM_ID) private platformId: any
    ) {
        const hashBody = sha256.hmac('app-key', JSON.stringify(req.body));
        const key: StateKey<string> = makeStateKey<string>(`${req.url}?hashBody=${hashBody}`);

        if (isPlatformServer(this.platformId)) {
            return next.handle(serverReq).pipe(
                filter((event) => event instanceof HttpResponse),
                tap((event: HttpResponse<any>) => {
                    this.transferState.set(key, (<HttpResponse<any>>event).body);
                }),
                catchError((error) => {
                    return throwError(error);
                })
            );
        } else {
            const storedResponse = this.transferState.get<any>(key, null);
            if (storedResponse) {
                const response = new HttpResponse({ body: storedResponse, status: 200 });
                this.transferState.remove(key);
                return of(response);
            } else {
                return next.handle(req).pipe(
                    catchError((error) => {
                        this.logger.error('http intercepter catchError:', error);
                        return throwError(error);
                    })
                );
            }
        }
    }
}
```

---

---

# 參考資料

[使用 TransferState 解決畫面閃爍](https://fullstackladder.dev/blog/2021/10/31/angular-universal-transfer-state/)

[官方 TransferState 說明](https://angular.io/api/platform-browser/TransferState)