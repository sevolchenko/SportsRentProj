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
    apiKey: 'AIzaSyDgnnfUV-9N26M-vLjkUu0p6uX00K2B9jY',
    appId: '1:1078425573818:web:525c208cd20cca4eb12583',
    messagingSenderId: '1078425573818',
    projectId: 'renty-65ead',
    authDomain: 'renty-65ead.firebaseapp.com',
    storageBucket: 'renty-65ead.appspot.com',
    measurementId: 'G-CHJXXLKRZR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2cuaIoer9KhtQYgRq9s9L2dQj5I64-HA',
    appId: '1:1078425573818:android:9e0918560392ab6cb12583',
    messagingSenderId: '1078425573818',
    projectId: 'renty-65ead',
    storageBucket: 'renty-65ead.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaFR3jFR1YTuVCawHvx2fdF4a-9XloDEs',
    appId: '1:1078425573818:ios:ec07a13cc8c52d4fb12583',
    messagingSenderId: '1078425573818',
    projectId: 'renty-65ead',
    storageBucket: 'renty-65ead.appspot.com',
    iosClientId: '1078425573818-fgrc54lvho31jqt59jm02n9a7iv2bnn5.apps.googleusercontent.com',
    iosBundleId: 'vsu.csf.client',
  );
}
