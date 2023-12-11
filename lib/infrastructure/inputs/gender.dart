import 'package:formz/formz.dart';

// Define input validation errors
enum GenderError { empty }

// Extend FormzInput and provide the input type and error type.
class Gender extends FormzInput<String, GenderError> {
  // Call super.pure to represent an unmodified form input.
   //Initial value
  const Gender.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
 
  const Gender.dirty(String value) : super.dirty(value);

  // Override validator to handle validating a given input value.

  String? get errorMessage{
    if(isValid || isPure) return null;
    if(displayError == GenderError.empty) return 'Required';

     return null;
  }

  @override
  GenderError? validator(String value) {

      if(value.isEmpty || value.trim().isEmpty) return GenderError.empty;
    return null;
  }
}