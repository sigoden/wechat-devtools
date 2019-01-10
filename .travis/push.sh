#!/bin/bash -e

version=$(cat version)

if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    exit
fi

git config --global user.email "sigoden@gmail.com"
git config --global user.name "ci"

git remote set-url origin https://sigoden:${GT_TOKEN}@github.com/sigoden/wechat-devtools.git

if $(git diff --name-only | grep -qx version); then # 有新版本
    git checkout master
    git add version
    git commit -m "ci: upgrade to $version; [skip ci]"
    git tag $version
    git push origin master
    git push origin $version
    export TRAVIS_TAG=$version
    echo "上传新版本: $version"
else
    if $(echo "$TRAVIS_COMMIT_MESSAGE" | grep -qE '\[skip deploy\]'); then
        unset TRAVIS_TAG
    else
        git tag -f $version
        git push origin $version --force
        export TRAVIS_TAG=$version
        echo "覆盖版本: $version"
    fi
fi

if [ -n "$TRAVIS_TAG" ]; then
    echo "压缩文件"
    tar -cJf wechat-devtools-$version.tar.xz dist --transform 's/^dist/wechat-devtools-'$version'/'
fi