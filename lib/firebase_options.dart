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
    apiKey: 'AIzaSyCKj6A_eT-fMGaLWtqB0P-Js3GwGloEX9A',
    appId: '1:562585455476:web:d7d66a9209635d0c9d7a21',
    messagingSenderId: '562585455476',
    projectId: 'msec-9eb8a',
    authDomain: 'msec-9eb8a.firebaseapp.com',
    storageBucket: 'msec-9eb8a.appspot.com',
    measurementId: 'G-LBH82XF342',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADtoPdaZ4UNOm7uva_4SOt-EEeOT7QH7A',
    appId: '1:562585455476:android:12fd11334d40d9899d7a21',
    messagingSenderId: '562585455476',
    projectId: 'msec-9eb8a',
    storageBucket: 'msec-9eb8a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCui702UvWpT1sGMnyGYSrvPR602jFgMwg',
    appId: '1:562585455476:ios:0ef7c00c2ddd3d0d9d7a21',
    messagingSenderId: '562585455476',
    projectId: 'msec-9eb8a',
    storageBucket: 'msec-9eb8a.appspot.com',
    iosBundleId: 'com.example.todoapp',
  );

}