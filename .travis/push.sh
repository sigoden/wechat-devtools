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
    git push origin master --tags
else
    git fetch --tags
    if [ $(git tag -l "$version") ]; then
        git push --delete origin $version
    else
        git tag $version
    fi
    git push origin $version
fi

echo "上传新版本"