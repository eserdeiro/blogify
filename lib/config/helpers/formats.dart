import 'package:blogify/presentation/widgets.dart';

class Formats {
  static String getGenderSelected(GenderType? gender) {
  switch (gender) {
    case GenderType.male:
      return 'Male';
    case GenderType.female:
      return 'Female';
    case null:
      return 'Gender';
   } 
  }
}