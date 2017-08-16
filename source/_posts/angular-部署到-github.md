---
title: angular 部署到 github
date: 2017-08-16 17:41:53
tags:
    - github
    - angular
---

1. 安裝 npm 全域套件

```
npm i -g angular-cli-ghpages
```

--- 

2. 使用 angular cli 工具建立一個專案

--- 

3. 使用 ng build 產生靜態檔

```
ng build --prod --base-href \"https://contemplator.github.io/angular-prime/\"
```

--prod 是要產生產品階段，不要是開發中的階段

--base-href 是要讓 github 上的網站知道我這個專案的根目錄是到哪裡，不設定的話，連結會亂跳

PS. router 也建議使用 hash 比較不會有問題

--- 

4. 部署

```
angular-cli-ghpages --no-silent
```

--- 

5. 到 github 上的網站上檢查

&lt;your-github-username>.github.io/&lt;repository>

---

可以參考我目前 github 專案的設置，就是看 package.json 的設置就好，之後只要使用 npm script 執行就可以完成部署，很方便。

[package.json](https://github.com/contemplator/angular-prime/blob/master/package.json)