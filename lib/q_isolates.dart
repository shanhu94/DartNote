
import 'dart:isolate';

/// Dart 运行代码在 isolate模式下
/// 特点是: 
/// 1. 运行在单一线程下, 不与其他isolate共享可变对象, 这使多线程开发,不会出现数据竞争
/// 2. 多个isolate使用消息通信
/// 'dart:isolate' 仅支持在原生平台(Dart Native) https://dart.dev/overview#platform
/// 官方Demo: https://github.com/flutter/samples/tree/main/isolate_example

Future<void> receive(void Function(SendPort) callback, void Function(SendPort) otherCallback) async {
  var receive = ReceivePort();
  callback(receive.sendPort);
  final iso = await Isolate.spawn(otherReceivePort, receive.sendPort);
  return receive.listen((message) {
    if (message is SendPort) {
      print(message);
      otherCallback(message);
    } else {
      if (message == 'end') {
        receive.close();
        // iso.kill(priority: Isolate.immediate);
      }
      print(message);
    }
  }).asFuture();
}

void otherReceivePort(SendPort port) {
  final other = ReceivePort();
  port.send(other.sendPort);

  other.listen((message) {
    print('other receive: $message');
    if (message == 'end') {
      port.send(message);
    }
  });
}