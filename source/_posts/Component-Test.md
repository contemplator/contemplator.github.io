---
title: Component Test
date: 2017-06-21 11:16:56
categories: 
    - Angular
---

angular 最重要的就是 component，而我本身也不是很清楚 angular 是怎麼把 多個 component 編譯成一頁式的網頁，所以如何建立測試環境我就不會了，幸好
 angular 也提供測試 component 的教學。

<!--more-->

---

上一篇 Karma Test 所備份起來的 app.component.spec.ts 可以再把他打開來，裡面的時候應該還蠻乾淨的，內容如下：

```
import { TestBed, async } from '@angular/core/testing';

import { AppComponent } from './app.component';

describe('AppComponent', () => {
    beforeEach(async(() => {
        TestBed.configureTestingModule({
            declarations: [
                AppComponent
            ]
        }).compileComponents();
    }));

    it('should create the app', async(() => {
        const fixture = TestBed.createComponent(AppComponent);
        const app = fixture.debugElement.componentInstance;
        expect(app).toBeTruthy();
    }));
});
```

儲存後執行 
```
$ npm test
```

就可以看到瀏覽器有一個 AppComponent 的測試包，下面有一個執行的測試，名為 should create the app

代表 component 已經被成功建立起來。
(照理說要應該測試到有錯誤情況並解決，但我這邊不理解，先跳過)

---

## TestBed

用來產生測試用的 module。在 beforeEach 設定好 module，所以有需要的依賴套件，也要在 beforeEach 加入

---

## TestBed.configureTestingModule

要注意是不是把 html 寫在另外一個檔案，如果是的話，要記得使用異步任務 (async) 建立

---

## Test.createcomponent

會產生一個測試用的 component 實體，大多命名為 fixture，可以透過 fixture.componentInstance 取得你所編輯的 component，可以取得屬性及函式。

---

## componentInstance

- private vs. public

如果你設為 private，test 裡面要取得時就會跳出錯誤，因為這裡會使用 new 的方式產生 component。

順帶一提，也有人說如果設為 private，在一些 lint 檢查時，會認為 html 會無法取用到，編譯時會產生錯誤。

---

## debugElement

掌管所有 DOM 的所有元素

---

## query

使用 css 的選擇器 (selector) 選擇到想要的元素，例如使用 tag、id、class 或者其他的 attribute

- queryAll 會回傳一個陣列

---

## nativeElement

在 angular 要取得元素內的 value 或其他屬性時要先取得的物件

---

## fixture.detectChanges()

TestBed.createComponent 不會觸發修改，還有在 test 直接修改 component 的屬性，不觸發 detectChanges() 是不會修改到 DOM 上面，所以可能會得到不如預期的結果

- ComponentFixtureAutoDetect

如果很頻繁的更改，可以使用自動偵測修改，import 之後在 configureTestingModule 內增加到 providers

```
import { ComponentFixtureAutoDetect } from '@angular/core/testing';
...
TestBed.configureTestingModule({
  declarations: [ BannerComponent ],
  providers: [
    { provide: ComponentFixtureAutoDetect, useValue: true }
  ]
})
```