---
title: Vue - i18n with Vite
date: 2022-04-14 12:16:34
categories:
  - Vue
  - Vite
tags:
  - i18n
---

# 套件安裝

官方介紹

[Installation | Vue I18n (kazupon.github.io)](https://kazupon.github.io/vue-i18n/installation.html)

但是裡面都是使用 Vue Cli 的說明

使用 Vite 當作打包工具的話要看這篇

[@intlify/vite-plugin-vue-i18n - npm (npmjs.com)](https://www.npmjs.com/package/@intlify/vite-plugin-vue-i18n)

<!-- more -->

### 問題排解

如果執行 `$ npm i --save-dev @intlify/vite-plugin-vue-i18n` 遇到錯誤，可能是因為 `npm install vue-i18n@9` 的版本問題，注意 vue-i18n@ 後面跟著的版本號

# 程式內的設定

這邊只示範一種最簡單的作法

## vite.config.ts

在 plugins 加上 i18n 的外掛

```jsx
import vueI18n from '@intlify/vite-plugin-vue-i18n'
import path from 'path'
...

export default defineConfig({
  plugins: [
    vue(),
    vueI18n({
      // if you want to use Vue I18n Legacy API, you need to set `compositionOnly: false`
      // compositionOnly: false,

      // you need to set i18n resource including paths !
      include: path.resolve(__dirname, './src/locales/**'),
      compositionOnly: true,
    }),
  ],
	...
});
```

## main.ts

在 root 設置 i18n 初始設定和模式

```jsx
...
import { createI18n } from 'vue-i18n'
...
import en from "./locales/en.json";
import zhTW from "./locales/zh-TW.json";

const app = createApp(App);

// 設置 i18n
let defaultLocale = 'zh-TW';
if(navigator.languages !== undefined && navigator.languages[0]){
  defaultLocale = navigator.languages[0];
}
const i18n = createI18n({
  legacy: false,
  locale: defaultLocale,
  fallbackLocale: 'zh-TW',
  messages: {
    'zh-TW': zhTW,
    en
  }
});
app.use(i18n)

app.mount("#app");
```

透過下方的邏輯取得使用者瀏覽器的預設語言

如果沒有，就使用 zh-TW (繁體中文 - 台灣)

```jsx
let defaultLocale = 'zh-TW';
if(navigator.languages !== undefined && navigator.languages[0]){
  defaultLocale = navigator.languages[0];
}

```

legacy: false

不使用 legacy API

legacy API 可以參考 [Legacy API | Vue I18n (intlify.dev)](https://vue-i18n.intlify.dev/api/legacy.html)

locale: defaultLocale

指定現在這個 app 使用的語言，defaultLocale 可以直接替換成 `"en"` 或者 `"zh-TW"` 測試

fallbackLocale: 'zh-TW'

當 locale 未指定就會使用 zh-TW

messages

直接載入翻譯好的翻譯文件

## Component.vue

示範 SFC 和 Composition API 的寫法

```jsx
<script setup>
import { useI18n } from "vue-i18n";

const { locale, t } = useI18n({
  inheritLocale: true,
});
</script>

<template>
  <form>
    <label>{{ t('language') }}</label>
    <select v-model="locale">
      <option value="en">en</option>
      <option value="ja">ja</option>
    </select>
  </form>
  <p>{{ t('hello') }}</p>
</template>

```

注意要在 /src/locales/zh-TW.json 和 /src/locales/en.json 寫到以下內容

```jsx
{
  "language": "語言",
	"hello": "你好"
}
```

或者可以參考官方的做法：

```jsx
<template>
  <form>
    <label>{{ t('language') }}</label>
    <select v-model="locale">
      <option value="en">en</option>
      <option value="ja">ja</option>
    </select>
  </form>
  <p>{{ t('hello') }}</p>
</template>

<script>
import { useI18n } from 'vue-i18n'

export default {
  name: 'App',
  setup() {
    const { locale, t } = useI18n({
      inheritLocale: true
    })

    return { locale, t }
  }
}
</script>

<i18n>
{
  "en": {
    "language": "Language",
    "hello": "hello, world!"
  },
  "zh-TW": {
    "language": "語言",
    "hello": "你好！"
  }
}
</i18n>
```

`<i18n>` 是可以在各自的 vue 檔案內新增和設置的內容，但建議都用了 i18n，為求翻譯內容都整理在一起維護比較容易，建議就都整理到 /src/locales/ 下吧。