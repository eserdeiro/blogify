import 'package:blogify/config/constants/strings.dart';
import 'package:formz/formz.dart';

enum EmailError { empty, format }

class Email extends FormzInput<String, EmailError> {
  static final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  const Email.pure() : super.pure('');

  const Email.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    switch (displayError) {
      case EmailError.empty:
        return Strings.required;
      case EmailError.format:
        return "Doesn't have a valid format";
      default:
        return null;
    }
  }

  @override
  EmailError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return EmailError.empty;

    if (!emailRegex.hasMatch(value)) return EmailError.format;
    return null;
  }
}
