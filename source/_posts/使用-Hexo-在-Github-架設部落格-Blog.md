---
title: 使用 Hexo 在 Github 架設部落格 | Blog
date: 2017-06-12 23:07:34
tags:
---

## 前置作業

* Nodejs  
    需要使用到 npm  
    在終端機輸入以下指令，檢查是否安裝
    ```
    $ node -v
    $ npm -v
    ```
* Git
    需要使用 Git 推送程式碼及資料到 Github
    
---  

<!--more-->

## 開始正題
1. 在 GitHub 建立一個 repository
2. 安裝 Hexo 在全域
    ```
    $ npm install -g hexo
    ```
3.  初始化一個 Hexo 資料夾（你也可以叫他專案)
    ```
    $ hexo init project_name
    ```
4. 安裝需要的套件
    ```
    $ cd project_name
    $ npm install
    ```
5. 安裝 hexo-deployer-git 在此專案  
不可以安裝在 devDependencies
```
$ npm install --save hexo-deployer-git
```
6. 配置 yml 設定檔

### Site 網站配置
| 配置屬性 | 說明     |
|----------|----------|
| title    | 網站名稱 |

### Url 網站路徑配置
| 配置屬性 | 說明                                              |
|----------|---------------------------------------------------|
| url      | 網站網址 <br>ex: http://github_user_name.github.io/   |
| root     | 網站的根目錄，github 的 repository 名稱  <br>ex: blog |

### Deployment 部署配置
| 配置屬性 | 說明                                                                                                          |
|----------|---------------------------------------------------------------------------------------------------------------|
| deploy   | 部署的意思                                                                                                    |
| type     | 部署的方式 <br>ex: git                                                                                            |
| repo     | git 上面的 repository 路徑，從 github repository 的 use ssh 取得 <br>ex: git@github.com:github_user_name/blog.git |
| branch   | github 的分支名稱 <br>ex: master                                                                                  |
  
7. 產生靜態檔（編譯 hexo 專案)
```
$ hexo generate
```

8. 部署到 github 上
```
$ hexo deploy
```