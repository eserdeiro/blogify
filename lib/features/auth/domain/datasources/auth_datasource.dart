import 'package:blogify/features/auth/domain/index.dart';

abstract class AuthDataSource {
  Future<User> login(String email, String password);

  Future<User> register(
    String email,
    String password,
    String name,
    String lastname,
    String username,
    String gender,
  );

  Future<User> checkAuthStatus(String token);
}
