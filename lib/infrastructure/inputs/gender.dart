import 'package:blogify/presentation/widgets.dart';
import 'package:formz/formz.dart';

// Define input validation errors
enum GenderError { empty }

// Extend FormzInput and provide the input type and error type.
class Gender extends FormzInput<GenderType, GenderError> {
  // Call super.pure to represent an unmodified form input.
  //Initial value
  const Gender.pure() : super.pure(GenderType.nn);

  // Call super.dirty to represent a modified form input.

  const Gender.dirty(super.value) : super.dirty();

  // Override validator to handle validating a given input value.

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == GenderError.empty) return 'Required';

    return null;
  }

  @override
  GenderError? validator(GenderType value) {
    if (value == GenderType.nn) return GenderError.empty;
    return null;
  }
}
