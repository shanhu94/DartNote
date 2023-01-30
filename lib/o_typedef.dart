import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// 类型别名 (typedefs)
/// 

typedef IntList = List<int>;

void useIntList() {
  Object list = [1, 2, 3, 4];
  if (list is IntList) {
    print(list);
  }
}