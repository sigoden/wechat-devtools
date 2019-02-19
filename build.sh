#!/bin/bash -e

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
exe_file="$cache_dir/wechat_web_devtools_$version.exe"
app_data_dir='$APPDATA/Tencent/微信web开发者工具/package.nw'
exe_dir="$cache_dir/wechat_web_devtools_${version}_exe"
package_dir="$exe_dir/$app_data_dir"
if [ -f "$exe_file" ]; then
    echo "从缓存获取微信Web开发者工具"
else
    echo "开始下载微信Web开发者工具"
    wget -O $exe_file 'https://servicewechat.com/wxa-dev-logic/download_redirect?type=x64&from=mpwiki'
fi
7z x "$exe_file" -scswin -o"$exe_dir" -y $app_data_dir
mv -f "$package_dir" "$dist_dir" && chmod -R 755 "$dist_dir/package.nw" && rm -rf "$exe_dir"

# nwjs
nw_file="$cache_dir/nwjs_$nwjs_v.tar.gz"
if [ -f "$nw_file" ]; then
    echo "从缓存获取nwjs"
else
    echo "开始下载nwjs"
    wget -O "$nw_file" "https://npm.taobao.org/mirrors/nwjs/v$nwjs_v/nwjs-sdk-v$nwjs_v-linux-x64.tar.gz" 
fi
tar -xf "$nw_file" -C "$dist_dir" --strip-components=1

# node
node_file="$cache_dir/nodejs.tar.gz"
if [ -f "$node_file" ]; then
    echo "从缓存获取node"
else
    echo "开始下载node"
    wget -O "$node_file" "https://nodejs.org/download/release/v$node_v/node-v$node_v-linux-x64.tar.gz" 
fi
tar -xf "$node_file" -C "$dist_dir"
node_dir_name="node-v$node_v-linux-x64"
(cd "$dist_dir" && ln -rfs "$node_dir_name/bin/node" node && ln -rfs "$node_dir_name/bin/node" node.exe && ln -rfs "$node_dir_name/lib/node_modules/npm/bin/npm-cli.js" npm)
export npm_config_cache="$cache_dir/.npm"

# patch
sed -i 's/throw b.code=p.VENDOR_MD5_NOT_MATCH,b//' $dist_dir/package.nw/js/*.js 

# 复制脚本
cp "$root_dir"/scripts/*.sh "$dist_dir"

# 重新编译 node c/c++ 模块
bash "$dist_dir"/rebuild-native-modules.sh

# 封装 exe
bash "$dist_dir"/wrap-exe.sh

# 打印版本
echo $version > "$root_dir/version"