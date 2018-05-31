---
title: 部署 nodejs 後端程式 - Vultr 介紹
date: 2018-06-01 00:42:33
categories:
    - Nodejs
tags:
    - Vultr
    - Godaddy
---

我用過的虛擬主機商有 AWS, Google Cloud Platform, 騰訊雲，不過都是用免費的優惠試用一下，用起來都覺得不錯，但是最後都是因為優惠結束，用的又不多，所以就沒有繼續使用了。文章最後再小小抱怨一下。

<!--more-->

---

原本是要使用 Godaddy 的架站主機做就好，可是便宜的主機都只支援 PHP，沒辦法另外安裝其他語言的環境，所以我就去找了其他 VPS (Virturl Private Server - 虛擬私人伺服器）服務，有興趣深入瞭解的人可以 Google VPS 就可以看到許多介紹，如果你的需求是<font color='#d9534f'>希望開發環境不受限制的虛擬主機</font>，s你就可以考慮 VPS。

像是 Godaddy 為什麼架站主機那麼便宜，就是因為他限制你只能使用它規定的工具，像是只有 PHP 可以做開發，但是其實大多數需要的工具他也都包含了，像是：FTP, Mail Server, Wordpress 等工具，如果不是像我一樣挑食的話，那個也就夠了。

---

## Godaddy 和 Vultr 價格上的比較

[GoDaddy Pricing](https://tw.godaddy.com/hosting/vps-hosting?isc=gofhltw01&currencytype=TWD&slid=&pgrid=46463503647&ptaid=kwd-296914754384&mkwid=sU39wqwPM_pcrid_260523076020_pkw_godaddy_pmt_e_pdv_c_&gclid=CjwKCAjwur7YBRA_EiwASXqIHCh9If4ekNGfXnRW9PhyVLOL2UFL1xnM415xMzIlSSAQYFlUqGlW3xoC8OIQAvD_BwE)

![GoDaddy Pricing](/blog/images/godaddy-vps-pricing.png)

[Vultr Pricing](https://www.vultr.com/pricing/)

![Vultr Pricing](/blog/images/vultr-vps-pricing.png)

因為我做出來的網站和 API Server 不需要很大的流量，所以我都是從最低價開始考慮，就這兩家比的話，我最後就選了 Vultr，因為硬體速度方面只參考了記憶體（內容 和 Memory)，容量不需要太多，頻寬其實 Vultr 也已經很夠用了，超過那個額度，硬體也應該先撐不住了。

其實還有許多家，可以 Google VPS 或者虛擬主機商，就有很多選擇。

---

## 最重要的是網速

影響速度的除了硬體之外，還有就是你主機的位置，像是如果在非洲，就 hmmm...，只記得之前打信長連不上時都被嗆：你非洲線喔！

每家主機商都有許多位置可供選擇，一般來說選離自己家最近的就好，像我就選的日本。

---

## 購買 Vultr 主機

Step 1: 選擇國家/地點

![Vultr Deploy Step1](/blog/images/vultr-deploy-step1.png)

你可以先使用 Vultr 提供的下載速度測試服務檢查適合自己的位置：[連結](https://www.vultr.com/faq/#downloadspeedtests)

Step 2: 選擇作業系統

![Vultr Deploy Step2](/blog/images/vultr-deploy-step2.png)

Step 3: 選擇 Server 的配置

![Vultr Deploy Step3](/blog/images/vultr-deploy-step3.png)

Step 4: 選擇額外的需求

從 server 配置後的部分，我都沒有去做勾選，因為我都還用不到，其實之後要加，也是不難的。

最後跳到 Step 7

Step 7: 為自己的機器取個好記的名字

因為他不是希望你只買一台，現在開發大一點的服務，都是需要多台機器去分攤工作，所以做大了之後，多買幾個 VPS 去擴充也是很常見的。

Step 8: Deploy Now

右下角的 Deploy Now 點下去就會開始幫你啟動機器，等一下子就會好了。

---

## 參考資料

[Godaddy](https://tw.godaddy.com/?isc=gofhltw01)

[Vultr](https://www.vultr.com/)

[如何選擇好的主機商](https://www.inside.com.tw/2017/03/17/how-to-picking-the-right-web-hosting)