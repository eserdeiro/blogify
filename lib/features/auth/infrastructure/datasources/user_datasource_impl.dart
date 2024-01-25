import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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


  @override
  Future<Resource> edit(UserEntity user) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final userFirebase = firebaseAuth.currentUser;
        final firebaseFirestore = FirebaseFirestore.instance;
      final CollectionReference usersCollection =
          firebaseFirestore.collection(Strings.usersCollection);
      final map = <String, dynamic>{
        'id': userFirebase!.uid,
        'email': user.email,
        'name': user.name,
        'lastname': user.lastname,
        'username': user.username,
      };
      await usersCollection.doc(userFirebase.uid).update(map);
      return Success(true);
    } on FirebaseAuthException catch (e) {
      print('Error por aqui');
      return Error(e.code);
    }
  }
}
