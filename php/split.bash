#!/usr/bin/env bash

set -e
set -x

cd `mktemp -d`
git clone https://github.com/jameswilddev/breadcad .
git checkout $TRAVIS_TAG
git checkout -b release-temp
rm -f php/splitsh-lite.tar.gz
wget -O php/splitsh-lite.tar.gz https://github.com/splitsh/lite/releases/download/v1.0.1/lite_linux_amd64.tar.gz
tar -C php -xvzf php/splitsh-lite.tar.gz

function split() {
  git remote add $1 "https://$GITHUB_TOKEN@github.com/jameswilddev/breadcad-$1"
  git checkout release-temp
  SHA1=`php/splitsh-lite --prefix=$2`
  git tag --annotate $TRAVIS_TAG --message $TRAVIS_TAG --force $SHA1
  git push $1 "$SHA1:refs/heads/master" --tags --force
}

split "framework" "php/framework"
