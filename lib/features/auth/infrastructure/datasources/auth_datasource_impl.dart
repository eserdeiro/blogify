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
  Future<Resource> register(
    UserEntity user,
  ) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;
      final CollectionReference usersCollection =
          firebaseFirestore.collection(Strings.usersCollection);
      final firebaseAuth = FirebaseAuth.instance;
      final data = await firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      user
        ..id = data.user?.uid ?? ''
        ..password = '';
      await usersCollection.doc(data.user?.uid ?? '').set(
            user.toJson(),
          );
      return Success(data);
    } on FirebaseAuthException catch (e) {
      return Error(e.code);
    }
  }

  @override
  Future<Resource> edit(UserEntity user) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final userFirebase = firebaseAuth.currentUser;
        final firebaseFirestore = FirebaseFirestore.instance;
      final CollectionReference usersCollection =
          firebaseFirestore.collection(Strings.usersCollection);
      final map = <String, dynamic>{
        'id': userFirebase!.uid,
        'email': user.email,
        'name': user.name,
        'lastname': user.lastname,
        'username': user.username,
      };
      await usersCollection.doc(userFirebase.uid).update(map);
      return Success(true);
    } on FirebaseAuthException catch (e) {
      print('Error por aqui');
      return Error(e.code);
    }
  }
}
