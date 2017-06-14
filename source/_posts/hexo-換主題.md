---
title: 'hexo 換主題'
date: 2017-06-14 17:21:55
tags:
---

這篇主要是介紹怎麼換掉 hexo 的主題 (Theme)，順帶一提，原本的主題叫 landscape，我現在用的叫做 material-flow。

因為我也只有換過 material-flow，所以文章內容我也是以 material-flow 為範例。

<!--more-->

---

### 找自己想要的主題

[官方主題](https://hexo.io/themes/ "官方主題")

### 看安裝說明

[Material Flow: Github](https://github.com/stkevintan/hexo-theme-material-flow "Material Flow")

最下面有 Installation 章節

### 安裝

#### 切換到自己的專案目錄下
```
$ cd /your/path/blog
```

#### 輸入 npm 安裝指令
```
$ npm i -S hexo-generator-search hexo-generator-feed hexo-renderer-less hexo-autoprefixer hexo-generator-json-content
```

這是要確保他人寫好的主題要使用到的套件，你的專案是否都有正確安裝

#### 下載別人寫好的主題到自己的專案目錄下
```
$ git clone https://github.com/stkevintan/hexo-theme-material-flow themes/material-flow
```
很神奇的是這個安裝不會安裝在 node_modules，而是會安裝在專案目錄的 themes 下

### 修改 hexo 的設定檔
打開你的專案目錄下的 _config.yml，將 theme: landscape 改成 theme: material-flow

### 測試看看

```
$ hexo server
```