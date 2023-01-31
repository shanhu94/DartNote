
import 'dart:mirrors';

/// 元数据 (Metadata)
/// 用来提供代码的附加信息
/// 元数据注释以@开头, 后接'编译时常量(const修饰)'或'常量构造函数的调用'

/// 自定义元数据
class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}

@Todo('Television', 'class')
class Television {

  /// Dart 三种内置的 元数据(metadata)
  /// @Deprecated, @deprecated @override 
  @Deprecated('use turnOn instead')
  @Todo('active', 'method') 
  void active(@Todo('Parameter', 'int a') int a) {
    turnOn();
  }

  @Todo('inactive', 'Implement this function')
  void inactive() {

  }

  void turnOn() {
    
  }
}

void useMetadata() {
  /// 读取元数据注释
  final ins = reflectClass(Television);
  for (final element in ins.metadata) {
    print('${element.reflectee.who} - ${element.reflectee.what}');
  }
  ins.declarations.forEach((key, value) {
    if (value is MethodMirror) {
      for (final meta in value.metadata) {
        if (meta.reflectee is Todo) {
          print('${meta.reflectee.who} -- ${meta.reflectee.what}');
        } else if (meta.reflectee is Deprecated) {
          print('${meta.reflectee.message}');
        }
      }
      for (final param in value.parameters) {
        print('${param.simpleName}');
        for (final meta in param.metadata) {
          if (meta.reflectee is Todo) {
            print('${meta.reflectee.who} -- ${meta.reflectee.what}');
          }
        }
      }
    }
    print('-------- Next Method ----------');
  });
}