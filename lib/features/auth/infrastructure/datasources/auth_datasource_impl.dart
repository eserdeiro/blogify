import 'package:blogify/config/utils/resource.dart';
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
  Future<Resource> checkAuthStatus(String token) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final user = firebaseAuth.currentUser;
      if (user != null) {
          print('UID DATA AUTH ${user.uid}');
          print('DATA AUTH $user');
          return Success(user);
      } else {
        return Init();
      }
    } on FirebaseAuthException catch (e) {
      return Error(e.code);
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
      print('DATA FIREBASE LOGIN $data');
      return Success(data);
    } on FirebaseAuthException catch (e) {
      return Error(e.code);
    }
  }

  @override
  Future<Resource> register(
    String email,
    String password,
    String name,
    String lastname,
    String username,
  ) async {
    try {
//       print('''
// DATA FIREBASE REGISTER
//            email: $email,
//            password: $password,
//            name:$name,
//            lastname: $lastname,
//            username: $username,
// ''');
      final firebaseFirestore = FirebaseFirestore.instance;
      final CollectionReference usersCollection =
          firebaseFirestore.collection('Users');
      final firebaseAuth = FirebaseAuth.instance;
      final data = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await usersCollection.doc(data.user?.uid ?? '').set(
            UserEntity(
              id: data.user!.uid,
              email: email,
              name: name,
              lastname: lastname,
              username: username,
            ).toJson(),
          );
      return Success(data);
    } on FirebaseAuthException catch (e) {
      return Error(e.code);
    }
  }
}
