---
title: 在 chrome 使用 sourceMap
date: 2017-09-25 11:37:11
categories:
    - Web
tags:
    - source map
    - map
    - chrome 
    - chrome devTool
---

對於剛接觸程式的人，可能看到某些 .map 結尾的檔案都會覺得很奇怪，不知道是什麼東西，而且裡面的內容都看不懂，就不理他，其實這是一種叫做 source map 的檔案，它的用途是用來找到原本的程式碼。什麼意思？

<!--more-->

---

## 起源及用途
 
在開始寫 angular 使用 typescript 開發之後，才知道 javascript 到底有多難寫，有多難維護，angular 都建議先用 typescript 開發取代原本 js 的行為，在開始運行 server 或者要編譯靜態檔時，才又把 typescript 編譯為 javascript 檔案，直接編譯過去也可以，你要產生 source map 檔案也可以，source map 就是幫你從編譯後的 javascript 檔案某段程式碼找到對應的 typescript 檔案內的程式碼。

另外一個情境是你需要壓縮檔案大小，你可能會直接開發 javascript 檔案，可是當你要上到 server 上的時候，為了效能可能會做 uglify 或 minify 的動作，做完之後程式碼他娘或他爸（也就是你）都認不出來，source map 一樣可以幫你找回你兒子原本的樣貌。

左邊為編譯前的檔案，右邊為編譯後的檔案

![編譯前的檔案及編譯後的檔案](/blog/images/compileDiff.png)

這有什麼用處？

一般來說是用來做 debug 用的，這樣你在用編譯後的 javascript 檔案 debug 才會知道自己應該修改哪一段 typescript。

後來我才發現有更好的做法。

---

## 檔案的比較

在 chrome 有開發者工具可以用這大家都知道，可是你知道可以直些在 chrome 修改程式碼，將修改的部分也修改到 server 下的檔案嗎？這時靠的也是 source map 的幫助，沒有的話就別想做到。

一開始你在編譯的時候就記得要指定也要產生 source map 檔案，這個步驟就不說明，因為每個程式語言和你自己使用的套件不一樣，不過我會在最後附上一個簡單的範例給大家參考。

檔案大概會像是這樣子。

左邊為編譯後的檔案，右邊為 source map（看不懂也沒關係，鬼才看得懂）

![編譯後的檔案及 source map](/blog/images/sourceMapFile.png)

然後在 server 運行起來，我們來看看有什麼差異

沒有 source map

![沒有 source map](/blog/images/withoutSourceMap.png)

有 source map

![有 source map](/blog/images/withSourceMap.png)

有 source map 你會發現他會連沒有編譯過的檔案也幫你列出來，是不是就看得懂自己應該要改哪裡。但其實如果知道程式碼事自己寫的，應該也都知道，不用靠 source map。另外一個好處是在 chrome 可以下中斷點，因為 uglify 後都會變成一行，我看你怎麼下中斷點！

![中斷點](/blog/images/breakpoint.png)

---

## 在 chrome 的操作

現在來教大家怎麼直接從 chrome 直接修改檔案內的程式碼

1. 將檔案或資料夾加入到 workspace 

記得切換到 source 頁籤，如果 chrome dev tool 在對應的路徑下找的到 source map 檔案，應該會幫你列出尚未編譯的檔案。

對想要進行修改的檔案右鍵，選擇 Add Folder to Workspace

![Add Folder to Workspace](/blog/images/addFolderToWrokspace.png)

2. 編譯後的檔案，映射到相對應的編譯前檔案（可能可省略，沒有成功就記得回來做這個動作）

![Map to File System Resource](/blog/images/mapToFileSystemResource.png)

3. 對檔案進行修改

映射成功應該會像是我這樣的畫面，沒有的話...也是可以修改看看，然後進行到下一個步驟看看有沒有成功。

![Add Folder to Workspace Result](/blog/images/addFolderToWrokspaceResult.png)

要修改的檔案要選擇畫面中橘色資料夾下的檔案喔！

4. 儲存

按下 Ctrl + S 就好（mac 是 command + S)

5. 重新整理

---

## 參考資源
[Sass-如何使用Source Map](http://fireqqtw.logdown.com/posts/203088-sass-how-to-use-the-source-map)

[contemplator/gulp-samle](https://github.com/contemplator/gulp-samle/) 這連結是我使用 gulp 編譯 scss 和 uglify javascript 的範例，大家可以下載下來操作看看：