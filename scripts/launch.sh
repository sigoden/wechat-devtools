#!/bin/bash

#
# 启动开发者工具
#

app_dir="$(cd `dirname $0` && pwd -P)"

app_dir_file="$HOME/.config/微信web开发者工具/.app_dir"
if [ ! -f "$app_dir_file" ] || [ "$(cat "$app_dir_file")" =  "$app_dir" ]; then
    rm -rf "$HOME/.config/微信web开发者工具/WeappVendor"
    bash "$app_dir/wrap-exe.sh"
fi

echo $app_dir > "$app_dir_file"

exec "$app_dir"/nw --load-extension="$app_dir"/package.nw/js/ideplugin "$@"