---
title: mac 修改螢幕截圖設定
date: 2017-08-16 21:40:43
tags:
    - mac
---

用了 Mac 這麼久，桌面很習慣保持乾淨，但是每次都會因為截圖變的很亂，明明就有一個資料夾叫圖片，所以決定找方法改存到指定的位置。

<!--more-->

1. 打開終端機

2. 輸入指令

```
defaults write com.apple.screencapture location "/Users/idlefox/Pictures/螢幕截圖"
```

"/Users/idlefox/Pictures/螢幕截圖"是我自己指定的，記得改成自己的路徑

3. 測試

先關閉終端機，然後登出使用者，再進行登入。

進行 command + shift + 3 測試看看。

---

參考資料
[更改-mac-screencapture-螢幕截圖的預設位置及預設格式](https://bonze.tw/%E6%9B%B4%E6%94%B9-mac-screencapture-%E8%9E%A2%E5%B9%95%E6%88%AA%E5%9C%96%E7%9A%84%E9%A0%90%E8%A8%AD%E4%BD%8D%E7%BD%AE%E5%8F%8A%E9%A0%90%E8%A8%AD%E6%A0%BC%E5%BC%8F/)
