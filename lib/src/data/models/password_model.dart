import 'package:formz/formz.dart';

class PasswordModel extends FormzInput<String, String> {
  const PasswordModel.pure() : super.pure(null);
  const PasswordModel.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    if (value?.isEmpty == true) {
      return 'Password field is required';
    }

    return null;
  }
}
