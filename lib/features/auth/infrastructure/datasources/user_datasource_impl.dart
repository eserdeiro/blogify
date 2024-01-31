import 'dart:async';
import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDatasourceImpl extends UserDatasource {
  @override
  //Agregar stream controller para mantener los datos
  Stream<Resource<UserEntity>> getUserById(String id) {
    final users =
        FirebaseHelper.firebaseFirestore.collection(Strings.usersCollection);
    return users
        .doc(id)
        .snapshots(includeMetadataChanges: true)
        .map((DocumentSnapshot<Map<String, dynamic>> document) {
      final userData = document.data();
      if (userData != null) {
        final userEntity = UserEntity.fromJson(userData);
        return Success(userEntity);
      } else {
        // Manejar el caso cuando los datos son nulos
        print('Error');
        return Error('error');
      }
    });
  }

  @override
  Future<Resource<String>> getCurrentUserId() async {
    try {
      final userFirebaseAuth = FirebaseHelper.firebaseAuth.currentUser;
      print('user id ${userFirebaseAuth!.uid}');
      return Success(userFirebaseAuth.uid);
    } on FirebaseException catch (e) {
      return Error(e.code);
    }
  }

  @override
  Future<Resource> edit(UserEntity user) async {
    final userFirebaseAuth = FirebaseHelper.firebaseAuth.currentUser;
    user.image = await FirebaseHelper.uploadImageAndReturnUrl(
      user.image,
      Strings.usersCollection,
      userFirebaseAuth!.uid,
    );

    final completer = Completer<Resource>();
    final CollectionReference usersCollection =
        FirebaseHelper.firebaseFirestore.collection(Strings.usersCollection);
    final emailExists = await FirebaseHelper.isDataInCollection(
      Strings.usersCollection,
      user.email,
      'email',
    );
    final usernameExists = await FirebaseHelper.isDataInCollection(
      Strings.usersCollection,
      user.username,
      'username',
    );

    if (usernameExists) {
      return Error('username-already-in-use');
    } else if (emailExists) {
      return Error('email-already-in-use');
    } else {
      final map = <String, dynamic>{
        'id': userFirebaseAuth.uid,
        'email': user.email,
        'name': user.name,
        'lastname': user.lastname,
        'username': user.username,
        'image': user.image,
      };

      await FirebaseHelper.updateEmailInCollectionAndAuth(
        userFirebaseAuth.uid,
        user.email,
      );

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

  @override
  Future<Resource> deleteUser(String password) async {
    final currentUser = FirebaseHelper.firebaseAuth.currentUser;
    final CollectionReference usersCollection =
        FirebaseHelper.firebaseFirestore.collection(Strings.usersCollection);
    try {
      final currentUser = FirebaseHelper.firebaseAuth.currentUser!;

      await currentUser.delete().then((value) async {
        await usersCollection.doc(currentUser.uid).delete();
      });
      print('account-deleted');
      return Success('account-deleted');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print('required recent login');
        try {
          await currentUser!
              .reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: currentUser.email!,
              password: password,
            ),
          )
              .then((value) async {
            await currentUser.delete();
            await usersCollection.doc(currentUser.uid).delete();
          });
        } on FirebaseAuthException catch (e) {
          print('error xd ${e.code}');
          Error(e.code);
        }
      } else {
        print('Error 1 on requires-recent-login');
        return Error(e.code);
      }
      return Error(e.code);
    }
  }
}
