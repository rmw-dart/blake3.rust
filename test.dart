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
