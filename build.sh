#!/bin/bash

#
# 构建
#

root_dir="$(cd `dirname $0` && pwd -P)"
cache_dir=${CACHE_DIR:-"$root_dir/.cache"}

source "$root_dir/scripts/version.sh"

dist_dir="$root_dir/dist"
rm -rf "$dist_dir" && mkdir -p "$dist_dir"

mkdir -p "$cache_dir"

# wechat_devtools.exe
app_data_dir='$APPDATA/Tencent/微信web开发者工具/package.nw'
exe_dir="$cache_dir/wechat_web_devtools_${version}_exe"
package_dir="$exe_dir/$app_data_dir"
if [ -d "$exe_dir" ]; then
    echo "从缓存获取微信Web开发者工具"
else
    echo "开始下载微信Web开发者工具"
    exe_file="$cache_dir/wechat_web_devtools_$version.exe"
    wget -O $exe_file 'https://servicewechat.com/wxa-dev-logic/download_redirect?type=x64&from=mpwiki'
    7z x "$exe_file" -scswin -o"$exe_dir" -y $app_data_dir
fi
cp -r "$package_dir" "$dist_dir"

# nwjs
nw_dir="$cache_dir/nwjs-sdk-v$nwjs_v-linux-x64"
if [ -d "$nw_dir" ]; then
    echo "从缓存获取nwjs"
else
    echo "开始下载nwjs"
    nw_file="$cache_dir/nwjs_$nwjs_v.tar.gz"
    wget -O "$nw_file" "https://npm.taobao.org/mirrors/nwjs/v$nwjs_v/nwjs-sdk-v$nwjs_v-linux-x64.tar.gz" 
    tar -xf "$nw_file" -C "$cache_dir"
    (cd "$nw_dir"/locales && ls -I 'zh*' -I 'en*' | xargs rm)
fi
cp -r "$nw_dir"/* "$dist_dir"

# node
node_dir="$cache_dir/node-v$node_v-linux-x64"
if [ -d "$node_dir" ]; then
    echo "从缓存获取node"
else
    echo "开始下载node"
    node_file="$cache_dir/nodejs.tar.gz"
    wget -O "$node_file" "https://nodejs.org/download/release/v$node_v/node-v$node_v-linux-x64.tar.gz" 
    tar -xf "$node_file" -C "$cache_dir"
fi
cp -r "$node_dir" "$dist_dir/node-$node_v"
(cd "$dist_dir" && ln -rfs "node-$node_v/bin/node" node && ln -rfs "node-$node_v/bin/node" node.exe && ln -rfs "node-$node_v/lib/node_modules/npm/bin/npm-cli.js" npm)
export npm_config_cache="$cache_dir/.npm"

# 复制脚本
cp "$root_dir"/scripts/*.sh "$dist_dir"

# 重新编译 node c/c++ 模块
bash "$dist_dir"/rebuild-native-modules.sh

# 打印版本
echo $version > "$root_dir/version"