#!/bin/bash

apt-get update 
apt-get install -y language-pack-zh-hans  build-essential  

# 编译安装新版 7z,系统自带版本太旧,无法处理 exe 文件
cd /tmp 
wget -c https://downloads.sourceforge.net/p7zip/p7zip_16.02_src_all.tar.bz2 -O - | tar -xj
cd p7zip_16.02 && make all3 && make install