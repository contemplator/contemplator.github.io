---
title: 找到第 n 個符號 - indexOf 延伸應用
date: 2018-10-20 16:21:01
categories:
  - Javascript
tags:
---

我在最近遇到一個很奇怪的問題，現在在傳遞字串訊息時，都會使用 xml 或者 json 格式傳遞，但是到了現在，可能也會遇到只能傳遞極少字符串的情況，這樣就不能使用 json 或 xml 方式傳遞，因為他們會使資料量變大。

所以就會內部規定一些奇怪的格式，像是這樣：$$姓名~性別~生日~帳戶1%%餘額1%%帳戶2%%餘額2~修改日期$$，$$ 代表開始和結束符號，~ 會將不同的第一層資料給隔開，%% 會將第二層資料給隔開。

其中有沒有發現一個奇怪的地方，'帳戶1%%餘額1' 和 '帳戶2%%餘額2' 應該看成兩筆相同格式的資料，這兩筆同樣格式的資料他用 %% 隔開，同一筆資料內，他又用 %% 把不同意義的欄位隔開。（我暈...

<!--more-->

---

### 程式碼

所以我就找了一下有沒有簡單的方法可以處理這個情況，主要解決的方向：我該如何找到第二個 '%%'，然後用類似 split 的方式處理成多筆相同格式的資料，也就是變成陣列。

```
function indexOfAdv(str: string, cha: string, num: number): number {
    let x = 0;
    for (var i = 0; i < num; i++) {
        x = i !== 0 ? str.indexOf(cha, x + cha.length) : str.indexOf(cha);
        if (x === -1) { break; }
    }
    return x;
}

function splitAdv(str: string, cha: string, chaNum: number): string[] {
    const result = [];
    while (indexOfAdv(str, cha, chaNum) > -1) {
        const index = indexOfAdv(str, cha, chaNum);
        const sliceStr = str.slice(0, index);
        result.push(sliceStr);
        str = str.slice(index + cha.length);
    }

    result.push(str);
    return result;
}

let test = "1%%2%%3%%4%%5%%6%%7%%8%%9%%10%%11%%12";
let result = splitAdv(test, '%%', 5);
console.log(result); // [1%%2%%3%%4%%5, 6%%7%%8%%9%%10, 11%%12]
```

indexOfAdv() 是用來找到一段字串內第 n 個符號的位置，勢必要用到 indexOf() 的用法

但是只找到位置還不夠，我們要把一筆很長的 string 變成 array

splitAdv() 是將 indexOfAdv() 用不斷遞迴的方式整理成我們要的陣列結果。

---

### indexOfAdv - 利用 indexOf 和 for 找到第 n 個符號

string.indexOf() 可以找到某個字串或符號的位置，但是如果你要找到第 2 個符號要出現的位置，indexOf() 就必須做兩次，而且還要指定 indexOf() 的起始位置。

第一次就使用

```
str.indexOf(cha)
```

找到符號第 1 次出現的位置

第一次之後，就使用

```
str.indexOf(cha, x + cha.length)
```

找到第 2 個之後的符號出現的位置

合併起來就是這樣:

```
for (var i = 0; i < num; i++) {
  if(i === 0) {
    x = str.indexOf(cha);
  } else {
    x = str.indexOf(cha, x + cha.length);
  }
}
```

PS. 可以再自己修改程式碼變成跟我一樣的一行程式碼，但可能不好閱讀

我額外多做了一次處理是如果符號出現的次數沒有達到第 n 次，就應該回傳 -1，代表沒有找到

```
for(...){
  ...
  if (x === -1) { break; }
}
```

--- 

### splitAdv - 使用 slice 將字串慢慢擷取出到陣列內存放

在只有 indexOfAdv() 的情況下我會這樣做：

取出第一筆資料應該要是

```
let index = indexOfAdv(str, cha, chaNum);
const sliceStr = str.slice(0, index);
result.push(sliceStr);
```

取出第二筆資料應該要是

```
str = str.slice(index + cha.length);
let index = indexOfAdv(str, cha, chaNum);
const sliceStr = str.slice(0, index);
result.push(sliceStr);
```

第三筆...程式碼不斷加長下去...

所以我們應該要使用迴圈的方式處理上面這些問題

首先我們先宣告一個空陣列存放結果

```
const result = [];
```

因為沒辦法確定總共有幾筆資料需要處理，所以無法使用 for loop，所以使用 while loop，跳出的條件就是找不到第 n 個符號了

```
while (indexOfAdv(str, cha, chaNum) > -1) {
  ...
}
```

while loop 裡面就是做前面重複的邏輯

```
while (indexOfAdv(str, cha, chaNum) > -1) {
    const index = indexOfAdv(str, cha, chaNum);
    const sliceStr = str.slice(0, index);
    result.push(sliceStr);
    str = str.slice(index + cha.length);
}
```

最後一步是看我們要不要把多餘的資料也回傳

```
result.push(str);
```