#!/bin/bash

root_dir="$(cd `dirname $0`/.. && pwd -P)"
cache_dir=${CACHE_DIR:-"$root_dir/.cache"}

apt-get update 
apt-get install -y language-pack-zh-hans  build-essential  

# 编译安装新版 7z,系统自带版本太旧,无法处理 exe 文件

p7zip_dir="$cache_dir/p7zip_16.02"
if [ ! -d "$p7zip_dir" ]; then
    p7zip_file="$cache_dir/p7zip_16.02_src_all.tar.bz2"
    wget -O "$p7zip_file" https://downloads.sourceforge.net/p7zip/p7zip_16.02_src_all.tar.bz2
    tar -xf "$p7zip_file" -C "$cache_dir" && rm -rf "$p7zip_file"
fi
cd "$p7zip_dir" && make all3 && make install