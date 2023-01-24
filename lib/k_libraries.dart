/// 导入库, 使用`import`关键字
///
/// 导入官方`math`库
/// 引号中是URI路径
/// 对于官方内建的库, 使用`dart`做scheme
/// 对于从包管理工具(package manager)中导入的库, 使用`package`做scheme
/// 其他情况可以使用文件系统路径(file system path)导入库
import 'dart:math';

/// 使用文件系统路径导入
/// 两个文件同级, 直接使用文件名
import 'h_classes.dart';

/// 如果引入的库存在方法或名称冲突, 可以添加一个前缀
/// 使用 `fi.xxxx` 调用`dart:ffi`内的方法,
import 'dart:ffi' as fi;

/// 如果只想引入库的一部分, 或排除某一部分

/// 只导入`e_operator`中的 `arithmeticOperators`
import 'e_operators.dart' show arithmeticOperators;

/// 导入`e_operators`中除了`equalityAndRelationalOperators`的所有内容
import 'e_operators.dart' hide equalityAndRelationalOperators;

/// 有关库的创建与文件层级 `export`的使用
/// 参考 https://dart.dev/guides/libraries/create-library-packages
