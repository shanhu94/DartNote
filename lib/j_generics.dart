/// 泛型 (Generics)
/// 使用泛型可以减少代码重复
/// 原生的`List`, `Map`, `Set` 都使用了泛型

/// 类使用泛型
/// 泛型也可以进行类型限制, 使用`extends`关键字
class Cache<K extends String, V> {
  final Map<K, V> _cache = {};
  V? value(K key) {
    return _cache[key];
  }

  void setValue(V value, {required K forKey}) {
    _cache[forKey] = value;
  }
}

/// 方法使用泛型
bool equal<T>(T one, T two) {
  return one == two;
}

void accessCache() {
  var l1 = ['String']; // 类型推断`l1`为 `List<String>`类型
  var l2 = <int>[]; // `l2`为 `List<int>`类型
  var s1 = {''}; // 类型推断 `s1`为 `Set<String>`类型
  var s2 = <String>{}; // `s2`为 `Set<String>`类型
  var d1 = {'': 0}; // 类型推断 `d1`为 `Map<String, int>`类型
  var d2 = <String, int>{}; // `d2`为 `Map<String, int>`类型

  /// 自定义泛型类
  var cache = Cache<String, String>();
  cache.setValue('value', forKey: 'forKey');
  // var indexCache = Cache<int, String>(); 编译错误
  assert(equal(1, 1));
  assert(equal('one', 'one'));
  assert(equal(true, true));
}
