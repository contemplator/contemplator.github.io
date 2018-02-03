---
title: 'Array 的基礎應用 - map, foreach'
date: 2018-01-30 21:58:39
categories:
    - Rxjs
tags:
---

進入 Rxjs 之前，應該要先對 array 提供的一堆超好用的方法，而且我現在用到的功能，都是在整理後端傳過來的資料，比較少處理動畫，所以建議大家先從簡單的做起，減少用 for loop 的次數

<!--more-->

---

## map

map 在 rxjs 也會很常用到，邏輯也是一樣的，直接看程式碼：

```
export class MapComponent implements OnInit {

  
  originScores = [
    { name: "Leo", score: 25 },
    { name: "May", score: 36 },
    { name: "Sun", score: 16 },
    { name: "Ken", score: 81 }
  ];

  
  fixScores = [];

  
  ngOnInit() {

    
    this.fixScores = this.originScores.map(item => {
      let fixScore = Math.sqrt(item.score) * 10;
      return {
        name: item.name,
        score: fixScore,
        isPass: fixScore >= 60 ? true : false
      };
    });

    
    // 修正後
    // fixScores = [
    //   { name: "Leo", score: 50, isPass: false },
    //   { name: "May", score: 60, isPass: true },
    //   { name: "Sun", score: 40, isPass: false },
    //   { name: "Ken", score: 90, isPass: true }
    // ];
  }
}
```

map 的用途通常是資料需要進行修正，像是幫學生調分數，不過還是用 excel 應該比較快；或者不只是改變資料的數值，而是要變形成另外一個資料型態，像是加上是不是及格的判斷

map 的公式長這樣

```
let newArr = someArr.map((currentValue, index, arr) => {
    return newValue;
});
```

currentValue 就是陣列目前迭代處理的元素
index 他像是 for loop 一樣會提供你目前處理的元素，在原陣列是第幾個位置的資料
arr 原始的完整陣列資料

map 的 callback function 一定要回傳值，因為他要讓陣列經過 map 處理後還是陣列型態

[Source Code](https://github.com/contemplator/rxjs-practice/blob/master/src/app/array/map/map.component.ts)

---

## forEach

forEach 和 map 很像，我一開始知道 forEach 是在 php，他讓我不用在每次都寫 for(let i=0; i<arr.length; i++) 這麼囉唆語句，只要是陣列裡每個東西都要處理，就直接用 foreach 就好

```
export class ForeachComponent implements OnInit {

  
  originScores: any[] = [
    { name: "Leo", score: 25 },
    { name: "May", score: 36 },
    { name: "Sun", score: 16 },
    { name: "Ken", score: 81 }
  ];

  
  fixScore = [];

  
  ngOnInit() {

    
    this.originScores.forEach(item => {
      item.score = Math.sqrt(item.score) * 10;
    });

    
    // 修正後
    // originScores = [
    //   { name: "Leo", score: 50 },
    //   { name: "May", score: 60 },
    //   { name: "Sun", score: 40 },
    //   { name: "Ken", score: 90 }
    // ];
  }
}
```

forEach 和 map 我認為最大的差異就是 map 的 callback function 規定一定要 return 一個值，因為 map 會回傳一個一樣長度的陣列，但是 forEach 則不行在 callbakc function 使用 return。

PS. map 也可以不 return，但是 map 就不會回傳陣列，而是 null 值

forEach 的公式長這樣：

```
someArr.forEach((currentValue, index, arr) => {
    statement...
});
```

[Source Code](https://github.com/contemplator/rxjs-practice/blob/master/src/app/array/foreach/foreach.component.ts)