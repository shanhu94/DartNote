import 'dart:math';

import 'package:test/test.dart';
import 'package:learn/g_exceptions.dart' as except;

void main() {
  test('throwException', () {
    try {
      except.throwException();
    } catch (e) {
      print(e);
    }
  });
}
