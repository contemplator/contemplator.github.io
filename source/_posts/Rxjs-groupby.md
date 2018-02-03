---
title: Rxjs - groupby
date: 2018-02-03 13:50:19
categories:
    - Rxjs
tags:
---

groupby 是指將資料依照部分相同，而將相同資料組成一個群集。

一開始會找 javascript 的 groupby 用法是因為 groupby 自己寫很麻煩，原本是想要在 SQL 的階段就使用 groupby 處理，可是 mssql 的groupby 我覺得相當難用，後來看到 rxjs 才是我理想的 groupby 方式，就做個筆記吧，因為也是蠻複雜的...。

<!--more-->

---

## 原始資料

```
originalData = [
    { name: 'Aaron', score: 45 },
    { name: 'Abbott', score: 23 },
    { name: 'Bowen', score: 36 },
    { name: 'Boyce', score: 67 },
    { name: 'Don', score: 73 },
    { name: 'Dominic', score: 26 },
    { name: 'Gene', score: 84 },
    { name: 'Gavin', score: 95 },
    { name: 'Isaac', score: 18 },
    { name: 'Ivan', score: 51 },
    { name: 'Larry', score: 28 },
    { name: 'King', score: 53 }
];
```

---

## 情境

想要將以上 12 名學生的成績分區間

低於 40 分為 low 

高於等於 40 分，低於 70 為 middle

高於等於 70 分為 high

---

## Version 1 - groupBy()

```
Observable.from(this.originalData)
    .map(item=>{
        return {name: item.name, score: item.score, level: this.classify(item.score)};
    })
    .groupBy(item => {
        return item.level;
    })
    .subscribe(res=>{
        console.log(res);
    });
```

在 console 可以看到會有三筆資料被 log 出來，也可以看到的確是用 3 個定義好的區間，但是其他資料看起來並不是那麼好閱讀，像是我想要知道哪些人在哪個區間就無法看出來

![Groupby Version1](/blog/images/Groupby Version1.png)

---

## Version 2 - mergeMap() + toArray()

增加 mergeMap

```
Observable.from(this.originalData)
    .map(item=>{
        return {name: item.name, score: item.score, level: this.classify(item.score)};
    })
    .groupBy(item => {
        return item.level;
    })
    .mergeMap(group=>{
        return group.toArray();
    })
    .subscribe(res=>{
        console.log(res);
    });
```

![Groupby Version2](/blog/images/Groupby Version2.png)

mergeMap 是增加的過程，簡單說就是把 GroupedObservable 內實際的資料變成 array 讓我們好閱讀。

PS. toArray 也是 rxjs 提供的函數，你也可以使用 reduce 來完成

## Version 2 - mergeMap() + reduce()

```
Observable.from(this.originalData)
    .map(item=>{
        return {name: item.name, score: item.score, level: this.classify(item.score)};
    })
    .groupBy(item => {
        return item.level;
    })
    .mergeMap(group=>{
        return group.reduce((pre, curr) => [...pre, curr], []);
    })
    .subscribe(res=>{
        console.log(res);
    });
```

PS. () => {statement} 是 arrow function 寫法，有興趣的人可以找找這方面的資料，推薦

但是 console 看到的資料還有個問題，就是我不知道我 groupby 的根據是什麼，我得到的是分類好的資料，但是我要知道哪些是哪個群集，要每一個群集抽一個資料出來看才知道

--- 

## Version 3 - zip()

在 mergeMap 使用 zip

```
Observable.from(this.originalData)
    .map(item=>{
        return {name: item.name, score: item.score, level: this.classify(item.score)};
    })
    .groupBy(item => {
        return item.level;
    })
    .mergeMap(group=>{
        return group.toArray().zip(Observable.from(group));
    })
    .subscribe(res=>{
        console.log(res);
    });
```

![Groupby Version3](/blog/images/Groupby Version3.png)

上面提到，groupby 之後的資料是 GroupedObservable，一樣是 Observable 的一種，如果要將實際的資料取出來，最簡單的方式就是使用 Observable.from()，使用 zip() 之後你會發現，原本是只有被 groupby 的一維陣列，變成二維陣列，除了在這區間的學生資料外，還有一個是某個學生的資料，但這樣好像跟 Version 2 差不多。

---

## Version 4 - zip() + map()

再 map 一次，**Observable.from().map()**

```
Observable.from(this.originalData)
    .map(item=>{
        return {name: item.name, score: item.score, level: this.classify(item.score)};
    })
    .groupBy(item => {
        return item.level;
    })
    .mergeMap(group=>{
        return group.toArray().zip(Observable.from(group).map(item => item.level));
    })
    .subscribe(res=>{
        console.log(res);
    });
```

![Groupby Version4](/blog/images/Groupby Version4.png)

就這樣告一段落吧！

[Source Code](https://github.com/contemplator/rxjs-practice/blob/master/src/app/rxjs/groupby/groupby.component.ts)