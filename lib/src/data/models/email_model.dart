import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

class EmailModel extends FormzInput<String, String> {
  const EmailModel.pure() : super.pure(null);
  const EmailModel.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    if (value?.isEmpty == true) {
      return 'Email field is required';
    }

    if (value?.isNotEmpty == true && !isEmail(value?.trim())) {
      return 'Email is not valid';
    }
    return null;
  }
}
