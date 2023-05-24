import 'package:trabalho/main.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  test('Non-null string without "@" should be invalid', () {
    expect(Utils.isValidEmail('testEmail'), false);
  });

  test('Non-null string with "@" but no "." should be invalid', () {
    expect(Utils.isValidEmail('testEmail@test'), false);
  });

  test('Non-null string with "@" and "." should be valid', () {
    expect(Utils.isValidEmail('testEmail@test.com'), true);
  });

}
