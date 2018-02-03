---
title: prettier - vscode 套件
date: 2018-01-29 22:02:47
categories:
    - Visual Studio Code
tags:
    - vscode
    - plugin
    - angular
---

最近很常和公司的設計師聊，因為會一直被她很有壓力的逼迫，順便檢討自己的工作方式，雖然一直覺得是自己再配合大家，可是其實有時是別人配合我都沒有發現...

<!--more-->

---

最近在 git pull 後都會發現有些檔案的 tab intent 大小不一樣，自己習慣都是 tab size 為 4 在做排版，可是程式碼從設計師那邊 merge 回來後，tab size 都會變成 2，今天和她開會閒聊才發現原來 angular 的專案會產生一個 .editorconfig 的設定檔，裡面就有規定到 tab size 為 2，原來一直是我在 vscode 的偏好設定設為 tab size 為 4，而且沒有在 vscode 安裝 editorconfig 套件，變成是我在用 angular 開發，可是卻忽略 angular 的設定檔，我道歉，我雷！

## [editorconfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)

一般情況下，vscode 並不會去讀取專案下的 .editorconfig 檔案去影響開發工作區的設定，像是 tab size，主要還是看他偵測到的檔案大多怎麼排，再來就是看使用者偏好設定、工作區偏好設定，所以在這建議大家如果是開發 angular 專案，或者專案下有 .editorconfig 檔案，記得去下載套件 - [Editorcofig for VS code](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)

或者在 mac 環境下按下快捷鍵 command + P，輸入以下指令

```
ext install EditorConfig
```

這樣就會參照 .editorconfig 檔案

---

## [Beautify css/sass/scss/less](https://marketplace.visualstudio.com/items?itemName=michelemelluso.code-beautifier)

在前公司我都用這套外掛在做自動排版，前公司的工作規範訂的不是很好，很多事我進去之後才定，我也雷雷的和大家分享了這個套件，起初只是因為這個操作最無腦，安裝之後使用 Ctrl + Shift + F 就可以自動排版，而且找了很久，就這個比較能排 scss，可是後來因為和設計師討論到怎麼規範 scss 和 css ，發現這個套件可以自己設定的選項很少（可能文件說明太少），而且預設不是參照 .editorconfig，所以後來我就開始找其他套件。

---

## [Sass Formatter](https://marketplace.visualstudio.com/items?itemName=sasa.vscode-sass-format)

後來想要直接找 scss 的自動排版，就看到 vscode 推薦這個給我，我也稍微試用了一下，發現在設定上比前一個套件彈性，說明也比較清楚，唯一麻煩的地方，是他還要在 command line tool 安裝一個工具，安裝指令如下：

```
sudo gem install sass
```

此外，他可以支援參照 editorconfig，原本就要使用這個了，可是後來在一個個檔案自動排版時，發現他在 css 的 單行註解排版有點問題，他大括號 } 結束的部分，後面會緊挨著單行註解，只有多行註解會正常排版。所以後來又繼續找。

---

## [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)

好酒沈甕底，後來就決定用這個了，因為他預設就參照 .editorconfig 檔案，要另外自訂也可以，一開始預設排版也都沒有問題，雖然後來在排版 json 檔案和 ts 檔案時遇到一點問題，可是後來都在他的文件找到解法。

ts 的問題是在 import 的內容太多時，會自行增加一行，讓我 import 的套件顯示太多行，不滿意，後來使用以下方法在 vscode 的工作區額外設定解決：

```
{
    "prettier.disableLanguages": ["typescript"]
}
```

json 的問題是因為我的 npm script 指令太長，他幫我自動在新的一行顯示，其實在排版上沒有什麼幫助，原本想用上面的方法避開他幫我在 json 檔案的自動排版，看能不能用 vscode 或其他參照的地方排版，發現不行，只好找到以下方式：

```
{
    "prettier.printWidth": 200
}
```

原因在於他會去計算那一行的程式碼有多長，超過預設長度 80 就會折行，我將它擴展到 200 就不會有這問題
