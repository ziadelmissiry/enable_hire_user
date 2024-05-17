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
    apiKey: 'AIzaSyDHty2NS8nP5WExbI4w-yoHKwg2irWBb7M',
    appId: '1:423588559887:web:d6764dfbfa441f544a377a',
    messagingSenderId: '423588559887',
    projectId: 'enable-hire',
    authDomain: 'enable-hire.firebaseapp.com',
    storageBucket: 'enable-hire.appspot.com',
    measurementId: 'G-SCNXPGNMN4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKmbR66S3J-FiAe-AUQQK4LbbEXZPFmIk',
    appId: '1:423588559887:android:1b63a59318778a5f4a377a',
    messagingSenderId: '423588559887',
    projectId: 'enable-hire',
    storageBucket: 'enable-hire.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQdXGn33JaJxpH4rghrapxPBYWgTG4mGY',
    appId: '1:423588559887:ios:9f5e3040059cce644a377a',
    messagingSenderId: '423588559887',
    projectId: 'enable-hire',
    storageBucket: 'enable-hire.appspot.com',
    iosBundleId: 'com.example.enableHireUser',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAQdXGn33JaJxpH4rghrapxPBYWgTG4mGY',
    appId: '1:423588559887:ios:9f5e3040059cce644a377a',
    messagingSenderId: '423588559887',
    projectId: 'enable-hire',
    storageBucket: 'enable-hire.appspot.com',
    iosBundleId: 'com.example.enableHireUser',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDHty2NS8nP5WExbI4w-yoHKwg2irWBb7M',
    appId: '1:423588559887:web:0595356538069cba4a377a',
    messagingSenderId: '423588559887',
    projectId: 'enable-hire',
    authDomain: 'enable-hire.firebaseapp.com',
    storageBucket: 'enable-hire.appspot.com',
    measurementId: 'G-EX7ZF42VKK',
  );
}