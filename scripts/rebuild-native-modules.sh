#!/bin/bash -e

#
# 重新重新构建 node 模块
#

app_dir="$(cd `dirname $0` && pwd -P)"
package_dir="$app_dir/package.nw"

export PATH="$app_dir:$PATH"

cp -r "$package_dir/node_modules" "$package_dir/node_modules_bak"
(cd "$package_dir" && "$app_dir/npm" install)
(cd "$package_dir/node_modules" && find -name *.node | xargs -I{} cp -r {} ../node_modules_bak/{})
(cp -r "$package_dir"/node_modules/node-sync-ipc/build/Release/*.node "$package_dir"/node_modules/node-sync-ipc-nwjs/build/Release)
rm -rf "$package_dir/node_modules"
mv "$package_dir/node_modules_bak" "$package_dir/node_modules"
