import 'dart:async';

import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Here you will find the firebase implementation

class UserDatasourceImpl extends UserDatasource {
  @override
  Stream<Resource<UserEntity>> getUserById(String id) {
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
  }

  @override
  Future<Resource> edit(UserEntity user) async {
    final completer = Completer<Resource>();

    final firebaseAuth = FirebaseAuth.instance;
    final userFirebaseAuth = firebaseAuth.currentUser;
    final firebaseFirestore = FirebaseFirestore.instance;
    final CollectionReference usersCollection =
        firebaseFirestore.collection(Strings.usersCollection);
    final map = <String, dynamic>{
      'id': userFirebaseAuth!.uid,
      'email': user.email,
      'name': user.name,
      'lastname': user.lastname,
      'username': user.username,
    };

    await usersCollection
        .doc(userFirebaseAuth.uid)
        .update(map)
        .then((value) {
          completer.complete(Success(''));
        })
        .timeout(const Duration(seconds: 5))
        .catchError((e) {
          print('error aca aaaa ');
          completer.complete(Error(e));
        });

    return completer.future;
  }
}
