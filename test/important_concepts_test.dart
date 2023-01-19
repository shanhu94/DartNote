import 'package:learn/1_important_concepts.dart' as ic;
import 'package:test/test.dart';

void main() {
  test('declarationVariable', () {
    ic.declarationVariable();
  });
  test('nullSafety', () {
    ic.nullSafety();
  });
  test('allowAnyType', () {
    ic.allowAnyType();
  });
  test('genericTypes', () {
    ic.genericTypes();
  });
  test('topLevelFunction', () {
    ic.topLevelFunction();
  });
  test('topLevelVariables', () {
    ic.topLevelVariables();
  });
  test('accessPermission', () {
    print('------- start library access -------');
    // print('private num: ${ic._privateNum}'); 编译错误
    print('public num: ${ic.publicNum}');
    // ic._privateFunction(); 编译错误
    ic.publicFunction();
    // ic._PrivateTestClass.log(); 编译错误
    ic.PublicTestClass.log();
    print('------- end library access -------');
    ic.accessPermission();
  });
}
