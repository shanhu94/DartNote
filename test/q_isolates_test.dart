import 'package:test/test.dart';
import 'package:learn/q_isolates.dart' as iso;

void main() {
  test('useIsolate', () async {
    await iso.receive((sp) {
      sp.send('message');
      sp.send('Hello World');
    }, (osp) {
      osp.send('Hello OSP');
      osp.send('XXXXXXXXXX');
      osp.send('end');
    });
  });
}