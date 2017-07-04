---
title: hexo 新增文章並打開
date: 2017-06-28 16:00:40
tags:
    - hexo
    - new
---

最近很愛用 hexo 寫文章，但是用起來一直有個困難，就是每次 hexo new 之後，每次都還要去 source 資料夾裡面找，萬一以後文章很多，不是更難找嗎？所以就想要和 npm script 結合，可以新增後就自動打開。(下次如果還要再打開編輯就另外再說啦~~)

<!--more-->

## 新增 package.json 的 new 指令

```
    "scripts": {
        ...
        "new": "node ./custom-scripts/new.js",
        ...
    },
```

## 編輯 ./custom-scripts/new.js

```
// 引入執行 command line 指令的套件
var cp = require('child_process');

// 取得 file 參數
// 執行 npm run new --file=[filename]
let filename = process.env.npm_config_file;

// 使用 hexo 新建文章
let cmd_new = "hexo new ";
cmd_new += "\"" + filename + "\"";

// 執行 hexo new 指定
let new_process = cp.exec(cmd_new, (error, stdout, stderr) => {
    if (error) {
        console.error(`exec error: ${error}`);
        return;
    }
    
    let cmd = "code ./source/_posts/";
    filename = filename.replace(/\s/g, "-");
    cmd += filename + '.md';

    // 執行使用 vs code 打開文章的指令
    cp.exec(cmd, function (error, stdout, stderr) {
        if (error) console.log(`exec error: ${error}`);
    });
});
```

- 注意，不要把 custom-scripts 改為 scripts，因為 npm 預設 scripts 資料夾是有用途的，若改名為 scripts 你每次在執行 npm scripts 都會有問題。

## 測試

輸入以下指令看看：

```
$ npm run new --file=test
```

我也測試過可以使用中文，並且夾雜空白：

```
$ npm run new --file="可以 夾雜 空白喔"
```

希望對大家有幫助。
