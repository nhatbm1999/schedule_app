import 'package:formz/formz.dart';
import 'package:schedule_app/login/extension.dart';
enum EmailValidationError {empty}

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    return value.isValidEmail() ? null : EmailValidationError.empty;
  }
}