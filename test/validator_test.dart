import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker/app/sign_in/vakidators.dart';

void main() {
  test('non emppty string', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid('test'), true);
  });
  test('emppty string', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid(''), false);
  });
 
  test('null string', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid(null), false);
  });
}
