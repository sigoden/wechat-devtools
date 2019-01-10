#!/bin/bash -x

#
# 编译 7z, 发行版中的 7z 太旧, 无法正确处理 exe 中的中文路径
#

apt-get update -q
apt-get install -y language-pack-zh-hans

p7zip_deb_file=$CACHE_DIR/p7zip_16.02-1_amd64.deb

if [ ! -f "$p7zip_deb_file" ]; then
    apt-get install -y  checkinstall
    wget -O- https://downloads.sourceforge.net/p7zip/p7zip_16.02_src_all.tar.bz2 | tar xj -C /tmp
    (cd /tmp/p7zip_16.02 && make all3 && checkinstall --pkgname=p7zip --backup=no --pkgversion=16.02 --pkgrelease=1 -y)
    cp /tmp/p7zip_16.02/$(basename $p7zip_deb_file) $CACHE_DIR
fi
dpkg -i $p7zip_deb_file