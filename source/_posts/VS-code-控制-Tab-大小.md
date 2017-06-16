---
title: 'VS Code 控制 Tab 大小'
date: 2017-06-16 09:12:12
tags:
---

VS code 全名為 Visual Studio Code，是一個功能強大的記事本軟體，因為在開發 angular2，大家都推薦這個，就開始用了。

大家在寫程式的時候，蠻常會遇到排版的問題，VS code 也有自動排版的功能，快捷鍵是 Shift + Alt + F，之前用還蠻有問題的，最近好像有在改善，但是!!!常常還是有每個人 tab 大小不一，或者有些 cli 工具產生的檔案，tab size 就是不一樣。

<!--more-->

---

### 單一檔案的調整
在 VS code 右下角會顯示 "空格:4"，如果不喜歡這個 tab size 可以點這個進行調整。

![VS code editview](/blog/images/vscode_editview_tab_size.PNG)

![Select Formatter](/blog/images/vscode_formatter_tab.PNG)

選擇想要的空格數，然後再按一次快捷鍵 Shift + Alt + F

### 修改 settings 內的 tab size

1. 先打開 VS code 的偏好設定
2. 搜尋 tabsize
3. 在右邊的畫面 (User Setting) 加上 tabsize 的設定
如下圖

![VS code settings](/blog/images/settings_tabsize.PNG)

### 關閉偵測檔案預設的 tabsize 大小

假設我自己設定 tabsize 大小為 4，可是每次 angular-cli 產生的檔案 tabsize 就是 2，或者別人給我的不是 4，我按下快捷鍵 Shift + Alt + F 都沒有排成我想要的樣子，你就可以參考此做法

1. 先打開 VS code 的偏好設定
2. 搜尋 detectIndentation
3. 在右邊的畫面 (User Setting) 加上 detectIndentation 為 false 的設定
如下圖

![VS code settings](/blog/images/vscode_detectIndentation.PNG)