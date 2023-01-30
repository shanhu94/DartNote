import 'package:test/test.dart';
import 'package:learn/m_generators.dart' as generators;

void main() {
  test('syncGenerators', () {
    generators.syncGenerators();
  });
  test('dummyAsyncGenerators', () {
    generators.dummyAsyncGenerators();
  });
  test('asyncGenerators', () async {
    await generators.asyncGenerators();
  });
  test('syncRecursiveGenerators', () {
    generators.syncRecursiveGenerators();
  });
  test('asyncRecursiveGenerators', () async {
    await generators.asyncRecursiveGenerators();
  });
}