---
title: Markdown 常用語法
date: 2017-07-14 22:36:50
categories:
    - Markdown
---

這邊我會介紹我常用的 markdown 語法

<!--more-->

### 標題
```
##
###
ex: ### 標題
```

"#" 井字號開頭，就是標題的意思，像是 html tag 的 &lt;h1&gt; 到 &lt;h5&gt;

--- 

### 分隔線

```
---
```

"-" 連續三個減號，也可以叫 dash 比較潮，這樣就會跑出一個分隔線 &lt;hr&gt;

---

### 縮排、引言

```
>
```

">" 大於符號後面所接的文字，就會向右縮排，如果越多 > 的符號，就會縮排越多。

> 至理名言

---

### 項目清單

```
- 
```

"-" 如果只有一個減號，就會變成項目清單，像是 &lt;ul&gt;，是沒有序列觀念的清單

- 蘋果
- 香蕉
- 芭樂

--- 

### 序列清單

```
1.  
2. 
```

"1. " 使用阿拉伯數字接一個 "." 點和一個 " " 空白符號，就會變成序列清單，像是 &lt;ol&gt;。

1. 第一項
2. 第二項

PS. 但是不知道為什麼我用 hexo 寫的文章都會變成 &lt;ul&gt;

--- 

### 超連結

```
[顯示的文字](link_url)
ex: [Google 首頁](https://google.com.tw)
```

如果要插入一個超連結，先使用 "[]" 中括號夾住要顯示的文字，然後再用 "()" 夾著目標連結的 url。

[Google 首頁](https://google.com.tw)

--- 

### 圖片

```
![alt 訊息](image_url)
ex: ![測試圖片](/blog/images/test.png)
ex: ![錯誤圖片連結](/blog/images/error.png)
```

如果你要插入一個圖片，語法比較難記，用 "[]" 中括號夾住 alt 訊息，要知道什麼是 alt 訊息，請去了解 html tag &lt;img&gt; 的 alt 屬性用途。
再用 "()" 小括號夾住你圖片的路徑，記得前面要加 "!" 驚嘆號，和外部連結區別。

![測試圖片](/blog/images/test.png)

![錯誤圖片連結](/blog/images/error.png)

---

### 表格

```
| 配置屬性 | 說明     |
|----------|----------|
| title    | 網站名稱 |
```

如果要插入表格，就是用 "|" "-" 這兩個符號做排版，因為要手動 key 的完美有點困難，我推薦這個網站：[Tables Generator](http://www.tablesgenerator.com/markdown_tables)

| 配置屬性 | 說明     |
|----------|----------|
| title    | 網站名稱 |