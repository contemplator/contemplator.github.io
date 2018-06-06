---
title: unbunt 新的 user 在 terminal 沒有 tab 自動完成可以使用
date: 2018-06-05 23:42:31
categories:
    - Ubuntu
tags:
    - autocomplete
    - shortcut
---

在 Vultr 新運行的 Ubuntu Server，新加了一名 User 之後，發現在終端機的操作上，沒有自動完成，也沒有上一句指令可以快速叫出，所以 Google 了一下問題。

<!--more-->

---

## 安裝 bash-completion 套件

### apt-get 安裝

```
$ sudo apt-get install bash-completion
```

### 在 .bashrc 加入指令

PS. 通常在執行上一個步驟時，就會發現已經安裝了，我也是在上一個步驟就有發現，然後在準備修改 .bashrc 檔案時，發現我現在使用的新 User 沒有使用到 /bin/bash 的設定

---

## 為新 User 加入 /bin/bash 環境配置

### 查看 root 的環境配置

```
$ getent passwd root
```

應該會看到以下訊息：

```
root:x:0:0:root:/root:/bin/bash
```

### 為新 User 加入環境配置

```
$ chsh -s /bin/bash <new-user>
```

---

## 參考資料

[Terminal autocomplete doesn't work properly](https://askubuntu.com/questions/545540/terminal-autocomplete-doesnt-work-properly)

[Tab Autocomplete for New User](https://serverfault.com/questions/99787/tab-autocomplete-for-new-user)