#!/bin/bash -x

#
# 编译 7z, 发行版中的 7z 太旧, 无法正确处理 exe 中的中文路径
#

apt-get update -q
apt install -y language-pack-zh-hans build-essential  

wget -O- https://downloads.sourceforge.net/p7zip/p7zip_16.02_src_all.tar.bz2 | tar xz -C /tmp
(cd /tmp/p7zip_16.02 && make all3 && make install)