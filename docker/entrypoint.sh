#!/bin/bash -e

WECHAT_CONFIG_PATH="/home/node/.config/微信web开发者工具"
WECHAT_APP_PATH="/home/node/weapp"

if [[ "$1" = "/app/launch.sh" ]]; then
        mkdir -p "$WECHAT_APP_PATH" "$WECHAT_CONFIG_PATH"
        chown -R node:node "$WECHAT_APP_PATH" "$WECHAT_CONFIG_PATH"
        sudo -H -u node "$@"
else
        exec "$@"
fi