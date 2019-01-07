#!/bin/bash

#
# 启动 docker 版微信开发者工具
#

name=wechat-devtools
cid=$(docker ps -q -f status=running -f name=^/${name}$)
if [ "$cid" ]; then
    docker rm -f $cid
fi

docker run  \
    --name $name \
    -d \
    --privileged \
    -e DISPLAY \
    $( test -e $HOME/weapp && echo "-v $HOME/weapp:/home/node/weapp" ) \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "$HOME/.config/微信web开发者工具:/home/node/.config/微信web开发者工具" \
    sigoden/wechat-devtools