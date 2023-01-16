import 'dart:math';

/// Dart 变量

/// 变量的声明
var name = 'Demo';
String name1 = 'Demo';
Object name2 = 'Demo';
/// 以上三种情况, 都可以声明一个字符串变量.
/// 具体使用哪一个官方有一个部分文章介绍了这里: (https://dart.dev/guides/language/effective-dart/design#types)

/// 1. 变量的默认值
void variableDefaultValue() {
  int? num;
  print('num = $num');
  int num1;
  // print('num1 = $num1'); 直接使用会编译错误, 需要在使用前初始化变量
  num1 = 1;
  print('num1 = $num1');
  int num2 = 2; //也可以在声明时直接初始化变量
  print('num2 = $num2');
}
/// 顶级变量与类变量是延迟初始化, 只有在第一次使用时会执行初始化的代码

/// 2. 用late修饰变量
/// 使用场景有两处
/// 1. 想要声明一个非空变量, 但需要在其他位置初始化这个变量
/// 2. 延迟初始化一个变量
void lateVariables() {
  int num;
  num = 1;
  print('num = $num');

  late int num1;
  void initNum1() {
    num1 = 2;
  }
  initNum1();
  /// 这种对非空变量的赋值方式, 则无法编译通过, 需要使用late声明
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

class ConClass {
  final String name;
  final String value;
  const ConClass(this.name, this.value);
}
void finalVariables() {
  final name = 'Name';
  final String name1 = 'Name1';
  // name = 'Other Name'; 编译错误, final只能被初始化一次
  final String name2;
  if (Random().nextInt(2) == 1) {
    name2 = 'Random Name1'; 
  } else {
    name2 = 'Random Name2';
  }
  print('final test -- name: $name, name1: $name1, name2: $name2');

  final vc = VarClass('name', 'value');
  // vc = VarClass('other name', 'other value'); 编译错误
  // vc.name = 'other name'; 编译错误 name也是final修饰
  vc.value = 'other value';
}

void constVariables() {
  const name = 'Name';
  const String name1 = 'Name1';
  // name = 'Other Name'; 
  // const String name2; 编译错误, const修饰,声明时需要初始化
  print('const test -- name: $name, name1: $name1');

  const vc = const ConClass('name', 'value');
  // vc = const ConClass('other name', 'other value');
  // vc.name = 'other name';
  // vc.value = 'other value';
}

