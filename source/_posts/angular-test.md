---
title: 'Angular Test'
date: 2017-06-19 15:35:31
categories: 
    - Angular
tags:
    - Test
---

angular 在一開始初始化專案的時候，就會發現 package.json 裡面有很多測試的第三方套件，如 karma、jasmine 等，在看官方文件的時候，就大概有說是要因應不同情況的測試，像是點對點、單元測試等，接下來幾天我會花時間研究怎麼寫測試，不過主要還是想要研究單元測試就好 XD。

<!--more-->

---

## 套件及用途

| 套件                      | 用途                                                |
|---------------------------|----------------------------------------------------|
| Jasmine                   | 適用於基本的測試，主要測試 html 在瀏覽器上執行的結果。  |
| Angular testing utilities | 在 angular 的環境下的測試。                          |
| Karma                     | 在開發時期所應該寫的單元測試。                        |
| Protractor                | 點對點的測試。就是關於使用者互動的測試。               |

隔離單元測試(Unit Test) 和 測試實用程序(Test Utilities)
- 前者可單獨測試，後者要測試使用者和產品的互動關係
- Angular 的 通道(Pipes) 和 服務(Services) 應該要寫單元測試
- Component 應該寫測試實用程序