import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Here you will find the firebase implementation

class UserDatasourceImpl extends UserDatasource {
  @override
  Stream<Resource<UserEntity>> getUserById(String id) {


    try {
          final firebaseFirestore = FirebaseFirestore.instance;
    final users = firebaseFirestore.collection(Strings.usersCollection);
      return users
          .doc(id)
          .snapshots(includeMetadataChanges: true)
          .map((DocumentSnapshot<Map<String, dynamic>> document) {
            if (document.exists) {
              final userData = document.data()!;
              if (document.metadata.hasPendingWrites) {
                return null;
              }
              final userEntity = UserEntity.fromJson(userData);
              return Success(userEntity);
            } else {
              return Error('User $id not found');
            }
          })
          .where((result) => result != null)
          .cast<Resource<UserEntity>>();
    } on FirebaseException catch (e) {
      //print('error datasource impl ${e.code}');
      return Stream.value(Error(e.code));
    }
  }
}
