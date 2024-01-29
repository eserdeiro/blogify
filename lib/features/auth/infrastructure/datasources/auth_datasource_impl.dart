import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDatasourceImpl extends AuthDataSource {
  AuthDatasourceImpl();

  @override
  Future<void> logout() async {
    await FirebaseHelper.firebaseAuth.signOut();
  }

  @override
  Future<Resource> checkAuthStatus() async {
    final user = FirebaseHelper.firebaseAuth.currentUser;
    if (user != null) {
      return Success(user);
    } else {
      return Init();
    }
  }

  @override
  Future<Resource> login(String email, String password) async {
    // Agregar loading
    try {
      final data = await FirebaseHelper.firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Success(data);
    } on FirebaseAuthException catch (e) {
      return Error(e.code);
    }
  }

  @override
  Future<Resource> register(UserEntity user) async {
    try {
      final usernameExists = await FirebaseHelper.isDataInCollection(
        Strings.usersCollection,
        user.username,
        'username',
      );
      if (!usernameExists) {
        final data =
            await FirebaseHelper.firebaseAuth.createUserWithEmailAndPassword(
          email: user.email.trim(),
          password: user.password.trim(),
        );
        user
          ..id = data.user?.uid ?? ''
          ..password = '';
        final CollectionReference usersCollection =
            FirebaseHelper.firebaseFirestore.collection('Users');
        await usersCollection.doc(data.user?.uid ?? '').set(
              user.toJson(),
            );
        return Success(data);
      } else {
        return Error('username-already-in-use');
      }
    } on FirebaseAuthException catch (e) {
      return Error(e.code);
    }
  }
}
