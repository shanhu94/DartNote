import 'dart:math';

void throwException() {
  /// 简单的`try catch`与`throw`的配合
  try {
    throw 'Runtime error';
  } catch (e) {
    print(e);
  }

  /// 捕获不同类型的错误 与 `rethrow`, `finally`关键字的使用
  try {
    var flag = Random().nextInt(3);
    if (flag == 0) {
      throw FormatException('Format Exception');
    } else if (flag == 1) {
      throw UnimplementedError();
    } else if (flag == 2) {
      throw TypeError();
    }
  } on FormatException catch (e) {
    print('FError detail: $e');
  } on UnimplementedError catch (e, s) {
    print('Error detail:\n $e');
    print('Stack trace:\n $s');
  } catch (e) {
    print('Error detail:\n $e');

    /// 如果相要把捕获的异常继续向上抛出, 使用`rethrow`
    rethrow;
  } finally {
    /// `finally` 中的方法, 不论是否发生异常, 都会正常调用
    /// 一般可以用来清除一些需要释放的数据
    print('finally function body');
  }
}
