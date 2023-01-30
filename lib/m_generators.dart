
/// 当需要延迟生成一系列数据时, 可以考虑使用生成器函数(generator function)
/// 当使用(for in循环访问返回的Iterable变量)或(await for in 访问Stream变量)时, 
/// 每执行一次`yield`会结束当前函数, 将`yield`后的值回传到循环体中, 执行一次循环体, 
/// 循环体执行完成后, 
/// 进入下一次循环会从上一次`yield`的位置继续向下执行, 直到真正执行完函数
/// 执行 `syncRecursiveGenerators` 与 观察输出可推导出执行顺序

/// **注意**: 不要使用原始普通的for循环, 当获取Iterable的长度时,就会完整的执行一次函数


/// 同步生成器 (Synchronous generator) 返回 Iterable 对象
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) {
    yield k++;
  }
}

void syncGenerators() {
  var value = naturalsTo(10);
  for (final v in value) {
    print(v);
  }
}

/// 异步生成器 (Asynchronous generator) 返回 Stream 对象
Stream<int> dummyAsynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) {
    yield k++;
  }
}

Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) {
    final a = await Future.delayed(Duration(seconds: 1), () async* {
      yield k++; // k 是int类型
    });

    /// `yield*`后接的对象需要是 Iterable或Stream 类型
    /// 而`yield`后接的对象是 Iterable或Stream中包含的数据的类型
    /// 当前函数的 `k`是int类型, `a`是Stream<int> 类型
    yield* a; // a 是 Stream<int>
  }
}

/// 添加 async 的函数, 不一定要返回 Future 对象
/// 不过不返回`Future`, 外部就无法等待此函数
/// 在单元测试中可能会发现, 程序已经退出, 但print没有执行.
void dummyAsyncGenerators() async {
  await for (final value in dummyAsynchronousNaturalsTo(10)) {
    print(value);
  }
}

Future<void> asyncGenerators() async {
  await for (final value in asynchronousNaturalsTo(10)) {
    print(value);
  }
}

/// 倒序与执行顺序的同步生成器例子
Iterable<int> recursiveNaturalsTo(int n) sync* {
  while (n > 0) {
    print('perform n: $n');
    yield n;
    print('perform n-1: ${n-1}');
    yield n - 1;
    print('perfomr n+1: ${n+1}');
    yield n + 1;
    n --;
  }
}

void syncRecursiveGenerators() {
  final value = recursiveNaturalsTo(10);
  for (final v in value) {
    print('for put: $v');
  }
  // 不要使用此种循环方式, 每次访问`value.length`都会完整的执行完`recursiveNaturalsTo`函数
  // for (var i = 0; i < value.length; i ++) {
  //   print('for put ${value.elementAt(i)}');
  // }
}

/// 倒序与执行顺序的异步生成器例子
Stream<int> asyncRecursiveNaturalsTo(int n) async* {
  while (n > 0) {
    final a = await Future.delayed(Duration(seconds: 1), () async* {
      print('perform n: $n');
      yield n;
      print('perform n-1: ${n-1}');
      yield n - 1;
      print('perfomr n+1: ${n+1}');
      yield n + 1;
      n --;
    });
    yield* a;
  }
}

Future<void> asyncRecursiveGenerators() async {
  final value = asyncRecursiveNaturalsTo(10);
  await for (final v in value) {
    print('await for put: $v');
  }
}
