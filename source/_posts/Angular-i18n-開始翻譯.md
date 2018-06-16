---
title: Angular i18n 開始翻譯
date: 2018-06-08 17:22:58
categories:
    - Angular
tags:
    - i18n
    - internationalization
    - 多國語系
    - xlf
---

主要是使用了我自己寫一個網頁進行翻譯，但是現在沒有自動翻譯的功能，希望日後有時間補上。

如果要翻譯多國語系，並且要在本地端運行個語系的結果、要編譯成多國語系，請先查看前一篇的 [Angular i18n 多國語系設置](https://contemplator.github.io/blog/2018/06/06/Angular-i18n-%E5%A4%9A%E5%9C%8B%E8%AA%9E%E7%B3%BB/)。

<!--more-->

---

## 產生翻譯檔 .xlf

在 Angular 專案的路徑下執行以下指令 (PS. 就是執行 npm start 或 ng serve 的路徑下)

```
$ ng xi18n --i18n-locale en --out-file locale/en.xlf
```

然後等一段時間後，angular 就會幫你產生 ./src/locale/en.xlf 這樣一個檔案

## .xlf 檔案說明

en.xlf 部分內容

```
<?xml version="1.0" encoding="UTF-8" ?>
<xliff version="1.2" xmlns="urn:oasis:names:tc:xliff:document:1.2">
  <file source-language="en" datatype="plaintext" original="ng2.template">
    <body>
      <trans-unit id="productFeature" datatype="html">
        <source>產品特色</source>
        <context-group purpose="location">
          <context context-type="sourcefile">app/app.component.ts</context>
          <context context-type="linenumber">16</context>
        </context-group>
        <note priority="1" from="description">產品特色字樣</note>
        <note priority="1" from="meaning">產品特色</note>
      </trans-unit>
      ...
```

就對應到 ./src/app/app.component.html 第 16 行的內容，如下：

```
<a href="#features" class="nav-link" i18n="產品特色|產品特色字樣@@productFeature">產品特色</a>
```

&lt;trans-unit&gt; 就代表一個需要翻譯的 html element

&lt;source&gt; 就是原始內容，像是現在，我就是要把產品特色翻譯成英文

&lt;context-group purpose="location"&gt; 說明內容是在哪裡出現的

&lt;note priority="1" from="description"&gt; 就是翻譯作者可以參考的說明，比對到 html i81n 屬性的寫法，就是在 @@ 前，| 後的內容

&lt;note priority="1" from="meaning"&gt; 除了 description 之外，還可以另外有 meaning 給作者當作參考，一般是不寫沒關係

翻譯作者就是參考以上資料，然後翻譯出正確的文字和語意

翻譯後的結果，就是在 &lt;trans-unit&gt; 增加一個 &lt;target&gt;，target 就是翻譯的結果，結果應該要如下：

```
<trans-unit id="productFeature" datatype="html">
    <source>產品特色</source>
    <target>Product Feature</target>
    <context-group purpose="location">
        <context context-type="sourcefile">app/app.component.ts</context>
        <context context-type="linenumber">16</context>
    </context-group>
    <note priority="1" from="description">產品特色字樣</note>
    <note priority="1" from="meaning">產品特色</note>
</trans-unit>
```

---

## 使用 transalte tool  

連到 http://www.idlefox.info/translate-tool/

### 選擇檔案

![選擇檔案xlf](/blog/images/choose-xlf.png)

### 匯入結果

![xls匯入結果](/blog/images/xlf-import-result.png)

### 開始翻譯

![開始翻譯](/blog/images/translate-xlf.png)

如果有沒翻譯的部分，最後結果都會是 undefined

### 匯出

點下匯出按鈕，就會自動下載剛剛你所做的翻譯結果。

---

## 替換掉 Angualr 的翻譯語系檔

將剛剛下載的檔案做更名，我先換成 en.xlf，主要是因為我的 angular.json 已經設定，如果要在 ng serve 指定語系為 en，我的翻譯檔名就要叫做 en.xlf。

---

## 測試

之後執行以下的 angular 指令，就可以在本地端看到結果

```
$ ng serve --configuration=en
```

## 編譯正式檔案

```
$ ng build --base-href=./ --configuration=en
```

在測試和編譯正式檔案都是參照你的 angular.json 設定的，所以如果有問題，請回去察看設定。

