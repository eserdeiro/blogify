import 'package:blogify/presentation/index.dart';

class Formats {
  static String getGenderSelected(GenderType gender) {
    switch (gender) {
      case GenderType.male:
        return 'Male';
      case GenderType.female:
        return 'Female';
      case GenderType.nn:
        return 'Gender';
    }
  }
}
