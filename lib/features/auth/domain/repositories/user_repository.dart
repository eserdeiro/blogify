import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';

abstract class UserRepository {
  
  Stream<Resource<UserEntity>> getUserById(String id);

    Future<Resource> edit(
    UserEntity user,
  );

}
