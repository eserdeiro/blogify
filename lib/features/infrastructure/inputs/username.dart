import 'package:formz/formz.dart';

// Define input validation errors
enum UsernameError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Username extends FormzInput<String, UsernameError> {
  // Call super.pure to represent an unmodified form input.
  //Initial value
  const Username.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.

  const Username.dirty(super.value) : super.dirty();

  // Override validator to handle validating a given input value.

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == UsernameError.empty) return 'Required';
    if (displayError == UsernameError.length) return 'Min 6 characters';

    return null;
  }

  @override
  UsernameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return UsernameError.empty;
    if (value.length < 6) return UsernameError.length;
    return null;
    // return value.isEmpty ? UsernameError.empty : null;
  }
}
