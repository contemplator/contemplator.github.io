---
title: '在 GitHub 使用 SSH'
date: 2017-06-15 14:35:26
tags:
---

有些資料傳輸都還是用明碼(也就是不加密的方式)傳輸，這樣其實是非常危險的，而且傳輸的過程中，可能還會被有心人士擷取。

SSH 全名為 Secure Shell，透過 SSH 可以對所有傳輸的資料進行加密，也可以防止 DNS 和 IP 欺騙。

(資料來源：[維基百科](https://zh.wikipedia.org/wiki/Secure_Shell "SSH"))

<!--more-->

---

首先，假設你已經在你的電腦安裝的 git。

如果沒有請到[官方](https://git-scm.com/ "Git")下載並安裝

1. 打開你的 Git Bash

2. 切換到電腦的使用者資料夾下

```
$ cd /d C:/Users/your_user_name
```

3. 輸入以下指定

```
& ssh-keygen -t rsa -C "youremail@emailhost"
```

過程中會問你三個問題，第一是要將金鑰儲存在哪裡，第二和第三是要你輸入密碼，我自己都是直接按 enter，結束後出現類似下面的訊息就是成功。
```
Your public key has been saved in ...
...
The key's randomart image is:
```

4. 到你的路徑下找到金鑰，路徑應該會是 C:/Users/your_user_name/.ssh 資料夾內

- id_rsa 為你的私鑰
- id_rsa.pub 為你的公鑰，請將此內容貼到 github 的設定內

5. 登入你的 GitHub 進行 SSH 的設定

進入你的 Profile -> Settings

![Alt text](/blog/images/github profile.PNG "profile")

點擊 SSH 頁籤，增加一個 SSH 金鑰

![Alt text](/blog/images/github setting ssh.PNG "profile")

6. 將 github.com 加入到認識的主機

一樣打開你的 git bash，然後輸入以下指定

```
$ ssh -T git@github.com
```

執行之後，如果遇到問你要不要繼續連線到 github.com 授權，請輸入 yes，看到以下畫面後就代表成功。

```
Warning: Permanently added 'github.com,192.30.253.113' (RSA) to the list of known hosts.
Hi contemplator! You've successfully authenticated, but GitHub does not provide shell access.
```

[參考文件](https://dotblogs.com.tw/kirkchen/2013/04/23/use_ssh_to_interact_with_github_in_windows)