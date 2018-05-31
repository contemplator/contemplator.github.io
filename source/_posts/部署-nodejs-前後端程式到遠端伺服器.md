---
title: 部署 nodejs 後端程式到遠端伺服器
date: 2018-06-01 00:27:07
categories:
    - Nodejs
tags:
    - vultr
    - deploy
---

## 目的

雖然現在架站服務和工具很多，但是菜味重如我，還是偶爾會有一些東西常常忘記，我還可以從記憶中抓出關鍵字去 google，可是如果大腦乾淨如白紙，可能遇到問題就不知從何下手，或者連問題都不知道是什麼，那就只能放棄。

<!--more-->

所以此篇純屬當作筆記，若是好運被人看到，歡迎鞭。

---

## 目錄

- [Vultr 介紹](#)
- [準備一個 nodejs server 程式](#)
- [準備一個呼叫 server 的客戶端工具](#)
- [部署到 Vultr 的 VPS 上](#)

---

## 筆記重點

- 知道一些虛擬主機商，不讓作品只在內網
- nodejs 簡單實作 RestFul API
- nodejs 部署到 remote server 的方式
- nginx 讓 nodejs 前後端都使用相同的 domain name 和 port (埠)
- linux 防火牆開通
- 測試 API 的工具 - Postman
