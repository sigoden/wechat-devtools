#!/bin/bash -e

version=$(cat version)

if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    exit
fi

git config --global user.email "sigoden@gmail.com"
git config --global user.name "ci"

echo "生成压缩文件"
export GZ_FILE=wechat-devtools-$version.tar.xz
tar -cJf $GZ_FILE dist --transform 's/^dist/wechat-devtools-'$version'/'

git remote set-url origin https://sigoden:${GT_TOKEN}@github.com/sigoden/wechat-devtools.git

echo "提交 git commit"
if $(git diff --name-only | grep -qx version); then # 有新版本
    git checkout master
    git add version
    git commit -m "ci: upgrade to $version; [skip ci]"
    git tag $version
    git push origin master
    git push origin $version
else
    git tag -f $version
    git push origin $version --force
fi
export TRAVIS_TAG=$version

echo "上传新版本"