import 'package:blogify/config/utils/resource.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDatasourceImpl extends AuthDataSource {
  @override
  Future<Resource> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
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
      print('Sucess firebase login ${data}');
      return Success(data);
    } on FirebaseAuthException catch (e) {
      print('Error auth impl ${e.code}');
      return Error(e.code);
    }
  }

  @override
  Future<Resource> register(String email, String password, String name,
      String lastname, String username) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
