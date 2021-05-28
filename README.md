<!-- 本文件由 ./readme.make.md 自动生成，请不要直接修改此文件 -->

# dart.blake3.rust

##  编译脚本

运行 ./build.sh 生成 so

运行 ./test.sh 测试

## 使用演示

```dart
import 'dart:convert' show utf8, base64;
import './lib/rmw.dart' show hash, Hasher;

void main() {
  var n = 0;

  while (true) {
    final data = utf8.encoder.convert("$n");
    final h = hash(data);
    final hasher = Hasher();
    hasher.update(data);
    final h2 = hasher.end();

    if (n % 10000 == 0) {
      print('$n ${base64.encode(h)} ${base64.encode(h2)}');
    }
    n++;
  }
}

```

## 参考文献

* [引入更安全的FFI](https://www.ditto.live/blog/posts/introducing-safer-ffi)
* [How to call a Rust function from Dart using FFI](https://medium.com/flutter-community/how-to-call-a-rust-function-from-dart-using-ffi-f48f3ea3af2c)
* [如何将字节数组从Rust函数返回到FFI C？](https://users.rust-lang.org/t/how-to-return-byte-array-from-rust-function-to-ffi-c/18136/16)
* [其他语言使用Rust对象](http://jakegoulding.com/rust-ffi-omnibus/objects/)

## 关于

本项目隶属于**人民网络([rmw.link](//rmw.link))** 代码计划。

![人民网络](https://raw.githubusercontent.com/rmw-link/logo/master/rmw.red.bg.svg)
