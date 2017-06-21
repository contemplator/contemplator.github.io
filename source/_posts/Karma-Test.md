---
title: Karma Test
date: 2017-06-20 17:35:38
tags:
    - test
---

如果你和我一樣使用 angular cli 建立專案，你會發現在 app 資料夾下有 5 個檔案：
- app.component.ts
- app.module.ts
- app.component.html
- app.component.css
- app.component.spec.ts

\*.spec.ts 會在你執行 npm test 的時候運行，因為 karma.conf.js 和 src/test.ts 會設定好要運行專案下的所有 *.spec.ts 檔案

<!--more-->

---

建議先把 app.component.spec.ts 另存名稱備份，待會我們要先跟著 angular.io 文件寫一個簡單的單元測試，如果讓 app.component.spec.ts 也被執行，會有很多看不懂的訊息跑出來。

### 建立一個 src/app/1st.spec.ts

### 寫單元測試

在 1st.spec.ts 檔案內加入以下程式碼：

```
describe('1st tests', () => {
  it('true is true', () => expect(true).toBe(true));
});
```

這是讓 true 等於 true，所以測試結果一定是成功的。

### 執行所有測試 test

如果你在 vs code 下，按下快捷鍵 ctrl + `，會開啟終端機，輸入以下指令：

```
$ npm test
```

輸入之後會編譯 angular 專案，並且打開預設瀏覽器，顯示測試的結果，沒有意外的話會如下圖：

![Karma Test](/blog/images/karma_test1.png)

### 修改為錯誤結果

在 1st.spec.ts 檔案中將任意一個 true 改為 false

### 查看錯誤訊息

ng test 會監聽所有 *.spec.ts 內容的改變，所以修改後儲存再瀏覽器查看就好了。

### 開啟 Debug 模式

- 在剛剛的瀏覽器右上角有一個 Debug 的按鈕，點下去之後他會幫你開啟另外一個頁籤。

- 開啟開發者模式 ( windows 下按快捷鍵 F12) 切換到 source 頁籤

- 找到 1st.spec.ts 檔案，如果沒有，按下快捷鍵 ctrl + p，輸入檔案名稱。

- 在 1st.spec.ts 插入中斷點 (點擊程式碼旁邊的行數就好了)

- 重新整理畫面就可以停在中斷點