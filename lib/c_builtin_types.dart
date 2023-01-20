import 'dart:math';

/// 内建类型
/// int, double, String, bool, List, Set, Map, Runes, Symbols, Null
///
/// 一些其他类型的特殊作用
/// Object: Dart中除了Null类型之外的所有类的超类
/// Enum: 所有枚举的超类
/// Future & Stream: 异步中使用
/// Iterable: 在for-in循环中与`Synchronous generator functions`
/// Never: 表示表达式永远不能成功地完成求值。最常用于总是抛出异常的函数。
/// dynamic: 表示你不想要使用静态类型检测功能, 通常可以使用`Object`或`Object?`代替
/// void: 通常用于方法返回的类型

/// Numbers(int & double) 类型
void numbers() {
  /// 有两种number类型
  /// int的取值范围 -2^63 ... 2^63 - 1
  int minNum = -pow(2, 63).toInt();
  int maxNum = (pow(2, 63) - 1).toInt();
  print('min num: $minNum, max num: $maxNum');

  /// 在Web平台, int使用的JS中的64位浮点类型的整数部分
  /// 所以int的取值范围是 -2^53 ... 2^53 - 1
  int jsMinNum = -pow(2, 53).toInt();
  int jsMaxNum = (pow(2, 53) - 1).toInt();
  print('js min num: $jsMinNum, js max num: $jsMaxNum');

  /// 整数与浮点数的写法(integer literals and double literals)
  var dec = 1;
  // dec = 1.1; 编译错误, dec被类型推断为int类型, 不能设置浮点数
  var hex = 0xDEF123;
  var float = 1.1;
  var float1 = 1.42e5;
  print('$dec, $hex, $float, $float1');

  /// 整数与浮点数的声明也可以使用`num`承接
  /// num可以同时设置整数与浮点数
  num x = 1;
  x += 2.5;
  print('num : $x');

  /// f 与 f1 的声明是一样的.
  /// 当指定变量为浮点类型时, 使用整数初始化时会自动转换成浮点数
  double f = 1;
  double f1 = 1.0;
  print('f: $f, f1: $f1');
}

/// 字符串(String)与数字(Numbers)的互换逻辑
void numbersAndString() {
  /// 字符串(String) --> 整数(int)
  var one = int.parse('1');
  assert(one == 1);

  /// 字符串(String) --> 浮点数(double)
  var onePointOne = double.parse('1.1');
  assert(onePointOne - 1.1 < 0.000001);

  /// 整数(int) --> 字符串(String)
  var oneAsString = 1.toString();
  assert(oneAsString == '1');

  /// 浮点数(double) --> 字符串(String)
  var piAsString = 3.14159.toString();
  assert(piAsString == '3.14159');
  piAsString = 3.14159.toStringAsFixed(2);
  assert(piAsString == '3.14');
}

/// 整数的位操作
void intBitOperation() {
  /// 左移 - 缺失的数使用0补齐
  /// 0011 << 1 == 0110
  assert((3 << 1) == 6);

  /// 右移 - 缺失的数使用符号位的数补齐, 正数时符号位是0, 负数时符号位是1
  /// 整数的最高位是符号位
  /// 十六进制 = 十进制
  /// 0x1 = 1
  /// 0xFFFF_FFFF_FFFF_FFFF = -1
  /// 0x8000_0000_0000_0000 = -(2^63)

  /// 0011 >> 1 == 0001
  assert((3 >> 1) == 1);

  /// 右移
  /// 0xFFFF_FFFF_FFFF_FFFE >> 1 = 0xFFFF_FFFF_FFFF_FFFF
  assert((-2 >> 1) == -1);

  /// 无符号右移 >>>
  /// 0011 >>> 1 == 0001;
  assert((3 >>> 1) == 1);

  /// 0xFFFF_FFFF_FFFF_FFFE >>> 1 = 0x7FFF_FFFF_FFFF_FFFF
  assert((-2 >>> 1) == 0x7FFFFFFFFFFFFFFF);

  /// 按位或
  /// 0011 | 0100 == 0111
  assert((3 | 4) == 7);

  /// 按位与
  /// 0011 & 0100 == 0000
  assert((3 & 4) == 0);

  /// 按位异或
  /// 0011 ^ 0110 == 0101
  assert((3 ^ 6) == 5);

  /// 按位取反 | 补数
  /// ~0x0000_0000_0000_0001 == 0xFFFF_FFFF_FFFF_FFFE == -2
  assert(~1 == 0xFFFFFFFFFFFFFFFE);
  assert(~1 == -2);
}

