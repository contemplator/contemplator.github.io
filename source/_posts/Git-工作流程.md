---
title: Git 工作流程
date: 2017-07-14 22:12:14
categories:
    - Git
---
用了這麼久的 git，其實有時候就是當作備份程式碼的地方，commit 的訊息都留下什麼日期，改了哪一段程式碼，然後又都是在 master 分支進行修改，上次終於出糗了，不知道要回復到哪一個我認為正確的版本...

<!--more-->

### Git commit 留下有意義的訊息

很常在學生專案，或者剛接觸 Git 的開發者的 Git 專案內看到意義不明的 commit 訊息，其實在使用 Git 的時候，應該就要知道 Git 是用來幫程式做版本控制的，萬一每次 commit 的訊息自己都看不懂，看不懂這次到底修改了什麼，如果自己把什麼東西改壞了，又該怎麼知道應該回復到哪一個版本呢？

那為什麼大家都會 commit 不必要的訊息？

原因有很多，一個是因為程式忽然不 work ，或者介面上某個片與好像不夠好，想要修改一點小東西，接下來你就修好它，留下一段 commit 訊息 "修正錯誤、調整 table css"，修正錯誤可能講得太籠統，不知道到底修改了什麼；調整 Table css 還算可以，但其實有點沒有必要，因為 git 也會幫你記得你改了哪一段程式碼。

哪什麼是適合的 commit 的訊息？

像是你這次為什麼要做修改？處理掉什麼錯誤？增加什麼功能？其實就是一則高品質的訊息。

那如果東西真的已經上架了，東西也一定要馬上修改，馬上 commit，那你就在 git 說明做了什麼修改吧！

### 工作做到一半，我急著要去修改其他版本，git 到 master 影響部署

最近我在公司就遇到一個問題，git 專案剛建立時，預設就會建立一個 master，我們專案部署成功後，像某些 GitHub 專案一樣，master push 成功後就幫你部署，我們有個新人改完一個小問題之後，就 push，可是還沒有完整改完，就這樣把尚未完成的網站給部署到正式區了。

其實現在有許多工作流程都不太會直接把小修小改直接 push 或者 merge 到 master 或者負責部署的 branch，因為如果遇到要發佈時，程式碼其實並不完美，甚至連運行都有問題，你就糗大了，所以像是 Github 工作流程，都會另外建一個 developer 分支，主要的修改都在 developer，如果有功能或者其他議題要處理，就在 developer 分支開枝散葉出去，當你確定 developer 分支已經到了ＯＫ時，就是可以正常運行，暫時也沒有要做修改，或者完成這次版本要發佈的功能，你就可以 merge 到 master 進行部署。

### 我認為正確的工作流程：

1. master 建立第一版或不要
2. 建立 developer branch
3. 條列功能或修改清單
4. 從 developer branch 分支出去
5. 切換到現在要做的功能分支進行作業
6. 完成編輯及測試後，merge 到 developer，回到第 4 執行到 第 ㄒ6 不斷迴圈，直到完成此次上線版本要完成的項目
7. merge 到 master 部署