import 'dart:math';

/// Dart 变量

/// 变量的声明
/// 顶级变量与类变量是延迟初始化, 只有在第一次使用时会执行初始化的代码
var name = 'Demo';
String name1 = 'Demo';
Object name2 = 'Demo';
dynamic name3 = 'Demo';

/// 以上四种情况, 都可以声明一个字符串变量.
/// 具体使用哪一个官方有一个部分文章介绍了这里: (https://dart.dev/guides/language/effective-dart/design#types)

/// 1. 变量的默认值
void variableDefaultValue() {
  int? num;
  print('num = $num');
  int num1;
  // print('num1 = $num1'); 直接使用会编译错误, 需要在使用前初始化变量
  /// 在相同的函数体中, 可以将num1的声明和初始化拆开写
  num1 = 1;
  print('num1 = $num1');
  int num2 = 2; //也可以在声明时直接初始化变量
  print('num2 = $num2');
}

/// 2. 用late修饰变量
/// 使用场景有两处
/// 1) 想要声明一个非空变量, 但需要在其他位置初始化这个变量
/// 2) 延迟初始化一个变量
void lateVariables() {
  int num;
  num = 1;
  print('num = $num');

  late int num1;
  void initNum1() {
    num1 = 2;
  }

  /// 这种对非空变量的赋值方式, 则无法编译通过, 需要使用late声明
  initNum1();
  print('num = $num1');

  /// 如果你能确定一个变量在你使用之前, 你可以对这个变量初始化, 但dart编译不通过.
  /// 此时你可以使用late修饰变量.
  /// **注意**: 通过late修饰的变量, 在使用如果该变量还没有初始化, 则会报一个运行时的错误
}

/// 3. 使用final或const修饰的变量
/// final变量只可能被初始化一次, const变量是编译时的常量
/// 注意点:
///   类的实例变量可以使用final修饰, 但不能用const修饰
class VarClass {
  final String name;
  String value;
  VarClass(this.name, this.value);
}

void finalVariables() {
  /// 可以省略类型名称, 由值推断出变量的类型
  final name = 'Name';
  final String name1 = 'Name1';
  // name = 'Other Name'; 编译错误, final只能被初始化一次

  /// 虽然只能则值一次, 但可以将变量声明与初始化分开写.
  final String name2;
  if (Random().nextInt(2) == 1) {
    name2 = 'Random Name1';
  } else {
    name2 = 'Random Name2';
  }
  print('final test -- name: $name, name1: $name1, name2: $name2');

  /// final修饰的变量, 本身不能赋值新值, 但变量的子属性可以正常修改
  final vc = VarClass('name', 'value');
  // vc = VarClass('other name', 'other value'); 编译错误
  // vc.name = 'other name'; 编译错误 name也是final修饰
  vc.value = 'other value';
}

class ConClass {
  final String name;
  final String value;

  /// const 修饰的构造方法
  const ConClass(this.name, this.value);
}

void constVariables() {
  const name = 'Name';
  const String name1 = 'Name1';
  // name = 'Other Name';
  // const String name2; 编译错误, const修饰,声明时需要初始化
  print('const test -- name: $name, name1: $name1');

  /// 如果一个Const变量需要承接类的实例变量, 则该类需要有const修饰的构造方法
  /// const 修饰的变量, 本身不能赋值新值, 变量的子属性也不能赋值新值
  const vc = ConClass('name', 'value');
  // vc = ConClass('other name', 'other value');
  // vc.name = 'other name';
  // vc.value = 'other value';
  print('const vc name: ${vc.name}, value: ${vc.value}');
}
