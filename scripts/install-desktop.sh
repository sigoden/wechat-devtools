#!/bin/bash

#
#  安装桌面图标
#

app_dir=$(cd `dirname $0` && pwd -P)

cat > $HOME/.local/share/applications/wechat_devtools.desktop << EOF
[Desktop Entry]
Name=微信web开发者工具
Comment=The development tools for wechat web develop
Categories=Development;WebDevelopment;IDE;
Exec=$app_dir/launch.sh
Icon=$app_dir/package.nw/static/image/logo@2x.png
Type=Application
Terminal=false
X-Desktop-File-Install-Version=0.22
EOF