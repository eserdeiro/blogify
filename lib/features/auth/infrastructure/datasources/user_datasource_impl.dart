import 'dart:async';
import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      final userData = document.data()!;
      final userEntity = UserEntity.fromJson(userData);
      return Success(userEntity);
    });
  }

  @override
  Future<Resource> edit(UserEntity user) async {
    user.image = await FirebaseHelper.uploadImageAndReturnUrl(
      user.image,
      Strings.usersCollection,
    );
    final completer = Completer<Resource>();
    final userFirebaseAuth = FirebaseHelper.firebaseAuth.currentUser;
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
        'id': userFirebaseAuth!.uid,
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
}
