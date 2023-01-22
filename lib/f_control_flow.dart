import 'dart:math';

void ifelseControlFlow() {
  var score = Random().nextInt(100);
  if (score >= 90) {
    print('⭐⭐️️️⭐️️️⭐️️️⭐️️️️️️');
  } else if (score >= 80) {
    print('⭐⭐️️️⭐️️️⭐️️️');
  } else if (score >= 70) {
    print('⭐⭐️️️⭐️️️');
  } else if (score >= 60) {
    print('️️️️⭐️⭐️');
  } else {
    print('⭐️');
  }
}

void forLoop() {
  /// 正常的循环模式
  var text = 'Content';
  for (var i = 0; i < 5; i++) {
    text += '!';
  }
  assert(text == 'Content!!!!!');

  /// 对于(Iterable)类型的变量,例:列表(List), 集合(Set), 可以使用`forin`循环
  var newText = '';
  for (final obj in ['New', ' ', 'Text']) {
    newText += obj;
  }
  assert(newText == 'New Text');

  /// Iterable 也可使用`forEach`
  ['For', 'Each'].forEach((element) {
    print(element);
  });
}

void whileLoop() {
  var counter = 0;
  var loopCount = 0;
  // 先判断条件, 后进入循环内容体
  while ((loopCount++) < 4) {
    counter += 1;
  }

  // 循环条件语句一共执行了5次
  // 4次成功, 1次失败, loopCount == 5
  assert(loopCount == 5);
  // 循环内容体一共执行了4次
  assert(counter == 4);

  counter = 0;
  loopCount = 0;
  // 先执行循环内容体, 后判断条件
  do {
    counter += 1;
  } while ((loopCount++) < 4);

  assert(loopCount == 5);
  // 循环内容体进入5次
  assert(counter == 5);
}

///结束循环(break)与跳到下一次循环(continue)
void breakAndContinue() {
  var counter = 0;
  print('enter loop');
  while (true) {
    counter++;
    if (counter % 2 == 0) {
      continue;
    }
    print('$counter');
    if (counter > 10) {
      break;
    }
  }
  print('exit loop');

  /// 如果处理的是Iterable对象, 可以使用`where`,`forEach`方法
  var list = [for (var i = 0; i < 10; i++) i];

  /// `where` 接收一个函数做参数, 函数返回true则保留元素, 返回false则抛弃元素
  var whereList = list.where((element) => element % 2 != 0);
  whereList.forEach((element) {
    print(element);
  });
}

void switchCase() {
  /// 正常情况下的switch语句,
  /// 所有case都必须以`break`结束, 也可以使用`continue` `throw` `return` 结束.
  var commond = Random().nextInt(3);
  switch (commond) {
    case 1:
      print('One');
      break;
    case 2:
      print('Two');
      break;
    case 3:
      print('Three');
      break;
    default:
      print('Other');
  }

  /// 如果某个case的内容为空, 可以省略`break`, 当执行到空case时,会直接进入下一个case
  /// case内容为空的情况
  switch (commond) {
    case 1:
    case 2:
      print('valid value');
      break;
    case 3:
      print('Three');
      break;
    default:
      print('Other');
  }

  /// 如果case不为空, 同时在执行完case后,想继续进入到下一个case
  /// 可以使用`continue`与`label`
  switch (commond) {
    case 1:
      print('One');
      // 准备去case==3的情况
      continue CASE_THREE;
    case 2:
      print('Two');
      break;
    CASE_THREE:
    case 3:
      print('Three');
      break;
    default:
      print('Other');
  }
}

/// 断言判断, 只在development模式下生效
///
/// Flutter 在debug模式开启断言
/// 开发工具默认开启断言, 如`webdev serve`
/// `dart run` 或 `dart compile js` 支持断言通过命令行参数 `--enable-asserts`
void assertStatement() {
  /// 断言判断,
  /// 第一参数的结果是`true`, 才会继续执行
  /// 是`false`时, 会抛出一个异常
  assert(true);

  /// 第二个参数, 是异常中携带的消息
  assert(true, 'failed message');

  try {
    assert(false, 'try catch failed');
  } on AssertionError catch (e) {
    print(e);
    print(e.message);
  }
}
