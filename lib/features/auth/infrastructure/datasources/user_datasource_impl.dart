import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserDatasourceImpl extends UserDatasource {
  // Future<void> uploadPhoto(String photo) async{
  //Esto va a retornar un string con la nueva imagen,
  // para poder subirlo a firebase

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
    final firebaseStorage = FirebaseStorage.instance;
    final usersStorageRef = firebaseStorage.ref().child('Users');
    //Compare if user.image equal to user.image on db
    //if true, return uploadtask and more
    //and add try catch
    final file = File(user.image);
    final uploadTask =
        await usersStorageRef.child(generateRandomString()).putFile(
              file,
              SettableMetadata(
                contentType: 'image/jpg',
              ),
            );

    final url = await uploadTask.ref.getDownloadURL();
    user.image = url;
    final completer = Completer<Resource>();
    final userFirebaseAuth = FirebaseHelper.firebaseAuth.currentUser;
    final CollectionReference usersCollection =
        FirebaseHelper.firebaseFirestore.collection(Strings.usersCollection);
    final emailExists =
        await FirebaseHelper.isDataInCollection(user.email, 'email');
    final usernameExists =
        await FirebaseHelper.isDataInCollection(user.username, 'username');

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

String generateRandomString() {
  final random = Random.secure();
  const charactersCode = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

  return String.fromCharCodes(
    List.generate(
      6,
      (index) =>
          charactersCode.codeUnitAt(random.nextInt(charactersCode.length)),
    ),
  );
}
