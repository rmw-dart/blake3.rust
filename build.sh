#!/usr/bin/env bash

DIR=$(cd "$(dirname "$0")"; pwd)
set -ex
cd $DIR

if ! [ -x "$(command -v cargo)" ]; then
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# sudo apt-get install libclang-dev dart

if [ ! -d ".dart_tool" ] ; then
dart pub get
fi


rm -rf *.h

export RUST_BACKTRACE=1
#cbindgen --config cbindgen.toml --output h/cbindgen.h
cargo +nightly test --features c-headers -- c_headers
dart run ffigen

RUSTFLAGS="-C target-feature=+avx,+fma,+aes,+sse,+sse2,+sse3,+ssse3,+sse4.1" RUST_BACKTRACE=1 \
cargo +nightly build --release

./so.xsh
