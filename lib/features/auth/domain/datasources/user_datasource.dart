import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';

abstract class UserDatasource {
  Stream<Resource<UserEntity>> getUserById(String id);

  Stream<Resource<UserEntity>> getCurrentUSer();

  Future<Resource> edit(
    UserEntity user,
  );
}
