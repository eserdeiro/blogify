import 'package:blogify/config/utils/resource.dart';
import 'package:blogify/features/auth/domain/datasources/user_datasource.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:blogify/features/auth/domain/repositories/user_repository.dart';
import 'package:blogify/features/auth/infrastructure/datasources/user_datasource_impl.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl({
    UserDatasource? datasource,
  }) : datasource = datasource ?? UserDatasourceImpl();

  
  @override
  Stream<Resource<UserEntity>> getUserById(String id) {
    return datasource.getUserById(id);
  }
}
