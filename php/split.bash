#!/usr/bin/env bash

set -e
set -x

cd `mktemp -d`
git clone --depth 1 --single-branch --branch $TRAVIS_TAG https://github.com/jameswilddev/breadcad .
rm -f php/splitsh-lite.tar.gz
wget -O php/splitsh-lite.tar.gz https://github.com/splitsh/lite/releases/download/v1.0.1/lite_linux_amd64.tar.gz
tar -C php -xvzf php/splitsh-lite.tar.gz

function split() {
  git remote add $1 "https://$GITHUB_TOKEN@github.com/jameswilddev/breadcad-$1"
  SHA1=`php/splitsh-lite --prefix=$2`

  git push $1 "$SHA1:refs/heads/master" --tags
}

split "framework" "php/framework"
