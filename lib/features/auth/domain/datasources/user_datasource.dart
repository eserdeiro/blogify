import 'package:blogify/config/utils/resource.dart';
import 'package:blogify/features/auth/domain/index.dart';

abstract class UserDatasource {
  
  Stream<Resource<UserEntity>> getUserById(String id);

}
