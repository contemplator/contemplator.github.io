---
title: Vue Hitstory Mode with Nginx
date: 2022-04-14 15:46:52
categories:
  - Vue
tags:
  - Router
---

`Vue Route history mode 不在根目錄路徑(/)下重新整理會遇到 404 問題`

因為是 SPA (Single Page Application) 模式，所以只會存在一個 index.html 資源。

假設情境如下：

我的 domain name 是 example.com

我是使用 nginx 當作 Web Server，我的 Linux 機器放置 Web 的地方預設會在 `/var/www/html/` 下

<!-- more -->

現在我有個專案是 resume，我將 vue build 出來的 dist 搬到 `/var/www/html/resume/` 下

我在瀏覽器輸入網址 [http://www.example.com/resume](http://www.example.com/result) 會正常顯示，因為他會正確取得 `/var/www/html/resume/index.html` 以及其他依賴的資源。

可是我在瀏覽器輸入網址 [http://www.example.com/resume/projects](http://www.example.com/result) 則會顯示 404 錯誤，因為 `/var/www/html/resume/projects/index.html` 資源不存在

這時候可以透過 nginx 設置解決這個問題：

找到你的 nginx 設定檔案，可能是：

1. ../nginx/nginx.conf
2. ../nginx/sites-enabled/default

加入：

```jsx
	location /resume {
		try_files $uri $uri/ /resume/index.html;
	}
```

意思就是當進入 /resume 這個路徑下時，都先去取得 /resume/index.html 這個資源，這樣你的 Vue 的 SPA router 就會作用了。

參考資料：[Different History modes | Vue Router (vuejs.org)](https://router.vuejs.org/guide/essentials/history-mode.html)