import 'dart:convert';
import 'dart:io';
import 'package:blogify/config/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class FirebaseHelper {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static Future<bool> isDataInCollection(
    String collectionName,
    String data,
    String form,
  ) async {
    final firebaseAuth = FirebaseAuth.instance;
    final userFirebaseAuth = firebaseAuth.currentUser;
    final firebaseFirestore = FirebaseFirestore.instance;
    final CollectionReference collection =
        firebaseFirestore.collection(collectionName);

    final existingData = await collection.where(form, isEqualTo: data).get();
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
      //Change updateEmail from verifyBeforeUpdateEmail
      await userFirebaseAuth.updateEmail(newEmail).onError((error, _) {
        Resource(ResourceStatus.error, message: error.toString());
      });
    }
  }

  static Future<String> uploadImageAndReturnUrl(
    String cacheImage,
    String collection,
    String uid,
  ) async {
    try {
      final firebaseStorage = FirebaseStorage.instance;
      final storageRef = firebaseStorage.ref().child(collection).child(uid);
      if (cacheImage.startsWith('blob')) {
        final response = await http.get(Uri.parse(cacheImage));
        if (response.statusCode != 200) {
          throw Exception('Error download image');
        }
        final dataUrl =
            'data:image/jpeg;base64,${base64Encode(response.bodyBytes)}';
        await storageRef.putString(dataUrl, format: PutStringFormat.dataUrl);
        final downloadUrl = await storageRef.getDownloadURL();
        return downloadUrl;
      } else {
        final file = File(cacheImage);
        final uploadTask =
            await storageRef.child(Generate.randomString()).putFile(
                  file,
                  SettableMetadata(
                    contentType: 'image/jpg',
                  ),
                );
        return uploadTask.ref.getDownloadURL();
      }
    } catch (e) {
      
      return '';
    }
  }
}
