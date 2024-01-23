import 'package:blogify/features/auth/domain/index.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User> register(
    String email,
    String password,
    String name,
    String lastname,
    String username,
    String gender,
  ) {
    return datasource.register(
      email,
      password,
      name,
      lastname,
      username,
      gender,
    );
  }
}