void stringLiteral() {
  /// 单行字符串
  var s1 = 'Single quotes \'\'';
  var s2 = "Double quotes \"\"";
  var s3 = 'Mix "double quotes"';
  var s4 = "Mix 'signle quotes'";
  print(s1);
  print(s2);
  print(s3);
  print(s4);

  /// 字符串插值
  /// ${}, 如果插入的是表达式(expression) `{}`不能省略
  /// ${}, 如果插入的是标识符(identifier) `{}`可以省略
  /// ${}. 本质是调用对象的toString方法
  var lS1 = s1.toLowerCase();
  var iS1 = 'insert s1: $lS1';
  var iS1_1 = 'insert s1: ${s1.toLowerCase()}';
  assert(iS1 == iS1_1);

  /// 多行字符串
  var mS1 = '''
1.
2.
''';
  assert(mS1 == '1.\n2.\n');

  var mS2 = """
1.
2.
""";
  assert(mS2 == "1.\n2.\n");

  /// 原始字符串(raw string), 添加`r`前缀
  var rs = r'\n, \t, \"';
  assert(rs == '\\n, \\t, \\"');

  /// 常量(const)字符串, 插入的对象也心须是常量对象
  const aConstNum = 0;
  const aConstBool = true;
  const aConstString = 'a constant string';
  const insertString = '$aConstNum, $aConstBool, $aConstString';
  print(insertString);
  // const errorString = '$s1, $s2, $s3'; 编译错误
}

void booleans() {
  /// 布尔类型(bool) , 只有两个值, true 与 false
  /// if 与 assert 只能使用布尔类型判断
  var flag = true;
  if (flag) {
    print(flag);
  }
  var s1 = 'string';
  // if (s1) { 编译错误
  // }
  if (s1.isNotEmpty) {
    print(s1);
  }
}

void lists() {
  var emptyList = <String>[];
  var list = [1, 2, 3]; // list 的类型是 List<int>
  list = [
    1,
    2,
    3,
  ]; // 最后一个元素的`,`可有可无, 对数组无影响

  /// list 添加, 移除, 查找下标相关方法
  // list.add('value'); 编译错误, 只能添加int类型数据
  list.add(4);
  var index = list.indexOf(4);
  list.removeAt(index);

  /// 数组的长度与数组的取值
  assert(list.length == 3);
  assert(list[0] == 1);
  assert(list[1] == 2);
  assert(list[2] == 3);

  /// 展开操作符 (spread operator) `...`
  /// 空对象展开操作符 (null-aware spread operator) `...?`
  var list2 = [0, ...list];
  assert(list2.length == 4);

  List<int>? nullableList;
  void initNullableList() {
    nullableList = [1, 2, 3];
  }

  initNullableList();
  // var list3 = [0, ...nullAbleList]; 编译错误
  var list3 = [0, ...?nullableList];
  assert(list3.length == 4);

  /// `collection if` and `collection for`
  var flag = true;
  var strList = ['Home', 'Favourite', if (flag) 'Mine'];
  assert(strList.length == 3);
  var strList2 = ['#0', for (var i in list) '#$i'];
  assert(strList2[1] == '#1');
  assert(strList2.length == 4);
}

void sets() {
  /// 创建集合
  var card = {'1', '2', '3', '4'};
  card.add('5');

  /// 创建空集合
  var names = <String>{};
  Set<String> names1 = {};
  assert(names.length == names1.length);

  /// Set 也支持 `...`, `...?`, `collection if`, `collection for`
}

/// 映射(Map)
void maps() {
  var level = {
    1: 'small',
    2: 'medium',
    3: 'large',
  }; // level 类型推断为 Map<int, String>

  var dict = {
    // Key: Value
    'title': 'Main',
  }; // dict 类型推断为 Map<String, String>

  /// Map的其他创建方法
  var dict1 = Map<String, String>();
  var dict2 = <String, String>{};
  // new 是可选的, 详细介绍在后面的类的构造方法模块(constructors)
  var dict3 = new Map<String, String>();

  /// Map添加值/修改值
  dict['title'] = 'main';
  assert(dict['title'] == 'main');
  dict1['title'] = 'Main';
  assert(dict['title'] == 'Main');

  /// Map取值
  var value = dict['title'];
  assert(value == 'main');

  /// Map也支持 `...`, `...?`, `collection if`, `collection for`
  var spreadMap = {...dict, 'content': 'empty'};
  var cIfmap = {
    'content': 'empty',
    if (dict.isNotEmpty) ...dict,
  };
  var cForMap = {
    'content': 'empty',
    for (var obj in dict.entries) obj.key: obj.value,
  };
  assert(spreadMap.length == cIfmap.length);
  assert(cIfmap.length == cForMap.length);
}

/// Runes and grapheme clusters

