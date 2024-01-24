import 'package:blogify/config/utils/resource.dart';
import 'package:blogify/features/auth/domain/datasources/user_datasource.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Here you will find the firebase implementation

class UserDatasourceImpl extends UserDatasource {
  @override
  Stream<Resource<UserEntity>> getUserById(String id) {
    final firebaseFirestore = FirebaseFirestore.instance;
    final users = firebaseFirestore.collection('Users');

    try {
      return users
          .doc(id)
          .snapshots(includeMetadataChanges: true)
          .map((DocumentSnapshot<Map<String, dynamic>> document) {
            if (document.exists) {
              final userData = document.data()!;
              //final userId = userData['id'];
              if (document.metadata.hasPendingWrites) {
                return null;
              }
              final userEntity = UserEntity.fromJson(userData);
              return Success(userEntity);
            } else {
              return Error('Usuario $id no encontrado');
            }
          })
          .where((result) => result != null)
          .cast<Resource<UserEntity>>();
    } on FirebaseException catch (e) {
      print('error ${e.code}');
      return Stream.value(Error(e.code));
    }
  }
}
