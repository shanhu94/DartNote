/// 在Dart中, 函数(functions)也是对象, 也有类型 (Function)
/// 代表着函数也可以赋值给变量或当成一个其他函数的参数

void functionTour() {
  /// 一个携带参数与返回值的函数
  int increase(int num) {
    return num + 1;
  }

  /// Dart建议公开函数的参数有类型声明, 但无类型声明也是有效的
  int decrease(num) {
    return num - 1;
  }

  /// 如果函数体内只有一个表达式, 可以使用简略表达式的语法(shorthand syntax)
  int shortIncrease(int num) => num + 1;

  /// 在这种写法下, 不能使用if语句, 但可以使用条件表达式(conditional expressions)
  /// 条件表达式就是三元表达式`?:`与可为空对象的变形`??`
  int shortOperator(int num) => num > 0 ? num + 1 : num - 1;
  int shortNullableIncrease(int? num) => (num ?? 0) + 1;

  assert(increase(1) == shortIncrease(1));
  assert(increase(1) == shortNullableIncrease(1));
  assert(increase(1) == shortOperator(1));
  assert(decrease(-1) == shortOperator(-1));
}

/// 函数参数
void functionParamTour() {
  /// 一个函数可以有多个位置参数(positional parameters)
  /// 位置参数后可以拼接命名参数(named parameters)或可选的位置参数
  /// 但不能同时拼接两种类型参数

  /// 位置参数(positional parameters)函数
  void paramFunction(int p1, String p2, double p3, bool p4) {
    print('$p1 $p2 $p3 $p4');
  }

  paramFunction(10, 'p2-str', 1.0, true);

  /// 命名参数
  /// 必要的参数需要使用 `required` 标记, 否则是可选的命名参数
  /// 否则需要对命名参数提供默认值
  /// bool? 默认值是 `null` 所以不需要指定, double p3使用1.0默认值
  void namedParamFunction({required int p1, bool? p2, double p3 = 1.0}) {
    print('$p1 $p2 $p3');
  }

  namedParamFunction(p1: 10);
  namedParamFunction(p1: 11, p2: true);
  namedParamFunction(p1: 12, p2: false, p3: 11.0);

  /// 可选位置参数
  void optionalPosiParamFunction(int p1, [double p2 = 1.0, bool p3 = true]) {
    print('$p1 $p2 $p3');
  }

  optionalPosiParamFunction(1);
  optionalPosiParamFunction(10, 20.0, false);

  void callbackFunction(double Function(int) callback, {required int times}) {
    for (var i = 0; i < times; i++) {
      print('callback value: ${callback(i)}');
    }
  }

  /// 命名参数可以放在任意位置调用
  callbackFunction(times: 10, (int num) {
    return num.toDouble();
  });
}

void functionAsObject() {
  void printElement(int ele) {
    print(ele);
  }

  var list = [1, 2, 3];

  /// 将printElement函数当做参数传递到forEach函数
  list.forEach(printElement);

  /// 将函数传递给变量
  var pMsg = (String msg) => '!!${msg.toUpperCase()}!!';
  assert(pMsg('hello') == '!!HELLO!!');
  String Function(String) npMsg = pMsg;
  assert(npMsg('abc') == pMsg('abc'));
}

/// 匿名函数(anonymous functions)
void anonymousFunctions() {
  const list = ['apples', 'bananas', 'oranges'];
  list.map((e) => e.toUpperCase()).forEach((element) {
    print('$element: ${element.length}');
  });

  /// 匿名函数 (e) => e.toUpperCase()
  /// 匿名函数 (element) { print('$element: ${element.length}'); }
}

/// 作用域
bool topLevel = true;
void lexicalScope() {
  var insideLexicalScope = true;

  void normalFunction() {
    var insideFunc = true;

    void nestedFunction() {
      // 作用域只在当前方法体(`{}`包含的东西)与子级方法体
      var insideNestedFunc = true;
      // 这里可以访问这4个变量
      assert(topLevel);
      assert(insideLexicalScope);
      assert(insideFunc);
      assert(insideNestedFunc);
    }

    // 这里只可以访问3个变量
    assert(topLevel);
    assert(insideLexicalScope);
    assert(insideFunc);
    // insideNestedFunc 在这里无法访问
  }
}

/// 闭包 (Lexical closures)
void lexicalClosures() {
  int Function(int) makeAdder(int addBy) {
    /// 返回的闭包(函数对象)捕获了addBy变量,
    /// 不论这个函数在什么位置调用都可以正常使用这个addBy变量
    return (int i) => addBy + i;
  }

  var add2 = makeAdder(2);
  var add4 = makeAdder(4);
  assert(add2(3) == 5);
  assert(add4(3) == 7);
}

/// 所有的函数都会返回一个值
/// 如果没有函数声明没有指定一个返回值, 会在函数体的最后拼接一句`return null;`
void returnValue() {
  testFunc() {} // 没有指定返回值, 默认返回null
  assert(testFunc() == null);
}
