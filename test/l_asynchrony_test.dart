import 'package:test/test.dart';
import 'package:learn/l_asynchrony.dart' as asynchrony;

void main() {
  test('delayJson', () async {
    await asynchrony.delayJson();
  });
  test('useFutureAndAwait', () async {
    await asynchrony.useFuture();
    await asynchrony.useAwait();
  });
  test('requestFuture', () async {
    await asynchrony.requestFuture();
  });
  test('requestAwait', () async {
    await asynchrony.requestAwait();
  });
}
