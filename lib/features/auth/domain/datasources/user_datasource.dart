import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';

abstract class UserDatasource {
  Stream<Resource<UserEntity>> getUserById(String id);

  Future<Resource> edit(
    UserEntity user,
  );
}
