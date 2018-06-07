---
title: Angular i18n 多國語系設置
date: 2018-06-06 13:02:48
categories:
    - Angualr
tags:
    - i18n
    - international
    - 多國語系
---

此文章適用於 angualr 6

<!--more-->

## 修改 angular.json

```
{
    ...,
    "projects": {
        "<your-project-name>": {
            ...,
            "architect": {
                "build": {
                    ...,
                    "configurations": {
                        "production": {
                            ...
                        },
                        "production-en": {
                            "fileReplacements": [
                                {
                                    "replace": "src/environments/environment.ts",
                                    "with": "src/environments/environment.prod.ts"
                                }
                            ],
                            "optimization": true,
                            "outputHashing": "all",
                            "sourceMap": false,
                            "extractCss": true,
                            "namedChunks": false,
                            "aot": true,
                            "extractLicenses": true,
                            "vendorChunk": false,
                            "buildOptimizer": true,
                            "outputPath": "dist/en/",
                            "i18nFile": "src/locale/en.xlf",
                            "i18nFormat": "xlf",
                            "i18nLocale": "en",
                            "i18nMissingTranslation": "error"
                            },
                            "en": {
                                "aot": true,
                                "outputPath": "dist/en/",
                                "i18nFile": "src/locale/en.xlf",
                                "i18nFormat": "xlf",
                                "i18nLocale": "en",
                                "i18nMissingTranslation": "error"
                            }
                        }
                    }
                },
                "serve": {
                    ...,
                    "configurations": {
                        "production": {
                            "browserTarget": "<your-project-name>:build:production"
                        },
                        "en": {
                            "browserTarget": "<your-project-name>:build:en"
                        }
                    }
                },
                "extract-i18n": {
                    ...,
                    "options": {
                        "browserTarget": "<your-project-name>:build"
                    }
                },
            }
        }
    }
}
```

在 build 和 serve 下增加語系，會跟使用 angular-cli 指令時相對應。

---

## 在 HTML 指定要翻譯的文字

完整的寫法如下：

```
<h1 i18n="site header|An introduction header for this sample@@introductionHeader">Hello i18n!</h1>
```

| 前為 meaning 大意
| 後為 description 說明
@@ 後為 id

不寫大意：

```
<h1 i18n="An introduction header for this sample@@introductionHeader">Hello i18n!</h1>
```

翻譯文件仍會有說明、id 和原始內容(Hello i18n!) 可供翻譯的參考

你也可以只寫說明或者 id，或者都不寫，看你留多少線索給翻譯作者。

---

## 無法翻譯 HTML tag

```
<div i18n>你好<em>這是我要強調的東西</em></div>
```

改成

```
<div><span i18n>你好<span><em i18n>這是我要強調的東西</em></div>
```

可是，如果是我的 header tag 包著東西，這樣改不會影響我網站的 SEO 嗎？

---

## 產生需要翻譯的文件

PS. 官方文件已經過期了，詳細說明請輸入指令查看

```
$ ng xi18n --help
```

如果只有一個語系要做：

```
$ ng xi18n
```

如果要做多國語系：

```
$ ng xi18n --i18n-locale en --out-file locale/en.xlf && ng xi18n --i18n-locale zh-Hans --out-file locale/zh-Hans.xlf
```

以上指令可以自行增加在 package.json 內的 script 方便作業。

--i18n-locale 為語系的地區標誌， en 為英文，可參照 [Angular 支援語系](https://github.com/angular/angular/tree/master/packages/common/locales) 打開有點久，也可以看 [BCP 47 規範](http://www.rfc-editor.org/rfc/bcp/bcp47.txt#)

--out-file 為產出文件的路徑和檔名的參數，為方便管理，我都產出在 locale 資料夾

---

## 開始翻譯

主要就是修改執行 ng xi18n 產生的 .xlf 檔案

可以使用我自己寫的工具來翻譯，將 angular 產生的 xlf 上傳，就可以看到你下的 i18n 需要翻譯的內容，完成後按下匯出就會下載，再將下載下來的檔案和 angular 專案內的 xlf 替換即可。

持續更新中...

---

## 參考資料

[i18n with Angular 6+](http://www.dzurico.com/i18n-with-angular-6/)

[Angular 官方文件](https://angular.cn/guide/i18n) - **尚未更新**
