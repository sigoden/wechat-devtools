#!/bin/bash

name=wechat-devtools
cid=$(docker ps -qa -f name=^/${name}$)
if [ "$cid" ]; then
    docker rm -f $cid
fi

docker run  \
    -it \
    --name $name \
    --workdir /home/node \
    --user node \
    -e DISPLAY \
    -e LANG=C.UTF-8 \
    $( test -e $HOME/weapp && echo "-v $HOME/weapp:/home/node/weapp" ) \
    -v $HOME/.config/微信web开发者工具:/home/node/.config/微信web开发者工具 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    sigoden/wechat-devtools \
    /bin/bash