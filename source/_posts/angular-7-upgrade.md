---
title: angular 7 upgrade
date: 2018-12-16 15:21:38
categories:
  - angular
tags:
---

angular 7 在今年 10 月就已經可以升級摟！不過當然我才不會傻傻的那時候就更新我的專案啦～

<!-- more -->

---

## 更新方式

[Angular Upgrade Guide](https://www.google.com.tw/search?q=angular+upgrade&oq=angular+upgrade&aqs=chrome..69i57j69i60j0l4.13893j0j4&sourceid=chrome&ie=UTF-8)

這個更新教學網站一樣有效。

如果你跟我一樣在 `ng update @angular/cli @angular/core` 發現專案內的 angular 套件根本沒動，請改成以下指令：

```
ng update @angular/cli @angular/core --force
```

---

## 這次又改了什麼？

[Angular Change Log](https://github.com/angular/angular/blob/master/CHANGELOG.md)

[外國人整理的重點](https://medium.freecodecamp.org/whats-new-in-angular-7-0-and-how-to-upgrade-f2ed22a79e28)

對我來說，我是使用 Primeng 套件的人，沒有使用 Angular Material，但還是有受到一些影響，因為 Primeng 也升級到 Angular 7 了，同時也在某些套件使用到 Virtual Scrolling，所以我剛升上去有遇到一些問題。

不過只要按照錯誤指令就可以發現問題根源，就是要補安裝 @angular/cdk 這個套件：

```
npm install --save @angular/cdk
```

--angular 好像越來越肥了呢，又加了一個 library--