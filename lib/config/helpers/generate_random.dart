import 'dart:math';

class Generate {
  static String randomString() {
    final random = Random.secure();
    const charactersCode =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

    return String.fromCharCodes(
      List.generate(
        6,
        (index) =>
            charactersCode.codeUnitAt(random.nextInt(charactersCode.length)),
      ),
    );
  }
}
