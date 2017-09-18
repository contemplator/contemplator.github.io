---
title: 常用 git 語法
date: 2017-07-09 16:56:18
categories:
    - Git
---

本篇只介紹常用的語法，是我自己使用了 git 這幾年比較常用到的語法和瞭解而已。  
更多的語法可以參見[官方文件](https://git-scm.com/docs)

<!--more-->

## 名詞解釋

commit：指一次 git 的紀錄，紀錄的內容包含修改的內容、辨識的 SHA1 雜湊值、commit 的人和時間等
暫存區：在使用 git add 之後，git commit 之前，暫存將要 commit 的檔案
repository：git 的儲存庫，也可以說是 git 的專案

## Git 基礎語法

學會以下語法就可以完成一次 git commit  

| 語法                | 說明                                 |
|---------------------|--------------------------------------|
| git init            | 將此目錄增加 git 功能                |
| git add -A          | 將所有檔案加入到追蹤，並且在集結狀態 |
| git commit -m "msg" | 將在集結狀態的所有檔案紀錄在此次修改 |

## git add

| 語法           | 說明                                 |
|----------------|--------------------------------------|
| git add <file&gt; | 將指定檔案加入到集結狀態             |
| git add -A     | 將所有檔案加入到追蹤，並且在集結狀態 |
| git add \-\-all  | 同上                                 |

&ast; 星號類似 regex 表達式，表達符合所有檔名  
&ast;.txt 表示所有 .txt 為副檔名的檔案  

## git commit

| 語法                | 說明                                      |
|---------------------|-------------------------------------------|
| git commit          | 記錄修改，並且使用 vim 當作輸入訊息的工具 |
| git commit -m "msg" | 記錄修改，直接在雙引號內輸入訊息(可換行)  |  

## git remote

| 語法                | 說明                                      |
|---------------------|-------------------------------------------|
| git remote -v       | 查看目前有哪些遠端目標 |
| git remote rm <remote alias&gt; | 刪除指定別名為 remote alias 遠端目標 |
| git remote add <remote alias&gt; <remote url&gt; | 增加 remote url 遠端目標，並且設定別名為 remote alias |

## git push

| 語法                                  | 說明                         |
|---------------------------------------|------------------------------|
| git push -u <remotes&gt; <branch&gt; | 第一次上傳，設定上傳分支，並且推送到指定的遠端伺服器及分支 |
| git push --set-upstream <remote&gt; <branch&gt;| 同上|
| git push                              | 非第一次上傳 推送到預設的遠端伺服器及分支 |

## git branch

| 語法       | 說明                                          |
|------------|-----------------------------------------------|
| git branch | 顯示目前 git 專案所有的分支，和目前所在的分支 |

## git checkout

| 語法                     | 說明                                    |
|--------------------------|-----------------------------------------|
| git checkout <branch&gt;    | 切換到指定的 branch                     |
| git checkout -b <branch&gt; | 切換到指定的 branch，如果沒有的話就建立 |
| git checkout \-\- <file&gt;   | 將檔案回復到上次 commit 的狀態          |

## git reset (TBD)

| 語法                           | 說明                                                    |
|--------------------------------|---------------------------------------------------------|
| git reset HEAD <file&gt;     | 將指定的檔案移出暫存區，變成尚未追蹤狀態，保存修改      |
| git reset \-\-soft <commit&gt; | 將 HEAD 指標指到指定的 commit，修改會保留               |
| git reset \-\-hard <commit&gt; | 將檔案回復到指定的 commit，並且刪除指定 commit 後的修改 |

## git log

| 語法                     | 說明                                     |
|--------------------------|------------------------------------------|
| git log                  | 顯示過去 commit 的歷史紀錄               |
| git log <-number&gt;        | 顯示過去 commit 最近 number 筆的歷史紀錄 |
| git log \-\-pretty=oneline | 顯示過去每筆 commit 的歷史紀錄於一行內   |

## git config

| 語法                                                               | 說明                                  |
|-------------------------------------------------------------------|---------------------------------------|
| git config <\-\-system &#124; \-\-global &#124; \-\-local> user.name "value"      | 於指定的層級，設定 user.name 為 value |
| git config <\-\-system &#124; \-\-global &#124; \-\-local> alias.<name>="command" | 設定 command 指令的別名為 name        |
