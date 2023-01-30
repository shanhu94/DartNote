/// Callable classes
///  当类实现`call`函数, 可以让类的实例变量像函数一样被调用
/// 

class TimeFormatter {
  String call({required int hour, required int minute, required int seconds}) {
    return '$hour:$minute:$seconds';
  }
}

void useCallable() {
  final formatter = TimeFormatter();
  print(formatter(hour: 10, minute: 33, seconds: 55));
}