#!/bin/bash

#
# 构建
#

wget_maybe() {
    if [ -z $USE_CACHE ]; then
        wget $1 -O $2
    fi
}

root_dir="$(cd `dirname $0` && pwd -P)"
source "$root_dir/scripts/version.sh"

dist_dir="$root_dir/dist"
rm -rf "$dist_dir" && mkdir -p "$dist_dir"

tmp_dir="/tmp/wx"
mkdir -p "$tmp_dir"

# wechat_devtools.exe
echo "开始下载 wecaht_web_devtools.exe"
exe_file="$tmp_dir/wechat_web_devtools.exe"
wget_maybe 'https://servicewechat.com/wxa-dev-logic/download_redirect?type=x64&from=mpwiki' $exe_file
exe_dir="$tmp_dir/wechat_web_devtools_exe"
app_data_dir='$APPDATA/Tencent/微信web开发者工具/package.nw'
7z x "$exe_file" -scswin -o"$exe_dir" -y $app_data_dir
package_dir="$exe_dir/$app_data_dir"
package_nw_dir="$dist_dir/package.nw"
cp -r "$package_dir" "$dist_dir"

# nwjs
echo "开始下载 nwjs"
nw_file="$tmp_dir/nwjs.tar.gz"
wget_maybe "https://npm.taobao.org/mirrors/nwjs/v$nwjs_v/nwjs-sdk-v$nwjs_v-linux-x64.tar.gz" "$nw_file"
tar -xf "$nw_file" -C "$tmp_dir"
nw_dir="$tmp_dir/nwjs-sdk-v$nwjs_v-linux-x64"
(cd "$nw_dir"/locales && ls -I 'zh*' -I 'en*' | xargs rm)
cp -r "$nw_dir"/* "$dist_dir"

# node
echo "开始下载 node"
node_file="$tmp_dir/nodejs.tar.gz"
wget_maybe "https://nodejs.org/download/release/v$node_v/node-v$node_v-linux-x64.tar.gz" "$node_file"
tar -xf "$node_file" -C "$tmp_dir"
node_dir="$tmp_dir/node-v$node_v-linux-x64"
cp -r "$node_dir" "$dist_dir/node-$node_v"
(cd "$dist_dir" && ln -rfs "node-$node_v/bin/node" node && ln -rfs "node-$node_v/bin/node" node.exe && ln -rfs "node-$node_v/lib/node_modules/npm/bin/npm-cli.js" npm)

# 复制脚本
cp "$root_dir"/scripts/*.sh "$dist_dir"

# 打印版本
echo $version > "$root_dir/version"

# 重新编译 node c/c++ 模块
bash "$dist_dir"/fix.sh