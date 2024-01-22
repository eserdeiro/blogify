import 'package:blogify/config/constants/strings.dart';
import 'package:formz/formz.dart';

enum LastNameError { empty }

class Lastname extends FormzInput<String, LastNameError> {
  const Lastname.pure() : super.pure('');

  const Lastname.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == LastNameError.empty) return Strings.required;

    return null;
  }

  @override
  LastNameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return LastNameError.empty;
    return null;
  }
}
