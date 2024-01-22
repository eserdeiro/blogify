import 'package:formz/formz.dart';

// Define input validation errors
enum EmailError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Email extends FormzInput<String, EmailError> {

  static final emailRegex = RegExp(  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  // Call super.pure to represent an unmodified form input.
   //Initial value
  const Email.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
 
  const Email.dirty(super.value) : super.dirty();

  // Override validator to handle validating a given input value.

  String? get errorMessage{
    if(isValid || isPure) return null;
    if(displayError == EmailError.empty) return 'Required';
    if(displayError == EmailError.format) return 'Doesnt have a format...';

     return null;
  }

  @override
  EmailError? validator(String value) {
  
      if(value.isEmpty || value.trim().isEmpty) return EmailError.empty;

      if(!emailRegex.hasMatch(value)) return EmailError.format;
    return null;
    // return value.isEmpty ? UsernameError.empty : null;
  }
}
