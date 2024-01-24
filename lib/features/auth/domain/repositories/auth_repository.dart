import 'package:blogify/config/utils/resource.dart';

abstract class AuthRepository {
  Future<Resource> login(
    String email,
    String password,
  );

  Future<Resource> register(
    String email,
    String password,
    String name,
    String lastname,
    String username,
  );

  Future<Resource> checkAuthStatus(String token);

  Future<void> logout();
}
