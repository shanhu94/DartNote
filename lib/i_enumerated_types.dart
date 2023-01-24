import 'dart:math';

/// 枚举 (enum)
/// 枚举的语法与正常的类(class)相似, 只有以下不同点
/// 1. 实例变量必须使用final修饰
/// 2. 构造函数必须是const修饰
/// 3. 工厂构造函数只能返回一个已知的枚举实例
/// 4. 枚举不能使用继承 `extends`
/// 5. 不能重写 `index`, `hashCode`, `==`
/// 6. `values` 不能在枚举内声明, 会与自动生成的类变量冲突
/// 7. 枚举的所有实例, 必须在开头声明, 并且至少声明一个实例

abstract class Compare<T> {
  bool equalTo(T other);
}

enum Color implements Compare<Color> {
  /// 所有实例声明在开头
  white(0xFF, 0xFF, 0xFF, 1),
  black(0x00, 0x00, 0x00, 1),
  red(0xFF, 0x00, 0x00, 1),
  green(0x00, 0xFF, 0x00, 1),
  blue(0x00, 0x00, 0xFF, 1);

  /// 工厂构造函数内只能返回已知的枚举实例
  factory Color.random() {
    if (Random().nextBool()) {
      return Color.black;
    } else {
      return Color.white;
    }
  }

  const Color(
    this.r,
    this.g,
    this.b,
    this.a,
  );

  final int r;
  final int g;
  final int b;
  final double a;

  @override
  bool equalTo(Color other) {
    return r == other.r && g == other.g && b == other.b && a == other.a;
  }
}

void accessEnum() {
  var red = Color.red;

  /// index 从0开始自增
  assert(red.index == 2);
  assert(Color.white.index == 0);
  assert(Color.black.index == 1);

  assert(Color.red.r == 0xFF);
  assert(Color.white.r == 0xFF);
  assert(Color.white.g == 0xFF);
  assert(Color.white.b == 0xFF);

  var colors = Color.values;
  for (var item in colors) {
    print('$item -- ${item.name}');
  }

  print(Color.random());

  /// 枚举构造函数不能直接使用, 使用工厂构造函数或枚举实例
  // print(Color(0x0F, 0x0F, 0x0F, 1));
}
