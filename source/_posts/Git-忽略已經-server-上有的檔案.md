---
title: Git 忽略已經 server 上有的檔案
date: 2017-07-02 23:40:03
tags:
    - git
---

.gitignore 可以忽略一些專案內的設定檔，像是 .classpath 或 .gradle 這些由專案自動產生，並且只適用於自己電腦的檔案，這些檔案可能在共同開發專案夥伴的電腦上並不會完全一樣，所以如果不忽略，可能會蓋來蓋去的。

<!--more-->

可是假設你希望一起開發專案的人，在第一次 clone 下來時要 clone 下來，但是之後就不要再 push 上去，或者是有些設定檔你不需要被 server 上的更動而蓋掉呢？

```
$ git update-index --assume-unchanged &lt;file-path>
```

上面這句話就是假設某個檔案，是假設他是沒有被改變的狀態，所以 git 就不會需要 add 到 satge 和 commit ，還有之後的 push。

PS. &lt;file-path> 就是某個檔案的路徑

如果你要檢查哪些檔案是被你設定為 --assume-unchanged 狀態的，可以輸入以下指令查看：

```
$ git ls-files -v | grep -e "^[hsmrck]"
```

取消的方式

```
$ git update-index --no-assume-unchanged &lt;filepath>
```

Reference：
http://archive.robwilkerson.org/2010/03/02/git-tip-ignore-changes-to-tracked-files/
http://stackoverflow.com/questions/32287061/undoing-git-update-index-assume-unchanged
