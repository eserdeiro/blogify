import 'package:blogify/config/index.dart';
import 'package:blogify/features/user/domain/index.dart';

abstract class UserRepository {
  
  Stream<Resource<UserEntity>> getUserById(String id);

  Future<Resource<String>> getCurrentUserId();

    Future<Resource> edit(
    UserEntity user,
  );

  Future<Resource> deleteUser(String password);

}
