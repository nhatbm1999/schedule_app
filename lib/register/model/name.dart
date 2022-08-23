import 'package:formz/formz.dart';

enum NameValidatorError { empty }

class Name extends FormzInput<String, NameValidatorError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidatorError? validator(String value) {
    return value.isNotEmpty ? null : NameValidatorError.empty;
  }
}
