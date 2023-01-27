import 'dart:convert';
import 'dart:io';
import 'dart:math';

/// 异步支持
/// 关键字 `async` `await`
///

/// 异步函数的返回类型`Future`
/// `await`关键字只能在`async`方法块中使用, 普通的方法内不能使用`await`
/// 使用`await`与`async`可以使异步代码在开发中看起来像写同步代码, 更方便理解代码的意义
Future<void> delayJson() async {
  print(DateTime.now());

  /// Future.delayed(...) 返回的是 Future<> 类型, 下面例子中第二个参数的return是String
  /// 所以返回的类型是 Future<String>
  /// 使用await关键字后, 得到的`json`是String类型
  /// await的作用是等待Future执行完成
  var json = await Future.delayed(Duration(seconds: 3), () {
    return '{"title": "Flow", "value": 1, "extra": null}';
  });
  print(DateTime.now());
  final obj = jsonDecode(json);
  assert(obj['title'] == 'Flow');
  assert(obj['value'] == 1);
  assert(obj['extra'] == null);
}

Future<int> random() {
  return Future(() => Random().nextInt(50));
}

Future<String> stringify(int value) {
  if (value < 10) {
    return Future(() => throw 'Value:$value less than 10');
  }
  return Future(() => 'value: $value');
}

Future<void> logString(String text) {
  return Future(() => print(text));
}

/// 下面两种调用方式逻辑基本一致.
/// 使用Future的API用例
Future<void> useFuture() {
  var intFu = random();

  /// then方法, 当Future完成时调用
  /// 每一个`then`方法后, 可以继续调用`then`方法(按顺序逐级调用)
  return intFu.then((value) {
    return stringify(value).then((text) {
      print('First then output');
      return logString(text);
    }).then((value) {
      /// 因为前一个`then`没有返回值, 所以这里的value类型是void
      print('Seconde then output');
    }).then((value) {
      print('Third then output');
      if (Random().nextBool()) {
        throw 'Third then method error';
      }
    }).catchError((error) {
      /// catchError 放到最后面, 这样除了可以捕捉原始Future方法中的错误
      /// 也可以捕捉`then`方法中的错误(不限`then`的个数),
      print('CatchMethodErrorValue: $error');
    });
  });
}

/// 使用`await`&`async`关键字
Future<void> useAwait() async {
  var value = await random();
  try {
    var text = await stringify(value);
    await logString(text);
  } catch (e) {
    print("TryCatchErrorValue: $e");
  }
}

/// 网络请求例子
Future<void> requestFuture() {
  /// 这里添加return, 是为了在单元测试中, 可以等待请求完成.
  /// 实际开发应用中, 可具体情况具体分析
  final client = HttpClient();
  return client.get('www.baidu.com', 80, '').then((value) {
    return value.close();
  }).then((value) {
    return value.transform(utf8.decoder).join();
  }).then((value) {
    print(value);
    client.close();
  }).catchError((e) {
    client.close();
  });
}

Future<void> requestAwait() async {
  final client = HttpClient();
  try {
    final request = await client.get('www.baidu.com', 80, '');
    final response = await request.close();
    final text = await response.transform(utf8.decoder).join();
    print(text);
  } finally {
    client.close();
  }
}
