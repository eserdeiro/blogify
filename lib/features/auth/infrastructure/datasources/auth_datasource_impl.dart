import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:blogify/features/user/domain/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDatasourceImpl extends AuthDataSource {
  AuthDatasourceImpl();

  @override
  Future<void> logout() async {
    await FirebaseHelper.firebaseAuth.signOut();
  }

  @override
  Future<Resource<User?>> checkAuthStatus() async {
    try {
      final user = FirebaseHelper.firebaseAuth.currentUser;
      if (user != null) {
        return Resource<User?>(ResourceStatus.success, data: user);
      } else {
        // Indicar que no hay usuario autenticado (init)
        return Resource<User?>(ResourceStatus.init);
      }
    } catch (e) {
      // Indicar que hubo un error durante la autenticación (error)
      return Resource<User?>(ResourceStatus.error, error: e.toString());
    }
  }

  @override
  Future<Resource<UserCredential?>> login(String email, String password) async {
    try {
      final data = await FirebaseHelper.firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Resource<UserCredential?>(ResourceStatus.success, data: data);
    } on FirebaseAuthException catch (e) {
      return Resource<UserCredential?>(ResourceStatus.error, error: e.code);
    }
  }

  @override
  Future<Resource<UserCredential>> register(UserEntity user) async {
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
        return Resource<UserCredential>(ResourceStatus.success, data: data);
      } else {
        return Resource<UserCredential>(
          ResourceStatus.error,
          error: 'username-already-in-use',
        );
      }
    } on FirebaseAuthException catch (e) {
      return Resource<UserCredential>(ResourceStatus.error, error: e.code);
    }
  }
}
