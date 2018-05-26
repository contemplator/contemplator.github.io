---
title: 使用者程式碼片段 code snippet
date: 2018-05-26 15:45:21
categories:
    - Visual Studio Code
tags:
    - snippet
---

最近在試著做一個 nodejs 後端的 RestFul API，所以像是處理 res, req 的 function 很常用到，為了保持寫法一致，還有就是加速開發速度，只要使用一些關鍵字就可以快速寫玩一個 function。

<!--more-->

---

## 簡單示範

在 VS Code 可以自定義程式碼片段，像是輸入關鍵字 'log'，就跑出自動完成的選項

![自動完成選擇](/blog/images/console-snippet-select.png)

選擇到你要的選項後，就跑出更長的一段程式碼，像是這樣

![自動完成結果](/blog/images/console-snippet-result.png)

---

## 使用 snippet 寫 RestFul API 常用 function

我的 nodejs server api 程式碼長這樣子

![nodejs restful api](/blog/images/nodejs-restful-api.png)

可以看到 function 參數和 function 裡面的 try...catch... 樣子差不多，應該說重複的地方很多，所以就想要透過 snippets 自動完成，所以就在 typescript 的使用者片段加入以下的指令

```
    ...
    "http res": {
        "prefix": "httpres",
        "body": [
            "async $1(req: Request, res: Response) {",
            "\ttry {",
            "\t\t$2",
            "\t} catch (error) {",
            "\t\tres.json(error);",
            "\t}",
            "}"
        ],
        "description": "http request and response function"
    }
```

我只要輸入 httpres 就可以看到自動完成，選擇後的結果也可以隨時修改，儲存後就立馬生肖，非常好用。

![http snippet select](/blog/images/http-snippet-select.png)

![http snippet result](/blog/images/http-snippet-result.png)

---

## 參考資料

[Creating your own snippets](https://code.visualstudio.com/docs/editor/userdefinedsnippets)

[Markdown and VS Code](https://code.visualstudio.com/docs/languages/markdown)

[Nodejs + Express + Typescript + Decorator ](https://github.com/contemplator/express-typesript)