import 'package:blogify/config/constants/strings.dart';
import 'package:blogify/presentation/index.dart';
import 'package:formz/formz.dart';

enum GenderError { empty }

class Gender extends FormzInput<GenderType, GenderError> {
  const Gender.pure() : super.pure(GenderType.nn);

  const Gender.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == GenderError.empty) return Strings.required;

    return null;
  }

  @override
  GenderError? validator(GenderType value) {
    if (value == GenderType.nn) return GenderError.empty;
    return null;
  }
}
