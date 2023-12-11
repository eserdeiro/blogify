import 'package:formz/formz.dart';

// Define input validation errors
enum NameError { empty }

// Extend FormzInput and provide the input type and error type.
class Name extends FormzInput<String, NameError> {
  // Call super.pure to represent an unmodified form input.
   //Initial value
  const Name.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
 
  const Name.dirty(String value) : super.dirty(value);

  // Override validator to handle validating a given input value.

  String? get errorMessage{
    if(isValid || isPure) return null;
    if(displayError == NameError.empty) return 'Required';

     return null;
  }

  @override
  NameError? validator(String value) {

      if(value.isEmpty || value.trim().isEmpty) return NameError.empty;
    return null;
  }
}