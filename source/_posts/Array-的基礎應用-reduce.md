---
title: Array 的基礎應用 - reduce
date: 2018-02-03 12:35:41
categories:
    - Rxjs
tags:
---

第一次聽到 Reduce 是大學上了一堂跟 Hadoop 有關的課程，Hadoop 可以執行分散式運算，是因為它運用了 Map-Reduce 的運算邏輯，Map 是指可以重複執行的任務，而且不管在不同機器上運行的結果都是一致的，像是將調整分數的規則定好，每個老師對同一個分數進行調分，結果都應該要一致，這就是 Map 的規則；而 Recude 有人翻成匯總函數，就是將所有資料統整起來，像是將全班分數進行加總或平均，因為必須取得所有資料後才能動作，這是和 Map 最大的差異。

<!--more-->

---

情境一樣是跟學生分數有關

原始資料為：

```
originScores = [
    { name: "Leo", score: 25 },
    { name: "May", score: 36 },
    { name: "Sun", score: 16 },
    { name: "Ken", score: 81 }
];
```
--- 

## reduce 公式

```
let result = this.someArr.reduce((curResult, curItem, curIndex?, arr?)=>{
    return newCurResult;
}, initValue);
```

* reduce 一樣要回傳一個值，不然計算的結果就無法在程式內取得
* curResult 是指目前彙總的結果
* curItem 是指目前要加入彙總的新資料
* curIndex 目前新資料在原始陣列的序列數，不一定要使用到
* arr 原始陣列，不一定要使用到
* initValue 因為是彙總函式，所以要先給初始值讓彙總函式去比較和加總，像是加總分數也是要從 0 開始加

## 加總

```
countSum(): number{
    let sum = this.originScores.reduce((curSum, curItem)=>{
      return curSum + curItem.score;
    }, 0);
    return sum; // 158
}
```

---

## 平均

```
countAverage(): number{
    let avg = this.originScores.reduce((curAvg, curItem, curIndex, arr)=>{
      return curAvg + ((curItem.score)/(arr.length));
    }, 0);
    return avg; // 39.5
}
```

PS. 這裡的算法不是先求總數在求平均，而是每人的分數先去除以全班人數再加總

---

## 最高分

```
countMax(): {name: string, score: number}{
    let student = this.originScores.reduce((curWinner, curItem)=>{
        if(curItem.score > curWinner.score){
            return curItem;
        }else{
            return curWinner;
        }
    }, this.originScores[0]);

    return student; // {name: "Ken", score: 81}
}
```

PS. 這裡回傳的不是數字，而是全班最高分的學生和他的分數，所以在 initValue 和 reduce 回傳的結果型態要注意！

--- 

## 找出及格的人

```
filtPass(): { name: string, score: number }[] {
    let students = this.originScores.reduce((curArr, curItem) => {
        if (curItem.score >= 60) {
            return [...curArr, curItem];
        } else {
            return curArr;
        }
    }, []);
    return students; // [{name: "Ken", score: 81}]
}
```

[...curArr, curItem] 這個用法是 array.concat 的語法糖的樣子，是將兩個陣列合併，或者將一個新的值塞進陣列中很好用，注意，他會是一個新的陣列

PS. else {return curArr}; 很重要，若是沒有變動陣列，也要將原本的陣列回傳，不然下一次的 curArr 會是 undefined，會噴錯

PS. 如果像是根據資料去篩選，有 array.filter 這樣好用的函數可以用。
