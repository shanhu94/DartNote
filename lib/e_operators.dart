/// 算数操作符
void arithmeticOperators() {
  assert(2 + 3 == 5);
  assert(2 - 3 == -1);
  assert(2 * 3 == 6);
  // 除法,结果是double
  assert(5 / 2 == 2.5);
  // 除法, 结果是int
  assert(5 ~/ 2 == 2);
  // 取余(Remainder)
  assert(5 % 2 == 1);
  // 自增, 自减
  var value = 5;
  // 表达式的值是 (value + 1)
  assert(++value == 6);
  assert(value == 6);
  // 表达式的值是 (value)
  assert(value++ == 6);
  assert(value == 7);
  // 表达式的值是 (value - 1)
  assert(--value == 6);
  assert(value == 6);
  // 表达式的值是 (value)
  assert(value-- == 6);
  assert(value == 5);
}

/// 相等与关系操作符
void equalityAndRelationalOperators() {
  int? x;
  int? y;
  // x == y == null
  // 当两个变量都是null时,
  assert(x == y);

  assert(2 != 3);
  assert(3 > 2);
  assert(2 < 3);
  assert(3 >= 3);
  assert(3 <= 3);
}

/// 类型测试操作符
class Animal {
  String name;
  Animal({required this.name});
}

class Dog extends Animal {
  Dog({required super.name});
  void run() {
    print('$name is running');
  }
}

class Cat extends Animal {
  Cat({required super.name});
  void sleep() {
    print('$name is sleeping');
  }
}

void typeTestOperators() {
  /// 运行时检查类型的操作符 `as`, `is`, `is!`
  dynamic dog = Dog(name: 'dog');
  dynamic cat = Cat(name: 'cat');

  /// 如果你确认cat是Cat类型,
  /// 可以使用as直接进行类型转换, 然后调用对应的方法
  print((cat as Cat).name);

  /// 如果不能确认cat是Cat数据类型
  /// 可以先使用is进行判断,
  /// cat是Cat类型的实例对象, 返回true
  /// 注意: 实际开发建议使用`is`判断类型
  ///      如果cat是null或非Cat类型, 使用as会报运行时错误
  ///      使用`is`将会正常运行
  if (cat is Cat) {
    cat.sleep();
  }

  /// `is!` 是dog不是Cat类型的实例对象, 返回true
  if (dog is! Cat) {
    print('dog is not Cat type');
  }

  /// `cat is Object?`总是返回true
}

/// 赋值操作符
void assignmentOperators() {
  /// `=` 赋值操作符
  /// 与一系列的与`=`的组合操作符

  /// 基本赋值
  int value = 10;
  var a = value;
  assert(a == value);

  /// 组合赋值
  int? b;

  /// 解包组合赋值
  b ??= value; // b = b ?? value;

  /// 基本运算组合赋值
  b += value; // b = b + value;
  b -= value; // b = b - vlaue;
  b *= value; // b = b * value;
  var c = b.toDouble();
  c /= value; // c = c / value;
  b ~/= value; // b = b ~/ value;
  b %= value; // b = b % value;
  b >>>= value; // b = b >>> value;
  b <<= value; // b = b << value;
  b >>= value; // b = b >> value;
  b ^= value; // b = b ^ value;
  b &= value; // b = b & value;
  b |= value; // b = b | value;
}

/// 逻辑运算操作符
void logicalOperators() {
  /// `!`: 布尔值的转换(flase与true来回转换)
  /// `||`: 逻辑或
  /// `&&`: 逻辑与
  var flagOne = false;
  var flagTwo = true;

  assert(!flagOne == true);
  assert(!flagTwo == false);

  /// 逻辑运算的截断操作,
  /// 当 `&&` 或 `||` 的左侧表达式的结果可以直接确定整个表达式的结果,
  /// 则第二个表达式将不会再执行
  // flagTwo 在编译阶断会提醒就是因为这个原因. flagOne是false, 可以直接决定整个表达式的结果
  assert((flagOne && flagTwo) == false);
  var num = 2;

  /// (++num == 3) 不会执行
  assert((flagOne && (++num == 3)) == false);
  assert(num == 2);

  /// (++num == 3) 不会执行
  assert((flagTwo || (++num == 3)) == true);
  assert(num == 2);

  /// (++num == 3) 会执行
  assert((flagTwo && (++num == 3)) == true);
  assert(num == 3);
}

/// 位运算的操作, 在builtin_types中的`intBitOperation` 有介绍
///
/// 条件表达式
/// 条件表达式就是三元表达式`?:`与可为空对象的变形`??`
void conditionalExpressions() {
  var flag = true;
  var result = flag ? 'FlagIsTrue' : 'FlagIsFalse';
  assert(result == 'FlagIsTrue');

  String initName(String? name) => name ?? 'Guest';
  result = initName(null);
  assert(result == 'Guest');
  result = initName('name');
  assert(result == 'name');
}

extension CatMethod on Cat {
  void run() {
    print('$name is running');
  }
}

/// 层叠符号
void cascadeNotation() {
  // 正常对象的层叠语法 `..`
  var cat = Cat(name: 'name')
    ..run()
    ..sleep();
  print(cat.name);

  // 上面代码等同于下面代码

  var cat1 = Cat(name: 'name1');
  cat1.run();
  cat1.sleep();
  print(cat1.name);

  /// 可为空的对象的层叠的语法,
  /// 第一个操作符替换为`?..`
  /// 后续的操作符继续使用 `..`
  Cat? catNull;
  void initCat() {
    catNull = Cat(name: 'nullable');
  }

  // 在初始化之前catNull不会调用run与sleep方法
  catNull
    ?..run()
    ..sleep();
  initCat();
  print('invoke initCat');
  catNull
    ?..run()
    ..sleep();

  // 上面代码等同于下面的代码

  catNull?.run();
  catNull?.sleep();
}

/// 其他操作符
void otherOperators() {
  // `()`函数调用
  // `[]`下标访问 (Subscript access)
  var list = [1, 2, 3];
  assert(list[1] == 2);
  // `?[]`条件下标访问, 给可为空对象使用
  List<int>? listNullable = [1, 2, 3];
  assert(listNullable?[1] == 2);
  // `.`成员访问(member access)
  // `?.`条件成员访问, 给可为空对象使用
  // `!` 空断言操作符(null assertion operator), 强制访问可为空对象的非空值
}
