import 'dart:async';
import 'package:blogify/config/index.dart';
import 'package:blogify/features/user/domain/index.dart';
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
        return Resource<UserEntity>(ResourceStatus.success, data: userEntity);
      } else {
        // Fix
        return Resource<UserEntity>(
          ResourceStatus.init,
          message: 'ignore this momently',
        );
      }
    });
  }

  @override
  Future<Resource<String>> getCurrentUserId() async {
    try {
      final userFirebaseAuth = FirebaseHelper.firebaseAuth.currentUser;
      final uid = userFirebaseAuth!.uid;
      return Resource<String>(ResourceStatus.success, data: uid);
    } on FirebaseException catch (e) {
      return Resource<String>(ResourceStatus.error, message: e.code);
    }
  }

  @override
  Future<Resource<String>> edit(UserEntity user) async {
    final userFirebaseAuth = FirebaseHelper.firebaseAuth.currentUser;
    final userUid = userFirebaseAuth!.uid;
    if (user.image.isNotEmpty) {
      user.image = await FirebaseHelper.uploadImageAndReturnUrl(
        user.image,
        Strings.usersCollection,
        userUid,
      );
    }
    final completer = Completer<Resource<String>>();
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
      return Resource<String>(
        ResourceStatus.error,
        message: 'username-already-in-use',
      );
    } else if (emailExists) {
      return Resource<String>(
        ResourceStatus.error,
        message: 'email-already-in-use',
      );
    } else {
      final map = <String, dynamic>{
        'id': userUid,
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
          .doc(userUid)
          .update(map)
          .then((value) {
            completer.complete(
              Resource<String>(ResourceStatus.success, data: 'Updated data'),
            );
          })
          .timeout(const Duration(seconds: 15))
          .catchError((e) {
            completer.complete(
              Resource<String>(ResourceStatus.error, message: e.toString()),
            );
          });
      return completer.future;
    }
  }

  @override
  Future<Resource<String>> deleteUser(String password) async {
    final currentUser = FirebaseHelper.firebaseAuth.currentUser!;
    final CollectionReference usersCollection =
        FirebaseHelper.firebaseFirestore.collection(Strings.usersCollection);
    final currentUserUid = currentUser.uid;

    try {
      await currentUser.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: currentUser.email!,
          password: password,
        ),
      );
      await usersCollection.doc(currentUserUid).delete();
      await currentUser.delete();
      return Resource<String>(ResourceStatus.success, data: 'account-deleted');
    } on FirebaseAuthException catch (e) {
      return Resource<String>(ResourceStatus.error, message: e.code);
    } catch (e) {
      return Resource<String>(ResourceStatus.error, message: e.toString());
    }
  }
}
