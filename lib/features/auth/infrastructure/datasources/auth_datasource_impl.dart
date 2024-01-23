import 'package:blogify/features/auth/domain/index.dart';

class AuthDatasourceImpl extends AuthDataSource {
  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<User> register(String email, String password, String name, String lastname, String username, String gender) {
    // TODO: implement register
    throw UnimplementedError();
  }

}
