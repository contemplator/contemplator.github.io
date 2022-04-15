---
title: Vue - Tutorial 筆記
date: 2022-04-15 16:09:41
categories:
  - Vue
tags:
---

Composition API

[【前端新手日記】Vue.js學習筆記(6)-Vue2的Option API和Vue3的Composition API @ 文科少女寫程式 :: 痞客邦 :: (pixnet.net)](https://pinkymini.pixnet.net/blog/post/35630359-%E3%80%90%E5%89%8D%E7%AB%AF%E6%96%B0%E6%89%8B%E6%97%A5%E8%A8%98%E3%80%91vue.js%E5%AD%B8%E7%BF%92%E7%AD%86%E8%A8%98%286%29-vue2%E7%9A%84option-)

Options API 是 Vue2 及之前的版本用的寫法

Composition API 的好處是不再需要把資料和方法拆到各個地方

[3-2 Vue SFC 單一元件檔 | 重新認識 Vue.js | Kuro Hsu](https://book.vue.tw/CH3/3-2-vue-sfc.html)

使用 SFC 可能會有問題，所以一開始還是先不使用 SFC 寫法，但其實只是 html 和 css 要不要寫在一起的問題而已。

另外 SFC 有個好處就是不用寫 setup() 和執行 mount()

<!-- more -->

如果使用像是 primeflex 或者 tailwind.css，可以減少很多 css 的程式碼。

至於 ts 只要使用 composition API，ts 檔案間的互相關聯支援性會更好。

## reactive 和 ref

```jsx
const counter = reactive({ count: 0 })
const message = ref('Hello World!')
```

reactive 包的是 object (by reference)

ref 包的是簡單型態 (by value)

## ****Attribute Bindings****

```jsx
<script setup>
import { ref } from 'vue'

const titleClass = ref('title')
</script>

<template>
  <h1 :class="titleClass">Make me red</h1>
</template>

<style>
.title {
  color: red;
}
</style>
```

:class 等於是 v-bind:class 的寫法

## ****Event Listeners****

```jsx
<script setup>
import { ref } from 'vue'

const count = ref(0)

function increment() {
  count.value++
}
</script>

<template>
  <button @click="increment">count is: {{ count }}</button>
</template>
```

`v-on:click="increment"` 等於是 `@click="increment"`

問題：如果 function 要傳入參數怎麼處理？

## ****Form Bindings****

單向綁定

```jsx
<template>
  <input :value="text" @input="onInput" placeholder="Type here">
  <p>{{ text }}</p>
</template>
```

雙向綁定

```jsx
<template>
  <input v-model="text" placeholder="Type here">
  <p>{{ text }}</p>
</template>
```

## ****Conditional Rendering****

```jsx
<template>
  <button @click="toggle">toggle</button>
  <h1 v-if="awesome">Vue is awesome!</h1>
  <h1 v-else>Oh no 😢</h1>
</template>
```

## ****List Rendering****

```jsx
<template>
  <ul>
    <li v-for="todo in todos" :key="todo.id">
      {{ todo.text }}
      <button @click="removeTodo(todo)">X</button>
    </li>
  </ul>
</template>
```

## ****Lifecycle and Template Refs****

lifecycle: onMounted 等同於 app 已經建立完成的階段

```jsx
<script setup>
import { ref, onMounted } from 'vue'

const p = ref(null)

onMounted(() => {
  p.value.textContent = 'mounted!'
})
</script>
<template>
  <p ref="p">hello</p>
</template>
```

```jsx
<script type="module">
import { createApp, ref, onMounted } from 'vue'

createApp({
  setup() {
    const p = ref(null)

    onMounted(() => {
      p.value.textContent = 'mounted!'
    })

    return {
      p
    }
  }
}).mount('#app')
</script>
```

[Lifecycle Hooks | Vue.js (vuejs.org)](https://vuejs.org/guide/essentials/lifecycle.html#lifecycle-diagram)

template ref

注意是在 p 使用，而且指定的值是用 p.value.textContent = 'mounted!'

代表 ref 是指 html ElementRef 等於 angular 的 ViewChild 指定到的 ElementRef

## ****Watchers****

```jsx
<script setup>
import { ref, watch } from 'vue'

const todoId = ref(1)
const todoData = ref(null)

async function fetchData() {
  todoData.value = null
  const res = await fetch(
    `https://jsonplaceholder.typicode.com/todos/${todoId.value}`
  )
  todoData.value = await res.json()
}

fetchData()

watch(todoId, fetchData)
</script>

<template>
  <p>Todo id: {{ todoId }}</p>
  <button @click="todoId++">Fetch next todo</button>
  <p v-if="!todoData">Loading...</p>
  <pre v-else>{{ todoData }}</pre>
</template>
```

不使用 watch 的話，不斷修改 todoId，都不會重新觸發 fetchData

## ****Components****

```jsx
<script setup>
import ChildComp from './ChildComp.vue'
</script>

<template>
  <ChildComp />
</template>
```

## ****Components - Props 輸入的參數****

```jsx
// parent component
<script setup>
import { ref } from 'vue'
import ChildComp from './ChildComp.vue'

const greeting = ref('Hello from parent')
</script>

<template>
  <ChildComp :msg="greeting" />
</template>

// child component
<script setup>
const props = defineProps({
  msg: String
})
</script>

<template>
  <h2>{{ msg || 'No props passed yet' }}</h2>
</template>
```

## Components - ****Emits 輸出的動作****

```jsx
// parent component
<template>
  <ChildComp @response="(msg) => childMsg = msg" />
  <p>{{ childMsg }}</p>
</template>

// child component
<script setup>
const emit = defineEmits(['response'])
emit('response', 'hello from child')
</script>
```

## Components - Slots 從 parent component 插入 html 到 child component

```jsx
// parent 
<script setup>
import { ref } from 'vue'
import ChildComp from './ChildComp.vue'

const msg = ref('from parent')
</script>

<template>
  <ChildComp>Message: {{ msg }}</ChildComp>
</template>

// child
<template>
  <slot>Fallback content</slot>
</template>
```
