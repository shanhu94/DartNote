import 'dart:ffi';
import 'dart:math';

/// 枚举的声明, 只能放在顶级
enum Sex {
  other,
  male,
  female,
  mix,
}

/// 类的声明, 只能放在顶级
class Person {
  /// 不为空的实例变量, 无任何修饰符, 需要在属性初始化列表赋值, 赋值后可以二次修改
  /// 名称
  String name;

  /// final修饰的不为空的变量, 需要在属性初始化列表中赋值或在声明中赋值, 赋值后无法修改
  /// 性别
  final Sex sex;

  // late与final修饰的变量, 可以不用在构造方法中初始化, 但需要在使用前初始化, 初始化后不能修改
  late final int height;

  /// 可为空的实例变量, 可以不用在构造方法中赋值, 因为存在默认值 `null`
  int? ageNullable;

  /// late修饰的不可为空变量, 可以不用在构造方法中初始化, 但需要在使用前初始化
  /// 如果使用该变量时, 还未初始化, 则会报运行时错误
  late int age;

  /// 正常的实例构造方法
  // Person(String name, Sex sex)
  //     : name = name,
  //       sex = sex {
  //   print('Normal Constructor name:${this.name} sex:${this.sex}');
  // }

  /// Dart有上方方法的更简便的方法
  /// `this`关键字: 在类内部引用当前的实例变量
  Person(this.name, this.sex) {
    print('Normal constructor name:$name sex: $sex');
  }

  /// 命名构造方法 (Named constructors)
  /// `:` 后面, 方法体`{}`前面的部分是`属性初始化列表(Initializer list)`, 用`,`分割
  /// 属性初始化列表中可以添加assert进行值校验(在开发环境下生效),
  /// 如果调用`super`需要将`super`放到最后
  Person.fromMap(Map<String, dynamic> map)
      : assert(map['name'].length > 0),
        name = map['name'],
        sex = map['sex'] {
    print('Named constructor name: $name sex: $sex');
  }

  /// 构造方法的重定向(Redirecting constructors)
  /// 重定向方法不能有方法体
  Person.fromName(String name) : this(name, Sex.other);

  /// 普通的实例方法, 可以访问实例变量与`this`
  void logInfo() {
    print('$name: sex: $sex');
  }
}

/// 类的继承, 使用`extends`关键字
class Student extends Person {
  /// 实例变量
  int studentNumber;

  /// 实例变量, 记录书名
  Set<String> bookNames = {};

  /// 类变量
  static final Map<String, Student> _studentList = <String, Student>{};

  /// 构造方法不能直接继承, 需要子类手动实现, 并调用父类的方法
  /// 如果子类不实现构造方法, 只能继承默认的构造方法,

  /// 默认构造方法(无参数, 无名称)
  // Student() : super('None', Sex.other) {
  //   print('Student subclass invoke default constructor');
  // }

  /// 手动实现构造方法, 调用父类的非默认构造方法
  // Student(String name, Sex sex) : super(name, sex) {
  //   print('Student constructor: name: $name, sex: $sex');
  // }
  /// 上面的方法, 也有简略的写法 (此形式需要在Dart 2.17之后的版本)
  Student(super.name, super.sex, this.studentNumber) {
    print('Student constructor: name: $name, sex: $sex, $studentNumber');
  }

  /// 也可以手动调用命名参数 与 调用父类的非默认构造参数
  // Student.fromMap(Map<String, dynamic> map) : super.fromMap(map);
  /// 也可以省略下参数
  Student.fromMap(super.map)
      : studentNumber = map['studentNumber'],
        super.fromMap() {
    print('Student name constructor: name: $name sex: $sex');
  }

  /// 工厂构造方法(Factory constructors)
  /// 此种构造方法的方法体内不能使用 `this`
  /// 方法内部可以调用该类的构造方法, 也可以调用子类的构造方法
  factory Student.fromCache(String name) {
    return _studentList.putIfAbsent(
        name, () => Student(name, Sex.other, _studentList.length));
  }

  /// 方法声明
  /// 实例方法, 可以访问实例变量与`this`

  /// 普通的实例方法
  bool readBook(String bookName) {
    return bookNames.add(bookName);
  }

  /// 重写父类的实例方法, 需要在方法前添加`@override`
  @override
  void logInfo() {
    /// 使用`super`调用到父类的实例方法
    /// 在一些情况下也可以不调用父类的方法
    // super.logInfo();
    print('Student: \n name: $name \n sex: $sex');
  }

  /// 实例方法: 运算符方法(Operators)
  /// 可用的运算符列表在 https://dart.dev/guides/language/language-tour#methods
  bool operator <<(String bookName) {
    return bookNames.add(bookName);
  }

  /// 实例方法: get方法
  int get bookCounts => bookNames.length;

  /// 实例方法: 重写运算符方法
  /// 运算符列表中没有`!=`, 因为在dart中, `!=`是语法糖, 原型是 `!(a == b)`
  @override
  bool operator ==(Object other) {
    return other is Student && other.name == name && other.sex == sex;
  }

  /// 实例方法: 重写get方法
  @override
  int get hashCode => Object.hash(name, sex);
}

/// 如果一个类支持 Constant constructors
/// 那该类的所有实例变量都是不可变的
///   1. 使用`final`修饰: 在初始化时设置后, 就无法再进行修改
///   2. 使用`const`修饰: 需要在变量声明时,直接进行初始化
class ImmutablePoint {
  final double x;
  final double y;

