#!/bin/bash -e

#
# 重新重新构建 node 模块
#

app_dir="$(cd `dirname $0` && pwd -P)"
package_dir="$app_dir/package.nw"


# 使用本地 node
export PATH="$app_dir:$PATH"

git_utils() {
    cd "$package_dir"
    rm -rf node_modules/git-utils/build
    npm build node_modules/git-utils
}
echo "开始重新构建 git-utils" 
git_utils

nodegit() {
    cd "$package_dir"
    nodegit_v=$(npm info nodegit version)
    nodegit_dir=$app_dir/package.nw/node_modules/nodegit
    cd /tmp
    npm i --production nodegit@$nodegit_v 
    rm -rf $nodegit_dir && mv /tmp/node_modules/nodegit $nodegit_dir
}
echo "开始重新构建 nodegit" 
nodegit

node_sync_ipc() {
    cd "$package_dir/node_modules"
    (cd node-sync-ipc && npm run install)
    (rm -rf node-sync-ipc-nwjs && cp -r node-sync-ipc node-sync-ipc-nwjs)
}
echo "开始重新构建 node-sync-ipc, 并替换 node-sync-ipc-nwjs" 
node_sync_ipc