import 'package:blogify/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static Future<FirebaseService> init() async{
     await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return FirebaseService();
  }
}
