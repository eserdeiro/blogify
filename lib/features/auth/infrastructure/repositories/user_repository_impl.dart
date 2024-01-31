import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:blogify/features/auth/infrastructure/index.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl({
    UserDatasource? datasource,
  }) : datasource = datasource ?? UserDatasourceImpl();

  
  @override
  Stream<Resource<UserEntity>> getUserById(String id) {
    return datasource.getUserById(id);
  }

  @override
  Future<Resource<String>> getCurrentUserId() {
    return datasource.getCurrentUserId();
  }
  
  @override
  Future<Resource> edit(UserEntity user) {
    return datasource.edit(user);
  }
  
  @override
  Future<Resource> deleteUser(String password) {
   return datasource.deleteUser(password);
  }
  
}
