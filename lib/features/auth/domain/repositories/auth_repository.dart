import 'package:blogify/config/index.dart';
import 'package:blogify/features/user/domain/index.dart';

abstract class AuthRepository {
  Future<Resource> login(
    String email,
    String password,
  );

  Future<Resource> register(
   UserEntity user,
  );

  Future<Resource> checkAuthStatus();

  Future<void> logout();
}
