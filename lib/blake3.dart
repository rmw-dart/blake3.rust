import './Ffi.dart' as Ffi;
import 'dart:typed_data' show Uint8List;
import './So.dart' show So, Uint8ListPointer;
import 'dart:ffi' show Uint8Pointer, Pointer;
import 'package:ffi/ffi.dart' show calloc;

Uint8List hash(Uint8List data) {
  final ptr = data.ptr();
  final h = So.hash(ptr, data.length);
  calloc.free(ptr);
  final hash = Uint8List.fromList(h.asTypedList(32));
  So.hash_free(h);
  return hash;
}

class Hasher {
  late Pointer<Ffi.Hasher> hasher;
  Hasher() {
    this.hasher = So.hasher_new();
  }
  void update(Uint8List data) {
    final ptr = data.ptr();
    So.hasher_update(this.hasher, ptr, data.length);
    calloc.free(ptr);
  }

  Uint8List end() {
    final h = So.hasher_end(this.hasher);
    final hash = Uint8List.fromList(h.asTypedList(32));
    So.hash_free(h);
    return hash;
  }
}
