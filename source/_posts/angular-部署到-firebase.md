---
title: angular 部署到 firebase
date: 2017-08-15 15:12:30
categories:
    - Angular
tags:
    - Firebase
---

1. 使用 angilar cli 成功建立 angular 專案

2. 成功使用 ng serve 將成功畫面運行起來

3. 使用 Ctrl + c 關閉 server

4. 運行 ng serve --prod 

5. 安裝 firebase tool

```
npm install -g firebase-tools
```

6. 登入 firebase

```
firebase login
```

7. 初始化 firebase 專案

```
firebase init
```

選擇 hosting
選擇要關聯的專案

完成之後檢查是否有 firebase.json 及 .firebaserc 等兩個檔案產生
如果你跟我一樣， firebase.json 是空的，請貼上以下程式碼

```
{
    "public": "dist",
    "ignore": [
        "firebase.json",
        "**/.*",
        "**/node_modules/**"
    ],
    "rewrites": [
        {
            "source": "**",
            "destination": "/index.html"
        }
    ]
}
```

8. 部署

```
firebase deploy
```

9. 成功之後就可以到他指定的路徑查看是否正常

PS. 這是適用於 angular cli 產生之專案部署到 firebase 的方式，如果使用其他方式產生靜態檔，記得要去改 firebase.json