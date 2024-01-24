import 'package:blogify/config/utils/resource.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:blogify/features/auth/infrastructure/datasources/auth_datasource_impl.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource datasource;

  AuthRepositoryImpl({
    AuthDataSource? datasource,
  }) : datasource = datasource ?? AuthDatasourceImpl();

  @override
  Future<Resource> checkAuthStatus() {
    return datasource.checkAuthStatus();
  }

  @override
  Future<void> logout() {
    return datasource.logout();
  }

  @override
  Future<Resource> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<Resource> register( UserEntity user, ) {
    return datasource.register(user,);
  }
}
