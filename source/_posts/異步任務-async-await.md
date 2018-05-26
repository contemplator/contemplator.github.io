---
title: 異步任務 async await 示範
date: 2018-05-26 17:04:41
categories:
    - javascript
tags:
    - async
    - await
---

這篇僅作為自己的心得，因為自己常常不知道 Promise 怎麼寫...

<!--more-->

先建立一個 function 是回傳 Promise 的

最簡單的就是使用 setTimeout 建立一個異步任務

```
const doc = document.body;

function wait(): Promise<any>{
    doc.innerHTML += "<p>get in wait()";
    return new Promise((resolve, reject)=>{
        setTimeout(() => {
            doc.innerHTML += "<p>get in setTimeout()";
            if (2 > 3) {
                resolve(true);
            } else {
                reject(false);
            }
        }, 1000);
    })
}

async function foo() {
    doc.innerHTML += "<p>call foo()";
    let result;
    try {
        result = await wait();
        doc.innerHTML += "<p>wait done, " + result;
    } catch (error) {
        doc.innerHTML += "<p>wait done, " + error;
        console.error(error);
    }
}

foo();
```

上面就是簡單的 Promise 異步函式，如果要使用 then() 或者 await 來取得一個異步函式的回傳，該異步函式就是用 return 一個 Promise 物件。

可以將以上程式碼貼到 typescript 官網的 [Playground](https://www.typescriptlang.org/play/index.html) 執行

---

## 拿掉 await 比較  執行順序

如果是拿掉 await ，foo() 執行到 wait() 時就不會等 

---

## 修改 if() 內的判斷，比較 resolve 和 reject 的流程

如果  執行到 resolve 就會執行到 result = await wait();， result 將會有值

如果執行到 reject 就會執行到 catch(error)

---

## Promise 物件說明

```
return Promise((resolve, reject) => {...})
```

* resolve 成功的情況會回傳的結果

* reject 失敗的情況會回傳的結果

## 參考資料

[異步函數 - 提高 Promise 的易用性](https://developers.google.com/web/fundamentals/primers/async-functions?hl=zh-tw)
