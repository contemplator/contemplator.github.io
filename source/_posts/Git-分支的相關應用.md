---
title: Git 分支的相關應用
date: 2019-03-12 12:40:32
categories:
  - Git
tags:
  - branch
---

## 推到 server

```
git push -u origin <branch_name>
```

## 從 server 拉下來

```
git checkout -b <branch-name> origin/<branch-name>
// <branch-name> 是一樣的
```

如果遇到錯誤，請執行

```
git pull
git checkout <branch-name>
```

## 刪除 server 上的分支

```
git push --delete <remote_name> <branch_name>
```

<!--more-->

## 新增本地分支

```
git branch <branch-name>
```

## 切換到分支

```
git checkout <branch-name>
```

或者想要新增同時又切換到新分支，可以輸入

```
git checkout -b <branch-name>
```

## 刪除分支

```
git branch -d <branch-name>
```

## 合併分支

```
git checkout master
git merge <branch-name>
```

通常是先切換到當初分支出來的主分支，在主分支執行 git merge

## cherry-pick 取用某個 commit

```
git cherry-pick <commit-sha1>
```

操作流程如下

```
git checkout master
git commit -m '某些修正'
git log
// 找到剛剛的 commit sha1，假設為 a123456
git checkout dev
git cherry-pick a123456
```

如果在 master 修改，再回到 dev 使用 cherry-pick，兩邊都會有不同的 sha1 的 commit，當 master 又要 merge dev 時，需要解決其他衝突

## rebase

```
git checkout <other-branch>
git rebase master
```
 
我的理解是，假設平常都是在 dev 修改程式，master 是只有將程式上線到正式環境才會 commit 的主分支，如果臨時要對 master 修改，先將 master 修改後，再回到 dev rebase master，讓 dev 重新以修正問題的 master 為基底繼續修改。

如果是在 master 直接修改，在 dev 使用 cherry-pick，後續要在 master merge dev 會需要處理很多衝突。

如果記不起來應該何時使用，可以都使用 merge 就好，使用 merge 只是會多出一個 commit 的節點，是否有衝突，如何處理，都是一樣的。

---

## 參考資料

[freecodecamp](https://www.freecodecamp.org/forum/t/push-a-new-local-branch-to-a-remote-git-repository-and-track-it-too/13222)
[stackoverflow](https://stackoverflow.com/questions/9537392/git-fetch-remote-branch)
[連猴子都能懂的Git入門指南〜掌握版本控制](https://backlog.com/git-tutorial/tw/)