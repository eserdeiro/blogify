import 'package:blogify/config/utils/resource.dart';
import 'package:blogify/features/auth/domain/index.dart';

abstract class AuthDataSource {
  Future<Resource> login(String email, String password);

  Future<Resource> register( UserEntity user,);

  Future<Resource> checkAuthStatus();

  Future<void> logout();
}
