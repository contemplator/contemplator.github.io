---
title: Git 合併其他分支上的 commit
date: 2018-02-13 17:10:28
categories:
    - Git
tags:
    - cherry-pick
    - merge
---

不是用 merge，是用 <font color='#d9534f'>cherry-pick</font>

<!--more-->

## 情境說明

我主要都是在 dev 分支上開發，因為有個功能不確定要不要加入，所以另開了一個分支 issue-9 處理這個問題，結果在處理問題時發現有個問題蠻嚴重的，但是已經 commit 到 issue-9 這個分支上，我需要在 dev 也適用這個更動，但是其他修改不要 merge 回去 dev。

## 使用 git cherry-pick

先在 issue-9 上找到我要合併到 dev 的那個 commit 的 sha1 值

```
git checkout issue-9
git log --pretty=oneline
```

PS. 輸入 q 即可以離開

假使我要的 commit 的 sha1 前六碼是 5e9eeb

```
git checkout dev
git cherry-pick 5e9eeb
```

這樣子就完成了，如果有衝突，和 merge 一樣手動變更吧！

---

參考資料：

[Git合并特定Commits 到另一个分支](https://www.jianshu.com/p/ed3cc84b48cb)