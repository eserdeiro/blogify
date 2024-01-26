import 'dart:async';

import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDatasourceImpl extends UserDatasource {
  @override
  //Agregar stream controller para mantener los datos
  Stream<Resource<UserEntity>> getUserById(String id) {
    final firebaseFirestore = FirebaseFirestore.instance;
    final users = firebaseFirestore.collection(Strings.usersCollection);
    return users
        .doc(id)
        .snapshots(includeMetadataChanges: true)
        .map((DocumentSnapshot<Map<String, dynamic>> document) {
      final userData = document.data()!;
      final userEntity = UserEntity.fromJson(userData);
      return Success(userEntity);
    });
  }

  @override
  Future<Resource> edit(UserEntity user) async {
    final completer = Completer<Resource>();
    final firebaseAuth = FirebaseAuth.instance;
    final userFirebaseAuth = firebaseAuth.currentUser;
    final firebaseFirestore = FirebaseFirestore.instance;
    final CollectionReference usersCollection =
        firebaseFirestore.collection(Strings.usersCollection);
    final emailExists =
        await isEmailInCollection(user.email);
    final usernameExists = await isUsernameInCollection(user.username);
    if (usernameExists) {
      return Error('username-already-in-use');
    } else if (emailExists) {
      return Error('email-already-in-use');
    } else {
      final map = <String, dynamic>{
        'id': userFirebaseAuth!.uid,
        'email': user.email,
        'name': user.name,
        'lastname': user.lastname,
        'username': user.username,
      };

      await updateEmailInCollectionAndAuth(userFirebaseAuth.uid, user.email);

      await usersCollection
          .doc(userFirebaseAuth.uid)
          .update(map)
          .then((value) {
            completer.complete(Success(''));
          })
          .timeout(const Duration(seconds: 5))
          .catchError((e) {
            completer.complete(Error(e.toString()));
          });

      return completer.future;
    }
  }


   Future<bool> isEmailInCollection(String email) async {
    final firebaseAuth = FirebaseAuth.instance;
    final userFirebaseAuth = firebaseAuth.currentUser;
    final firebaseFirestore = FirebaseFirestore.instance;
    final CollectionReference usersCollection =
        firebaseFirestore.collection(Strings.usersCollection);

    final existingEmail =
        await usersCollection.where('email', isEqualTo: email).get();
    if (existingEmail.docs.isNotEmpty) {
      final existingUserId = existingEmail.docs.first.id;

      if (existingUserId == userFirebaseAuth?.uid) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
 


  Future<bool> isUsernameInCollection(String username) async {
    final firebaseAuth = FirebaseAuth.instance;
    final userFirebaseAuth = firebaseAuth.currentUser;
    final firebaseFirestore = FirebaseFirestore.instance;
    final CollectionReference usersCollection =
        firebaseFirestore.collection(Strings.usersCollection);

    final existingUser =
        await usersCollection.where('username', isEqualTo: username).get();

    if (existingUser.docs.isNotEmpty) {
      final existingUserId = existingUser.docs.first.id;

      if (existingUserId == userFirebaseAuth?.uid) {
  
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Future<void> updateEmailInCollectionAndAuth(
    String userId,
    String newEmail,
  ) async {
    final firebaseFirestore = FirebaseFirestore.instance;
    final CollectionReference usersCollection =
        firebaseFirestore.collection(Strings.usersCollection);
    final map = <String, dynamic>{
      'email': newEmail,
    };

    await usersCollection
        .doc(userId)
        .update(map)
        .timeout(const Duration(seconds: 5));

    final firebaseAuth = FirebaseAuth.instance;
    final userFirebaseAuth = firebaseAuth.currentUser;
    if (userFirebaseAuth != null) {
      //cambiar update email por verifyBeforeUpdateEmail, y agregar la validacion de correo
      await userFirebaseAuth.updateEmail(newEmail).onError((error, _) =>  Error(error.toString()));
    }
  }
}
