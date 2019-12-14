#!/usr/bin/env bash

set -e
set -x

rm -f php/splitsh-lite.tar.gz
wget -O php/splitsh-lite.tar.gz https://github.com/splitsh/lite/releases/download/v1.0.1/lite_linux_amd64.tar.gz
tar -C php -xvzf php/splitsh-lite.tar.gz

git pull origin master

function split() {
  git remote add $1 $3
  SHA1=`php/splitsh-lite --prefix=$2`
  git push $1 "$SHA1:refs/heads/master"
}

split "framework" "php/framework" "https://github.com/jameswilddev/breadcad-framework"
