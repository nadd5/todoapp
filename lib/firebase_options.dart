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
    apiKey: 'AIzaSyBBZ03HBHYPP-XEfYytJbjzx37HrY99NEA',
    appId: '1:530814202175:web:a3b6471a82f9a3faefe38a',
    messagingSenderId: '530814202175',
    projectId: 'todoappp-affe3',
    authDomain: 'todoappp-affe3.firebaseapp.com',
    storageBucket: 'todoappp-affe3.appspot.com',
    measurementId: 'G-97W4GCDN25',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASClUGg1MWFSVdVlDltEp9pF6pCBQOJ3E',
    appId: '1:530814202175:android:790c46d1cc84e4d8efe38a',
    messagingSenderId: '530814202175',
    projectId: 'todoappp-affe3',
    storageBucket: 'todoappp-affe3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDpDe_tyZ07cO6fbkk4R2MQ40w6bR1FH7k',
    appId: '1:530814202175:ios:2ebcfae84e23d323efe38a',
    messagingSenderId: '530814202175',
    projectId: 'todoappp-affe3',
    storageBucket: 'todoappp-affe3.appspot.com',
    iosBundleId: 'com.example.todoappp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDpDe_tyZ07cO6fbkk4R2MQ40w6bR1FH7k',
    appId: '1:530814202175:ios:2ebcfae84e23d323efe38a',
    messagingSenderId: '530814202175',
    projectId: 'todoappp-affe3',
    storageBucket: 'todoappp-affe3.appspot.com',
    iosBundleId: 'com.example.todoappp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBBZ03HBHYPP-XEfYytJbjzx37HrY99NEA',
    appId: '1:530814202175:web:5c14c4023f351de1efe38a',
    messagingSenderId: '530814202175',
    projectId: 'todoappp-affe3',
    authDomain: 'todoappp-affe3.firebaseapp.com',
    storageBucket: 'todoappp-affe3.appspot.com',
    measurementId: 'G-WTG2YZMRTE',
  );

}