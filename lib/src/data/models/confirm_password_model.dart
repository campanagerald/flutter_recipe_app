import 'package:formz/formz.dart';

class ConfirmPasswordModel extends FormzInput<List<String>, String> {
  const ConfirmPasswordModel.pure() : super.pure(const [null, null]);
  const ConfirmPasswordModel.dirty([List<String> values = const ['', '']])
      : super.dirty(values);

  @override
  String validator(List<String> values) {
    final password = values[0];
    final confirmPassword = values[1];

    if (confirmPassword?.isEmpty == true) {
      return 'Confirm password field is required';
    }

    if (password != confirmPassword) {
      return 'Password do not matched';
    }

    return null;
  }
}
