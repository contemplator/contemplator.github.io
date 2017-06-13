---
title: hexo 建議的設定
date: 2017-06-13 23:12:31
tags:
---

這篇文章介紹我對於 git 的設定還有 _config.yml 的修改

---
<!--more-->

## Git

參照我上一篇 hexo 的建置，你會發現你的專案還不是一個 git 的專案，你輸入 git status 要檢查 git 的狀態，會得不到任何回應。  

我想要把 blog 設置在 gh-pages 分支，因為我要把 master 分支用來保留維修改主題或者其他設定。  
  
1. 在 github 建立 gh-pages 分支
2. 將 _config.yml 的 deploy 下的 branch 改為 gh-pages
2. 為專案資料夾做 git 的初始化  
```
$ git init
```
3. 為專案設置之後我要 push (推送程式碼) 的目的地
```
$ git remote add origin https://github.com/user_name/repository.git
```
4. 檢查遠端 git 的目的地
```
$ git remote -v
```
如果要刪除不要的遠端目的地，指令在下面：
```
$ git remote rm remote_name
```
5. 完成一次 git push 完整的流程

```
$ git add *
$ git commit -m 'init'
$ git push --set-upstream origin master
```

PS. 之後 push 不用再設定目的地
```
$ git push
```

## _config.yml 網站的設定

### github 的 branch (分支)
1. 在 github 建立 gh-pages 的分支
2. 到 repository 的 setting 頁面，將 GitHub Pages 的分支設定改為 gh-pages，記得按下 save
3. 到 yml 檔將 deploy 下的 branch 改為 gh-pages

### 增加網站的 icon

1. 準備一個 favicon.ico
2. 放到 source 下
3. 執行 hexo server 測試
```
$ hexo server
```
4. 打開瀏覽器，在網址列輸入 http://localhost:4000 檢查網站是否增加了 icon

## package.json 增加常用的指令
1. 將本地端的 server 開起來
```
"start": "hexo server"
```
2. 簡單化部署的動作
```
"deploy": "hexo deploy --generate"
```

![Alt text](/blog/images/package_script.png "Optional title")