#!/usr/bin/env xonsh

$XONSH_SHOW_TRACEBACK = True

from os.path import dirname,abspath
import platform

trace on

DIR = dirname(abspath(__file__))
DIST=f"{DIR}/dist/{platform.system().lower()}/{platform.machine()}"

mkdir -p @(DIST)

SO = 'ffi.so'

OUT=f"{DIST}/{SO}"

suffix = dict(
  Windows="dll",
  Linux="so",
  Darwin="dylib"
)[platform.system()]

mv @(DIR)/target/release/libdart_ffi.@(suffix) @(OUT)

rm -rf @(SO)
ln -s @(OUT) .

print(OUT)
