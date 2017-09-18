---
title: mac 顯示或隱藏檔案
date: 2017-08-15 11:23:51
categories:
    - OSX
---

1. 打開終端機

2. 輸入顯示指令

```
defaults write com.apple.finder AppleShowAllFiles TRUE;\killall Finder
```

3. 取消顯示

```
defaults write com.apple.finder AppleShowAllFiles FALSE;\killall Finder
```