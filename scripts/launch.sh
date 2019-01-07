#!/bin/bash

#
# 启动开发者工具
#

app_dir="$(cd `dirname $0` && pwd -P)"
"$app_dir"/nw --load-extension="$app_dir"/package.nw/js/ideplugin