#!/usr/bin/env bash

set -ex

DIR=$(dirname $(realpath "$0"))

cd $DIR

if ! hash nodemon 2>/dev/null; then
yarn global add nodemon
fi

nodemon --exec "dart run test.dart" --watch . -e dart


