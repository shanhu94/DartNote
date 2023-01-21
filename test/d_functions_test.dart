import 'package:test/test.dart';
import 'package:learn/d_functions.dart' as func;

void main() {
  test('functionTour', () {
    func.functionTour();
  });
  test('fucntionParamTour', () {
    func.functionParamTour();
  });
  test('functionAsObject', () {
    func.functionAsObject();
  });
  test('anonymousFunction', () {
    func.anonymousFunctions();
  });
  test('lexicalScope', () {
    func.lexicalScope();
  });
  test('lexicalClosures', () {
    func.lexicalClosures();
  });
  test('returnValue', () {
    func.returnValue();
  });
}
