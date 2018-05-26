---
title: Angular 從 5 升級到 6
date: 2018-05-26 20:03:34
categories:
    - Angular
tags:
    - migration
---

2018-05-03，Angular 已經更新到 6.0.0 摟，別急著更新，可能會爆掉的，像是 rxjs 也跟著更新了

（持續更新中文章...，因為我自己也還沒更新

<!--more-->

---

## Angualr Update Guide

angular 建立了一個網站，透過指定版本，就可以告訴你應該怎麼升級你的 Angular 專案

[如何更新 Angular 的教學網站](https://update.angular.io/)


---

## Angular Framework

---

## Angular Material

因為我自己已經先使用 Primeface，功能上並沒有太大的差異，差異比較大的應該是 UI 的部分而已。

如果是剛開始接觸 Angular，可以自行選擇適合自己的 UI 風格

- bootstrap: [npm](https://www.npmjs.com/package/ngx-bootstrap) [demo](https://valor-software.com/ngx-bootstrap/)

- primeng: [npm](https://www.primefaces.org/primeng/#/) [demo](https://www.primefaces.org/primeng/#/)

- kendoUI: [官網](https://www.telerik.com/login/v2/kendo?ReturnUrl=https%3a%2f%2fwww.telerik.com%2fdownload-trial-file%2fv2%2fkendo-angular-ui#register) (我已放棄使用，因為需要帳號才能下載）

- material: [npm](https://www.npmjs.com/package/@angular/material) [demo](https://material.angular.io/)

---

## Angular Cli 

- 暫時停用 ng eject

因為不相容新的 angular setting json file (angular-cli.json 換成 angular.json)

eject 功能我也從來沒用過，如果要使用，可以使用 @angular/cli@1.7.4

- 增加 ng update

用來更新 angular 專案下 npm 管理的套件，不用再自己輸入一長串 npm install 指令

使用說明可參照 [官方說明](https://github.com/angular/devkit/blob/master/docs/specifications/update.md)

- 增加 ng add 

我到目前也沒用過，說明就是增加套件到你的 angular 專案，應該僅限於增加 angular 的套件，如：@angular/pwa

- 增加支援 PWA (Progressive Web App )

[Progressive Web App 介紹 - 你的首個 Progressive Web App](https://developers.google.com/web/fundamentals/codelabs/your-first-pwapp/?hl=zh-tw)

- 取代 angular-cli.json

angular.json 取代 angular-cli.json 成為新的 angular 專案的設定檔

angular.json 架構可參考 [官方說明](https://github.com/angular/angular-cli/wiki/angular-workspace)

- 編譯及建置的優化

Webpakc 更新到 4

- 在一個 Angular 專案支援多個應用

我不知道跟一個資料夾下有多個 angular app 有什麼差異

增加 app 的指令

```
ng generate application my-other-app
```

運行指定 app 的指令

```
ng serve my-other-app
```

- 支援開發自己的函式庫

```
ng generate library my-lib
```

該函式庫會包含 component 和 service 各一個

PS. 我另外有做一個像是 typescript Date 物件的擴充 [Github - typescript extension](https://github.com/contemplator/typescript-extension)

- Schematic Defaults 預設的設定 

在 angular.json 的設定，可以是 root（全域） 設定，也可以根據 project 設定

另外也可以在 /.angular-config.json 檔案設定

- Smart Defaults 智能預設

我在想是不是在執行 command line 指令時，通常都會透過 --args 這樣傳遞參數，透過 smart defaults

- Breaking changes

沒有用過

---

## 參考資料

[Version 6 of Angular Now Available](https://blog.angular.io/version-6-of-angular-now-available-cc56b0efa7a4)

[Angular Framework Change Log](https://github.com/angular/angular/blob/master/CHANGELOG.md)

[Angular Material Change Log](https://github.com/angular/material2/blob/master/CHANGELOG.md)

[Angular Cli Change Log](https://github.com/angular/angular-cli/releases)
