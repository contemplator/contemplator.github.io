---
title: Virtual Box 安裝 Ubuntu 紀錄
date: 2017-06-26 11:37:31
categories:
    - Ubuntu
tags: 
    - Virtual Box
---

最近有點想要了解網管的工作，還有就是學一些較底層的東西，所以又開始接觸 VM，這次一樣是使用之前大學就常用的 Virtual Box，希望可以在 VM 架設 FTP 和 nodejs 的服務，同時可以讓我的實體機可以連到 VM。

<!--more-->

## 新建一個虛擬機
- 下載 Virtual Box
- 下載 Ubuntu 映像檔
- 設定虛擬機

## 設定內外(虛擬機、實體機)可以互連的網路
- 在實體機區域網路的增加一個虛擬 ip
> 假設 ip 為 192.168.0.1
- 在虛擬機增加一個橋接器網卡
- 在虛擬機的橋接器網卡設定 ip，並且和實體機在同一個網域下
> 假設 ip 為 192.168.0.2  
> 假設 mask 為 255.255.255.0  
> 假設 gateway 為 192.168.0.1 (要和實體機增加的 ip 一樣)  

## 測試內外互連的狀況
- 實體機
> 打開終端機 (terminal)
> $ ping 192.168.0.2

- 虛擬機
> 打開終端機 (terminal)
> $ ping 192.168.0.1

## 問題(待解)
Q: 原本我在 Virtual Box 只有使用一張網卡 NAT，之後為了互連，不管是 NAT 改成橋接介面卡還是保留 NAT 增加另外一張橋接介面卡，都會無法連到外網(ex: google.com.tw)，只能實體機和虛擬機相連。
> A: ...