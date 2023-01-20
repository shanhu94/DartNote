/// Dart 一些重要点的概括
/// Dart Version: 2.18

/// 1. 声明变量 类型可以自动推断
void declarationVariable() {
  /// 使用var声明的变量, 在编译阶段可自动推断出对应的类型
  var num = 1; // num 在编译时会自动推断为 int 类型
  // num = 'test'; 这类赋值会引起编译错误
  print('num\'s type ${num is int ? '==' : '!='} int');
  int num1 = 1;
  print('num1: $num1');

  /// 使用Object与dynamic声明的变量, 无法在编译阶段推断出对应的类型
  /// 更详细的介绍在下面
  Object num2 = 1;
  print('num2\'s type ${num2 is int ? '==' : '!='} int ');

  dynamic num3 = 1;
  print('num3\'s type ${num3 is int ? '==' : '!='} int ');
}

/// 2. 安全的空类型 (null safety) 2.12版本之前无此功能
void nullSafety() {
  int num = 1;
  // num = null; 引起编译错误, num为int类型, 不能赋值null
  int? num1 = 1;
  num1 = null;
  print('num = $num, num1 = $num1');
  // num = num1; 引起编译错误
  /// 如果你确定一个可能为空的变量, 在你使用时一定不会为空. 可以使用`!`强制取值
  num1 = 10;
  num = num1!; // 注意: 如果此时num1为null, 那么会出现运行时错误
  /// 在当前上下文中, 如果可以直接确认num1存在值, 则可以省略`!`
  num = num1;
  print('num = $num');
}

/// 3. 使用变量承接任何类型, (实际开发中应尽量避免此种开发方法, 因为编译阶段的静态类型检测会失效)
void allowAnyType() {
  int num = 10;
  print(num.toDouble());

  Object obj = 10;
  print('obj = $obj');

  /// obj.toDouble(); 编译错误, Object可以承接所有类型, 但不能调用所有的方法
  /// 但在调用对应类型的方法时, 需要先进行类型判断
  if (obj is int) obj.toDouble();

  obj = 'obj string';
  print('obj = $obj');
  obj = ['item1', 'item2'];
  print('obj = $obj');
  // obj = null; 引起编译错误

  Object? obj1 = null;
  print('obj1 = $obj1');

  dynamic dObj = 20;
  print('dObj = $dObj');

  /// dynamic 在编译时,也可以承接所有类型的数据(包含null), 同时可以调用所有方法.
  /// 但在运行时如果对象没有对应的方法将会抛出异常.
  dObj.toDouble();

  dObj = 'dObj string';
  print('dObj = $dObj');
  // dObj.toDouble(); // 此时dObj为String类型, 没有toDouble方法, 将会在运行时抛出异常
  if (dObj is int) dObj.toDouble(); // dynamic 也可以使用类型判断

  dObj = {'mapKey': 'mapValue'};
  print('dObj = $dObj');
  dObj = null;
  print('dObj = $dObj');
}

/// 4. 支持泛型
void genericTypes() {
  List<int> li = [1, 2, 3, 4];
  print(li);
  List<String> ls = ['s1', 's2', 's3', 's4'];
  print(ls);
  List<Object> lo = ['o1', 1, 'o2', 2.3];
  print(lo);
}

/// 5. 绑定到类的函数(类方法,实例方法), 顶级函数(top-level functions)与嵌套函数
class TestClass {
  static void classMethod() {
    print('调用类方法');
  }

  void instanceMethod() {
    print('调用实例方法');
  }
}

void topLevelFunction() {
  var cls = TestClass();
  cls.instanceMethod();
  TestClass.classMethod();

  void nestedFunction(int p1) {
    print('调用嵌套函数 参数: $p1');
  }

  nestedFunction(10);
}

/// 6. 顶级变量, 绑定到类的变量(类变量或实例变量)
/// 实例变量又称为字段(fileds)或属性(properties)

String topLevelVar = 'top-level variables';

class TestVarClass {
  static String classId = "xxxxxx-xxxxxx";
  String value;
  TestVarClass(this.value);
}

void topLevelVariables() {
  print(topLevelVar);
  var varClass = TestVarClass('instance variables value');

  /// 字符串拼接
  ///   1. 如果拼接的是变量名, 可以直接使用`$`省略`{}`
  ///   2. 如果拼接的是表达式, 则只能使用`${}`, `{}`不能省略
  print('Class: $varClass, Class.value: ${varClass.value}');
}

/// 7. 访问权限, Dart没有`public`, `protected`, `private`这类关键字
/// 使用下划线`_`区分是否是私有标识
var _privateNum = 10;
var publicNum = 20;
void _privateFunction() {
  print('private function');
}

void publicFunction() {
  print('public function');
}

class _PrivateTestClass {
  static void log() {
    print('private test class');
  }
}

class PublicTestClass {
  static void log() {
    print('public test class');
  }
}

void accessPermission() {
  print('------- start library internal access -------');
  print('private num: $_privateNum');
  print('public num: $publicNum');
  _privateFunction();
  publicFunction();
  _PrivateTestClass.log();
  PublicTestClass.log();
  print('------- end library internal access -------');
}

/// 8. 合法的标识符的规则: 首字符以字母`A-Za-z`或下划线`_`开头, 后接`A-Za-z`与`_`与`0-9`
void validIdentifiers() {
  int validVar1 = 0;
  int _validVar1 = 0;
  int _1 = 1;
  // int 1v = 1; 无效的.
  // int 标识符 = 1; 无效的.
  int ABc = 1; // 此种变量名不建议
  print('$validVar1, $_validVar1, $_1, $ABc');

  /// Dart的:
  /// Dart对类成员(class members), 顶级定义(top-level definitions),
  /// 变量(variables), 参数(parameters), 命名参数(named parameters)和命名构造函数(named constructors), 使用`lowerCamelCase`命名规范
  /// `lowerCamelCase`: 应将除第一个单词外的每个单词的首字母大写,并且不使用分隔符.
}
