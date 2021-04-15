#!/bin/bash

# 壓縮資料夾

tar zcvf blog.tar.gz ./public

# 複製到 server 上

scp -r ./blog.tar.gz root@202.182.97.161:/var/www/blog.tar.gz

echo "copy files done"

# 解壓縮

ssh -tt root@202.182.97.161 "tar zxvf /var/www/blog.tar.gz"

# 刪除 server 檔案

ssh -tt root@202.182.97.161 "rm -r /var/www/html/blog"

echo "remove old files done"

# 搬移到 tomcat 內

ssh -tt root@202.182.97.161 "mv /var/www/public/ /var/www/html/blog"

echo "move files done"

# 刪除本地的壓縮檔案

rm ./blog.tar.gz

# 刪除遠端的壓縮檔案

ssh -tt root@202.182.97.161 "rm /var/www/blog.tar.gz"
ssh -tt root@202.182.97.161 "rm -r /var/www/public"
