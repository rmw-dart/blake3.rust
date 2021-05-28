#!/usr/bin/env bash

set -ex

DIR=$(dirname $(realpath "$0"))

cd $DIR

dart compile exe ./test.dart -o test.exe
