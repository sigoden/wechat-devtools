# Linux 微信Web开发者工具

> 使用 Shell 脚本对 Windows 版`微信Web开发者工具`的基础组件进行兼容处理来实现在 Linux 中运行， 原理图如下:

```
                                  +-------------+
                             +----> nw          +-----> 跨平台，可以使用Linux版替换
                             |    +-------------+
+-------------------------+  |
|                         |  |    +-------------+
| wechat_web_devtools.exe +-------+ js/html/css +-----> 跨平台，但 nodejs c/c++ 模块需要重新编译
|                         |  |    +-------------+
+-------------------------+  |
                             |    +-------------+
                             +----> exe         +-----> 可以通过 wine 中运行
                                  +-------------+

```
## Linux 下使用

### 安装 [Wine](https://www.winehq.org) 

`wechat_web_devtools.exe` 中有两个 exe 文件: wcc.exe (WXML 编译器) 和 wcsc.exe (Stylesheet 编译器)，只能通过 Wine 才能在 Linux 下运行。

ubuntu18.04 安装如下

```sh
sudo apt-get install wine-binfmt wine-stable
sudo update-binfmts --import /usr/share/binfmts/wine # 默认使用 wine 处理 exe 文件
```

### 获取工具

#### 使用源码构建

> 克隆项目后执行脚本 `build.sh`

```sh
git clone https://github.com/sigoden/wechat-devtools.git
cd wechat-devtools.git
./build.sh # 下载安装 wechat_devtools.exe, nwjs, nodejs，处理后生成 ./dist 目录
./dist/launch.sh # 运行
```

#### 从 [Release](https://github.com/sigoden/wechat-devtools/releases) 下载
```sh
tar xf wechat-devtools-$ver.tgz # 解压生成 ./dist 目录
./dist/launch.sh # 运行
```
> `./dist/install-desktop.sh`: 安装桌面图标 wechat_devtools.desktop 文件

### 卸载开发者工具

#### 关闭 `微信web开发者工具`

#### 删除删除桌面图标
```sh
rm -rf $HOME/.local/share/applications/wechat_devtools.desktop
```

#### 删除微信web开发者工具配置目录
```sh
rm -rf $HOME/.config/微信web开发者工具
```

## Docker 中使用

### 获取镜像

```sh
docker pull sigoden/wechat-devtools
```

### 运行容器

方法一， 使用 `docker` 运行

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

方法二，使用 `docker-compose` 运行

```sh
docker-compose -f docker/docker-compose.yaml
```

方法三，安装并使用桌面图标运行
```sh
./docker/install-destkop.sh
```

### 错误排除

<details>
 <summary>无法启动界面，且 `docker log` 有打印类似 `(nw:20): Gtk-WARNING **: 21:01:27.941: cannot open display: :0.0` ?</summary>
  x-server 有限制访问权限。运行 `xhost +SI:localuser:$(id -un)` 授权
</details>