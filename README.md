# Linux 微信web开发者工具

## 兼容策略

```
                              +-------------+
                         +----> nw          +-----> 跨平台，可以使用Linux版替换
                         |    +-------------+
+---------------------+  |
|                     |  |    +-------------+
| wechat_devtools.exe +-------^+ js/html/css +-----> 跨平台，但 nodejs c/c++ 模块需要重新编译
|                     |  |    +-------------+
+---------------------+  |
                         |    +-------------+
                         +----> exe         +-----> 可以通过 wine 中运行
                              +-------------+

```

## 安装

### 依赖项

- [wine](https://www.winehq.org)

     以 Ubuntu18.04 为例

     ```sh
     sudo apt-get install wine-binfmt wine-stable
     sudo update-binfmts --import /usr/share/binfmts/wine # 默认使用 wine 处理 exe 文件
     ```

### 安装配置

- 通过脚本获取

```sh
git clone https://github.com/sigoden/wechat-devtools.git
cd wechat-devtools.git
./build.sh # 下载安装 wechat_devtools.exe 和 nw 到 ./dist 目录
./dist/launch.sh # 运行
```

- 从 [Github Release](https://github.com/sigoden/wechat-devtools/releases) 下载
```sh
tar xf wechat-tools.tgz # 解压生成 ./dist 目录
./dist/launch.sh # 运行
```
> `./dist/install-desktop.sh`: 安装桌面图标 wechat_devtools.desktop 文件

## 卸载

1. 关闭 `微信web开发者工具`

2. 删除删除桌面图标
```sh
rm -rf $HOME/.local/share/applications/wechat_devtools.desktop
```

3. 删除微信web开发者工具配置目录
```sh
rm -rf $HOME/.config/微信web开发者工具
```

## Docker中运行

### 获取

```sh
docker pull sigoden/wechat-devtools
```

### 运行

- 可以 `docker` 运行

```sh
docker run  \
    -d \
    --privileged \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "$HOME/.config/微信web开发者工具:/home/node/.config/微信web开发者工具" \
    -e DISPLAY \
    sigoden/wechat-devtools
```
> 见[`docker/launch.sh`](docker/launch.sh) 文件

- 可以使用 `docker-compose` 运行

```sh
docker-compose -f docker/docker-compose.yaml
```

- 可以安装桌面图标运行
```sh
./docker/install-destkop.sh
```

### 错误排除

- 使用 `docker log` 查看日志

- 日志有打印类似 `(nw:20): Gtk-WARNING **: 21:01:27.941: cannot open display: :0.0`，表示宿主 X-server 有权限限制。运行 `xhost +SI:localuser:$(id -un)` 即可。