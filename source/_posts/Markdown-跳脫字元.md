---
title: Markdown 跳脫字元
date: 2017-07-14 23:14:00
categories:
    - Markdown
tags:
    - escape
    - 跳脫字元
---

在說明之前，可以先了解 Markdown 和 html 一樣是標記型語言，倒不如說他是一種 html 的變形，因為我們寫的 Markdown 會被編譯成 html 語法，讓我們便於書寫，也讓觀眾便於閱讀。

但是各家的 Markdown 都會有點不一樣，像是 Github 的 README.md 和 我這個 blog 使用的 hexo 就有些地方不一樣。

<!--more-->

就像我前面說的，為了讓我們便於書寫，我們會使用一些符號代表某些意義，讓我們的文章看起來是經過排版和設計的。語法可以看我上一篇文章：[Markdown 常用語法]()

像是大於小於符號 "<>" 如果直接在 markdown 文件直接寫 "<英文字>" 你的 "<英文字>" 就會不見，因為會背叛別成你是要寫 html 語法。或者像是你想要寫 "|" 用來分隔什麼東西，他也會不見。

這時候你就要用其他方式輸入，你只要 google：html entities 或者跳脫字元，就會有相關文章。

---


### Entity Name
[w3school](https://www.w3schools.com/html/html_entities.asp) 有介紹常用的跳脫字元。

如果你要顯示 > 就輸入：
```
&gt;
```

---

### Entity Number | ASCII 碼

還有另外一種狀況，就是如果你要輸入 "|"，發現剛剛那個網站沒有範例，你可以去查 "|" 這個字元的 ASCII 碼對應的數字。[ASCII 對照表](https://zh.wikipedia.org/wiki/ASCII)

你想要顯示 | 可以輸入： 
```
&#124;
```

---

### 反斜線 \

如果你有寫過正則表達式，你應該用過 "\" 反斜線，反斜線也可以幫你顯示某些特殊字元。