import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';

abstract class UserRepository {
  
  Stream<Resource<UserEntity>> getUserById(String id);

  Stream<Resource<UserEntity>> getCurrentUSer();

    Future<Resource> edit(
    UserEntity user,
  );



}
