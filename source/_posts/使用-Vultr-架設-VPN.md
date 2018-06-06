---
title: 使用 Vultr 架設 VPN
date: 2018-06-02 17:17:21
categories:
tags:
    - Vultr
    - VPN
---

一直想架 VPN 很久了，可是之前找文章都覺得很麻煩，最近剛好在 Vultr 試用他們的主機，剛好看到他的 App 有提供 OpenVPN 想說就試用一下，架設還蠻簡單的。

<!--more-->

---

## 選擇 OS 和 安裝 OpenVPN 

切換到 Application 的頁籤，選擇 OpenVPN

**PS. 注意，選了 Application 就不要再去選 OS 了，因為選擇了 Application 就等於選了他指定的 OS**

![Vultr App select OpenVPN](/blog/images/vultr_app_openvpn.png)

---

## 完成剩下的選擇並部署

選擇你要的硬體規格，以及是否需要其他的功能，這邊建議不用 IPv6，因為在官方文件中好像有提到尚未支援 IPv6。

接下來就按下右下角的 Deploy Now 就可以了。

---

## 設定 VPS server 的使用者資訊

### 使用 ssh 登入 root

```
ssh root@<your-ip>
```

密碼可以在 Vultr 的 Server Information 頁找到。

登入到 Vultr 顯示你的 VPS server 清單頁，點擊你剛剛建立的機器，就會進入到 Server Information 頁。

![vultr looking for root password](/blog/images/vultr-looking-for-root-password.png)

### 改變你的 root 使用這密碼

```
passwd
```

再輸入兩次密碼做確認，就更改完成了

### 增加一名 user 

```
useradd <your-new-user-name>
```

### 更改剛剛建立的 user 登入密碼

```
passwd <your-new-user-name>
```

再輸入兩次要變更的密碼，就更改完成了

---

## 打開 OpenVPN 頁面進行檔案下載

你應該會在進入到 Vultr Server Information 頁面看到以下內容

![Vultr OpenVPN Infomation](/blog/images/vultr_openvpn_infomation.png)

開一個新的瀏覽器頁面，在網址列輸入 https://your-ip

如果你跟我一樣是 mac，根據指令會開始下載 openVPN client 端的 dmg 安裝檔，點開進行安裝，就可以在 mac 上方的工具列看到圖示

![mac openvpn icon](/blog/images/mac_openvpn_icon.png)

你可以使用 Vultr 預設的 openVpn 使用者身份登入

---

## 為 OpenVpn 增加使用者

開一個新的瀏覽器頁面，在網址列輸入 https://your-ip/admin/

你就會看到一個登入的表單，輸入 Vultr 預設的 openVpn 使用者身份

登入成功後，在左邊導覽列找到 User Management - User Permissions 連結

在右邊使用者清單增加剛剛使用 useradd 增加的 user

**PS. Vultr 的 OpenVPN 的 user 好像是參考到 Vultr VPS server 的 user，所以不必再設定密碼**

然後按下 Save Settgins 就完成了

---

## 連到 VPN

在 mac 上方的 icon 找到 OpenVPN 的 icon

選擇 connect to your ip 

輸入使用者帳密，成功的話，會看到成功訊息

---

## 測試 VPN 是否正常運作

連到 [查看自己 IP 的網站](https://whatismyipaddress.com/zh-cn/index)

看自己的 IP 是不是已經變成 Vultr VPS 的 IP 了

---

## 參考資料

[Vultr OpenVPN Doc](https://www.vultr.com/docs/one-click-openvpn)

[Linux Set or Change User Password](https://www.cyberciti.biz/faq/linux-set-change-password-how-to/)

[Linux List All Users In The System](https://www.cyberciti.biz/faq/linux-list-users-command/)