---
title: Firebase Query in Angular
date: 2018-03-19 11:54:31
categories:
    - Firebase
tags:
    - Angular
    - Ionic
---

最近在試著用 ionic 3 寫 Mobile App，因為還是要有資料庫，所以就決定使用 Firebase 當作資料庫，因為是 NoSql 不像是之前操作 MySql，所以作法搞了很久才搞懂。

<!--more-->

---

## 事前準備

因為 angular service 的機制，所以在 app.module 去初始化你的 firebaseApp，並且加到 provides 就可以在專案所有地方使用

```
import { AngularFireDatabaseModule, AngularFireDatabase } from 'angularfire2/database';
import { AngularFireAuthModule } from 'angularfire2/auth';
...

const firebaseConfig = {
  apiKey: "...",
  authDomain: "...",
  databaseURL: "...",
  projectId: "...",
  storageBucket: "...",
  messagingSenderId: "..."
};

...
@NgModule({
  ...
  imports: [
    ...
    AngularFireModule.initializeApp(firebaseConfig),
    AngularFireDatabaseModule,
    AngularFireAuthModule
  ],
  providers: [
    ...
    AngularFireDatabase
  ]
  ...
```

![firebase app config](/blog/images/firebase app config.png)
可以到 firebase 指定的專案看 project overview，選擇右邊畫面的"新增其他應用程式"，選擇自己的開發環境就會顯示你 firebase 的 config 資料

---

## valueChanges()

```
import { AngularFireDatabase } from 'angularfire2/database';
...

export class ChartPage implements OnInit {
  constructor(
    private db: AngularFireDatabase
  ) { 
    db.list('record').valueChanges().subscribe(res=>{
      console.log(res);
    });
  }
}
```

valueChanges() 比較簡單理解，因為 firebase 的 database 是 realtime database，根據我自己的理解，他是即時儲存和改變的，像是如果同樣一個 db 有其他裝置儲存資料，其實這一個 ChartPage 這邊的 valueChanges() 也會在被觸發一次，因為 db 裡面的資料改變了，可以不經過麻煩的處理，也可以做到像是聊天的功能。

此外，因為是在 angular 做，在處理資料和異步任務，經常使用 rxjs 的 observable ，所以要接著使用 subscribe (訂閱) 才會真的觸發和取得資料。
res 就是取得的資料

---

## snapshotChanges()

```
import { AngularFireDatabase } from 'angularfire2/database';
...

export class ChartPage implements OnInit {
  constructor(
    private db: AngularFireDatabase
  ) { 
    db.list('record').snapshotChanges().subscribe(res=>{
      this.records = res.map(item => {
        let data = item.payload.val();
        data.key = item.key;
        return data;
      });
    });
  }
}
```

snapshotChanges() 可以把它想成 valueChanges() 的進階版，因為我是實作到一個功能時才知道要用這一個，valueChanges() 是單純取得資料，可是把資料都倒出來看，會發現他沒有給你 firebase 每筆資料都會有的 key。如果我要修改過去資料，就必須要有 key。

snapshotChanges() 的 res 會帶有 key，還有帶有資料的 payload，這裡我用 Array.map() 整理成自己想要的資料

---

## query with ref()

```
import { AngularFireDatabase } from 'angularfire2/database';
...

export class ChartPage implements OnInit {
  constructor(
    private db: AngularFireDatabase
  ) { 
    let records = this.db.database.ref('record');
    records.orderByChild('datetime').startAt(startDate).endAt(endDate).on('value', (dataSnapshot)=>{
      let data = dataSnapshot.toJSON();
      let arr = [];
      for(let key of Object.keys(data)){
        arr.push(data[key]);
      }
    });
  }
}
```

valueChanges() 和 snapshotChanges() 都是將 db 所有資料取出來，如果我想要讓 firebase 幫我做有條件的篩選，用這兩者的方式就不行，所以就要找出類似執行 sql 的方式。

this.db.database.ref('collection') 類似我要查詢哪一張資料表，在 nosql 通常是在 collection

.orderByChild('property') 我的理解和之前 mysql 會接在 select 最後的 orderBy 意思不一樣，他不是排序的意思，我覺得比較像是 where column = 'something' 的 column，後面的 equalTo() 或 startAt() 都是根據 orderByChild('property') 裡面寫的資料屬性(property) 去比較。

startAt() 和 endAt() 就像是 between 得用法，當然可以單獨使用，就會像是 >= 或者 <=，因為我是要找出一段時間內的資料，所以才這樣用

後面的處理是因為 .ref() 的查詢出來的結果，不管是經過 .toJson() 還是 .val() 的方式，他仍是 JSON Obejct 的結果，不是 Array，所以不好使用，所以我又再額外處理

---

## 比較 valueChanges() 和 ref() 的 query

我是使用 console.time() 和 console.timeEnd() 的方式比較這兩種方式回傳時間的差異，經過實測，就是 ref() 的查詢都是比較快的，儘管我的查詢是所有資料取出來，ref() 一樣比較快，代表如果不需要即時的效果，建議都是使用 ref() 的查詢。

![valueChanges 和 ref 的查詢比較](/blog/images/valueChanges 和 ref 的查詢比較.png)