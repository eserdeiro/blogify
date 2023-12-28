// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAes6CMoHrG1hRxSNh5FLX0FyQYHhNg4dc',
    appId: '1:640500884987:web:1a6feda9037ebb85b7575e',
    messagingSenderId: '640500884987',
    projectId: 'blogify-66154',
    authDomain: 'blogify-66154.firebaseapp.com',
    storageBucket: 'blogify-66154.appspot.com',
    measurementId: 'G-V2FZBZX0B8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBL41q0_AEVicbupadr-tM3b6MpjkTE68A',
    appId: '1:640500884987:android:0807255094cb65fab7575e',
    messagingSenderId: '640500884987',
    projectId: 'blogify-66154',
    storageBucket: 'blogify-66154.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBsllPArGHmkzZipURuQI839LNBdYqPg7M',
    appId: '1:640500884987:ios:23c293fb599caa2eb7575e',
    messagingSenderId: '640500884987',
    projectId: 'blogify-66154',
    storageBucket: 'blogify-66154.appspot.com',
    iosBundleId: 'com.example.blogify',
  );
}