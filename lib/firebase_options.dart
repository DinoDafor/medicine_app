// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyC4ABBep-5JXOY_Wv2ROXjWE_rkQvkdjrY',
    appId: '1:317240731908:web:784561faadfed4ba270851',
    messagingSenderId: '317240731908',
    projectId: 'irecipe-b98ef',
    authDomain: 'irecipe-b98ef.firebaseapp.com',
    storageBucket: 'irecipe-b98ef.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDo4OdYqoyJI0Q6eVxf6XJi6ApSWxeRz_s',
    appId: '1:317240731908:android:ff3da336918ac14e270851',
    messagingSenderId: '317240731908',
    projectId: 'irecipe-b98ef',
    storageBucket: 'irecipe-b98ef.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5QnGLQnfNodfFgg_kJLZKJl94Jkvlo1c',
    appId: '1:317240731908:ios:ebe81d6d5c954bf0270851',
    messagingSenderId: '317240731908',
    projectId: 'irecipe-b98ef',
    storageBucket: 'irecipe-b98ef.appspot.com',
    iosBundleId: 'com.example.medicineApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB5QnGLQnfNodfFgg_kJLZKJl94Jkvlo1c',
    appId: '1:317240731908:ios:ebe81d6d5c954bf0270851',
    messagingSenderId: '317240731908',
    projectId: 'irecipe-b98ef',
    storageBucket: 'irecipe-b98ef.appspot.com',
    iosBundleId: 'com.example.medicineApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC4ABBep-5JXOY_Wv2ROXjWE_rkQvkdjrY',
    appId: '1:317240731908:web:16f55fb3a99513a1270851',
    messagingSenderId: '317240731908',
    projectId: 'irecipe-b98ef',
    authDomain: 'irecipe-b98ef.firebaseapp.com',
    storageBucket: 'irecipe-b98ef.appspot.com',
  );
}