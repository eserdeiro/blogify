import 'package:blogify/config/utils/resource.dart';
import 'package:blogify/features/auth/domain/index.dart';

abstract class UserRepository {
  
  Stream<Resource<UserEntity>> getUserById(String id);

}
