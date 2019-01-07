#!/bin/bash

apt-get update 
apt-get install -y language-pack-zh-hans  build-essential  

cd /tmp
wget -c https://downloads.sourceforge.net/p7zip/p7zip_16.02_src_all.tar.bz2 -O - | tar -xj
cd p7zip_16.02 && make all3 && make install