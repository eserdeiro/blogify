import 'package:formz/formz.dart';

// Define input validation errors
enum LastNameError { empty }

// Extend FormzInput and provide the input type and error type.
class LastName extends FormzInput<String, LastNameError> {
  // Call super.pure to represent an unmodified form input.
   //Initial value
  const LastName.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
 
  const LastName.dirty(String value) : super.dirty(value);

  // Override validator to handle validating a given input value.

  String? get errorMessage{
    if(isValid || isPure) return null;
    if(displayError == LastNameError.empty) return 'Required';

     return null;
  }

  @override
  LastNameError? validator(String value) {

      if(value.isEmpty || value.trim().isEmpty) return LastNameError.empty;
    return null;
  }
}