---
title: linux 環境下使用 regex 刪除檔案
date: 2020-12-18 17:35:12
categories:
  - Ubuntu
---

查詢檔名符合條件的檔案

條件為：localhost_access_log..2018*

```
$ ls | grep -P "localhost_access_log..2018*"
```

![regex 刪除檔案](/images/regex 刪除檔案01.png)

查詢檔名符合條件的檔案並 "刪除"

```
$ ls | grep -P "localhost_access_log..2018*" | xargs -d"\n" rm
```

![regex 刪除檔案](/images/regex 刪除檔案02.png)

<!-- more -->

# 參考

[https://superuser.com/questions/392872/delete-files-with-regular-expression](https://superuser.com/questions/392872/delete-files-with-regular-expression)