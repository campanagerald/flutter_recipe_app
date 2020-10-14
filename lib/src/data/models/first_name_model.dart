import 'package:formz/formz.dart';

class FirstNameModel extends FormzInput<String, String> {
  const FirstNameModel.pure() : super.pure(null);
  const FirstNameModel.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    if (value?.isEmpty == true) {
      return 'First name field is required';
    }

    return null;
  }
}
