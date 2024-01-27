import 'package:blogify/config/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static Future<bool> isDataInCollection(String data, String form) async {
    final firebaseAuth = FirebaseAuth.instance;
    final userFirebaseAuth = firebaseAuth.currentUser;
    final firebaseFirestore = FirebaseFirestore.instance;
    final CollectionReference usersCollection =
        firebaseFirestore.collection(Strings.usersCollection);

    final existingData =
        await usersCollection.where(form, isEqualTo: data).get();
    if (existingData.docs.isNotEmpty) {
      final existingUserId = existingData.docs.first.id;

      if (existingUserId == userFirebaseAuth?.uid) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  static Future<void> updateEmailInCollectionAndAuth(
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
      await userFirebaseAuth.updateEmail(newEmail).onError((error, _) {
        Error(error.toString());
      });
    }
  }
}