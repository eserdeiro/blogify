import 'package:blogify/config/utils/resource.dart';
import 'package:blogify/features/auth/domain/datasources/user_datasource.dart';
import 'package:blogify/features/auth/domain/index.dart';

//Here you will find the firebase implementation

class UserDatasourceImpl extends UserDatasource {

  @override
  Stream<Resource<UserEntity>> getUserById(String id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

}
