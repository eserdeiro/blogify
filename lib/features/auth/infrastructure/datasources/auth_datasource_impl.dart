import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Here you will find the firebase implementation

class AuthDatasourceImpl extends AuthDataSource {
  @override
  Future<void> logout() async {
    final firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut();
  }

  @override
  Future<Resource> checkAuthStatus() async {
    final firebaseAuth = FirebaseAuth.instance;
    final user = firebaseAuth.currentUser;
    print('object ${user?.email}');
    if (user != null) {
      return Success(user);
    } else {
      return Init();
    }
  }

  @override
  Future<Resource> login(String email, String password) async {
    //TODO ADD LOADING
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final data = await firebaseAuth.signInWithEmailAndPassword(
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
      // Verify if user exists
      final usernameExists = await checkIfUsernameExists(user.username.trim());
      if (!usernameExists) {

      final firebaseAuth = FirebaseAuth.instance;
      final data = await firebaseAuth.createUserWithEmailAndPassword(
        email: user.email.trim(),
        password: user.password,
      );
        user
          ..id = data.user?.uid ?? ''
          ..password = '';
        final firebaseFirestore = FirebaseFirestore.instance;
        final CollectionReference usersCollection =
            firebaseFirestore.collection('Users');
        await usersCollection.doc(data.user?.uid ?? '').set(
              user.toJson(),
            );
        return Success(data);
      } 
      else {
        return Error('username-already-in-use');
      }
    } on FirebaseAuthException catch (e) {
      return Error(e.code);
    }
  }

  Future<bool> checkIfUsernameExists(String username) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;
      final CollectionReference usersCollection =
          firebaseFirestore.collection('Users');
      final query =
          await usersCollection.where('username', isEqualTo: username).get();
      return query.docs.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

    Future<bool> checkIfEmailExists(String email) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;
      final CollectionReference usersCollection =
          firebaseFirestore.collection('Users');
      final query =
          await usersCollection.where('email', isEqualTo: email).get();
      return query.docs.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
