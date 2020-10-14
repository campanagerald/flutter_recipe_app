import 'package:formz/formz.dart';

class LastNameModel extends FormzInput<String, String> {
  const LastNameModel.pure() : super.pure(null);
  const LastNameModel.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    if (value?.isEmpty == true) {
      return 'Last name field is required';
    }

    return null;
  }
}