  /// 恒定的构造方法 (Constant constructors)
  ///   在构造方法前添加 `const` 关键字
  const ImmutablePoint(this.x, this.y);

  /// 不可变类变量
  static const ImmutablePoint origin = ImmutablePoint(0, 0);
}

/// 类构造函数
void accessConstructors() {
  var p1 = Person('A1', Sex.male);
  var p2 = Person.fromMap({'name': 'A1', 'sex': Sex.male});
  var p3 = Person.fromName('A1');
  assert(p1.name == p2.name);
  assert(p1.name == p3.name);
  assert(p1.sex == p2.sex);

  var s1 = Student('S1', Sex.female, 1);
  var s2 = Student.fromMap({'name': 'S1', 'sex': Sex.male, 'studentNumber': 1});
  // 工厂构造方法的使用方式, 与其他构造方法一致
  var s3 = Student.fromCache('S1');
  assert(s1.name == 'S1' && s1.sex == Sex.female && s1.studentNumber == 1);
  assert(s2.name == 'S1' && s2.sex == Sex.male && s2.studentNumber == 1);
  assert(s3.name == 'S1');

  var point = ImmutablePoint(1, 2);
  point = ImmutablePoint(2, 4); // point可以修改
  // point.x = 1; 编译错误
  // point.y = 1; 编译错误
  assert(point.x == 2 && point.y == 4);
  assert(ImmutablePoint.origin.x == 0 && ImmutablePoint.origin.y == 0);
}

void accessMethod() {
  var s1 = Student('S', Sex.male, 1);
  var s2 = Student('S', Sex.female, 1);
  assert(s1 != s2);
  assert((s1 == s2) == false);

  assert(s1.bookCounts == 0);
  s1.readBook('B1'); // 调用正常方法
  assert(s1.bookCounts == 1);
  s1 << 'B2'; // 调用运算符方法
  assert(s1.bookCounts == 2);

  s1.logInfo();
  var p = Person('P1', Sex.male);
  p.logInfo();
}

/// 抽象类 (Abstract classes)
/// 抽象类不能用于实例化对象
/// 一般用于声明接口, 有时也会有一些默认实现
/// 如果想使抽象类看起来可实例化, 可以使用工厂构造方法
abstract class TableDataSource {
  int get itemNumbers;
  void configItem(int index);
  void logItem(int index);

  /// 抽象类中的工厂构造方法
  factory TableDataSource(String type, int line, String graph) {
    if (type == 'triangle') {
      return TriangleGraph(line, graph);
    } else {
      throw 'Unknown graph';
    }
  }
}

/// 表格
class Table {
  TableDataSource? dataSource;

  Table([this.dataSource]);

  /// 模拟Table
  void loadTable() {
    int count = dataSource?.itemNumbers ?? 0;
    if (count == 0) {
      return;
    }
    for (int i = 0; i < count; i++) {
      dataSource?.configItem(i);
      dataSource?.logItem(i);
    }
  }
}

/// 列表构建的数据源实现
class TriangleGraph implements TableDataSource {
  int line;
  String graph;
  List<String> stars = [];
  TriangleGraph(this.line, this.graph) {
    stars = [for (var i = 0; i < line; i++) ''];
  }

  @override
  int get itemNumbers => line;

  @override
  void configItem(int index) {
    stars[index] = graph * index;
  }

  @override
  void logItem(int index) {
    print(stars[index]);
  }
}

void accessAbstractClass() {
  /// 正常初始化与赋值
  var graph = TriangleGraph(20, '*');
  var table = Table(graph);
  table.loadTable();

  /// 使用抽象类的工厂构造方法
  Table(TableDataSource('triangle', 10, '=')).loadTable();
}

/// 隐式接口 (Implicit interfaces)
class Implicit {
  /// 属性, 算隐式接口
  String text;

  /// 构造方法, 不算隐式接口
  Implicit({required this.text});
}

class ImplicitInterfaces {
  /// 属性, 算隐式接口
  String realText;

  /// 构造方法, 不算隐式接口
  ImplicitInterfaces(this.realText);

  /// 方法, 算隐式接口
  String compact(String left, String right) {
    return left + realText + right;
  }
}

/// 使用 `extends` 是继承类
/// 使用 `implements` 是实现接口, 实现多个接口用 `,` 分割
class ImplicitClass extends Implicit
    implements ImplicitInterfaces, TableDataSource {
  /// 继承构造方法, 同时初始化`ImplicitInterfaces`接口中属性值
  ImplicitClass({required super.text}) : realText = text;

  /// 实现 ImplicitInterfaces 的隐式接口
  @override
  String realText;

  /// 实现 ImplicitInterfaces 的隐式接口
  @override
  String compact(String left, String right) {
    return 'Implicit class: $left $realText $right';
  }

  /// TableDataSource 抽象类接口
  @override
  int get itemNumbers => 10;
  @override
  void configItem(int index) {}
  @override
  void logItem(int index) {}
}

void implicitInterfaces() {
  var inter = ImplicitInterfaces('ImplicitInterfacesText');
  var cls = ImplicitClass(text: 'ImplicitClassText');
  print(inter.compact('left', 'right'));
  print(cls.compact('left', 'right'));
}
