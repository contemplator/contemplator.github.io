---
title: Dependency Service Test
date: 2017-06-21 14:56:16
tags:
    - test
    - angular
---

在開發 angular 的時候，如果使用到資料，很常會依賴 service 來傳遞資料。

<!--more-->

在測試時，不建議使用真正的 service ?

```
TestBed.configureTestingModule({
   declarations: [ WelcomeComponent ],
// providers:    [ UserService ]  // NO! Don't provide the real service!
                                  // Provide a test-double instead
   providers:    [ {provide: UserService, useValue: userServiceStub } ]
});
```

userServiceStub 就是測試替身
