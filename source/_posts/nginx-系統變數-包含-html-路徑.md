---
title: nginx 系統變數(包含 html 路徑)
date: 2018-06-04 21:25:10
categories:
    - Nginx
tags:
---

```
$ nginx -V
```

<!--more-->

你會看到以下變數

```
--prefix=/usr/local/Cellar/nginx/1.13.9 
--sbin-path=/usr/local/Cellar/nginx/1.13.9/bin/nginx 
--with-cc-opt='-I/usr/local/opt/pcre/include -I/usr/local/opt/openssl/include' 
--with-ld-opt='-L/usr/local/opt/pcre/lib -L/usr/local/opt/openssl/lib' 
--conf-path=/usr/local/etc/nginx/nginx.conf 
--pid-path=/usr/local/var/run/nginx.pid 
--lock-path=/usr/local/var/run/nginx.lock 
--http-client-body-temp-path=/usr/local/var/run/nginx/client_body_temp --http-proxy-temp-path=/usr/local/var/run/nginx/proxy_temp 
--http-fastcgi-temp-path=/usr/local/var/run/nginx/fastcgi_temp 
--http-uwsgi-temp-path=/usr/local/var/run/nginx/uwsgi_temp 
--http-scgi-temp-path=/usr/local/var/run/nginx/scgi_temp 
--http-log-path=/usr/local/var/log/nginx/access.log 
--error-log-path=/usr/local/var/log/nginx/error.log 
--with-debug 
--with-http_addition_module 
--with-http_auth_request_module 
--with-http_dav_module 
--with-http_degradation_module 
--with-http_flv_module 
--with-http_gunzip_module 
--with-http_gzip_static_module 
--with-http_mp4_module 
--with-http_random_index_module 
--with-http_realip_module 
--with-http_secure_link_module 
--with-http_slice_module 
--with-http_ssl_module 
--with-http_stub_status_module 
--with-http_sub_module 
--with-http_v2_module 
--with-ipv6 
--with-mail 
--with-mail_ssl_module 
--with-pcre 
--with-pcre-jit 
--with-stream 
--with-stream_realip_module 
--with-stream_ssl_module 
--with-stream_ssl_preread_module
```

```
--prefix=/usr/local/Cellar/nginx/1.13.9 
```

這一個就是電腦內 nginx 預設放 html 的位置