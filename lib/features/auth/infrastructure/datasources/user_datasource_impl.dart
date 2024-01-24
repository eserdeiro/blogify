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
          final userId = userData['id'];
          print('User ID: $userId User Data: ${userData}');
          final userEntity = UserEntity.fromJson(userData);
          return Success(userEntity);
        } else {
          print('User with ID $id not found.');
          return Error('User not found');
        }
      });
    } on FirebaseException catch (e) {
      return Stream.value(Error(e.code));
      //Throw Error(e.code)
    }
  }
}
