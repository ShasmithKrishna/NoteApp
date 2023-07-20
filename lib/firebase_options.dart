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
        return macos;
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
    apiKey: 'AIzaSyBc-MBw4UQdB7LvwNkR8FhNo2tX0pmkwg8',
    appId: '1:736211392146:web:ce1b75cfcc29cab4c7b84b',
    messagingSenderId: '736211392146',
    projectId: 'fir-1-abf9c',
    authDomain: 'fir-1-abf9c.firebaseapp.com',
    storageBucket: 'fir-1-abf9c.appspot.com',
    measurementId: 'G-YY1R2QB90X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJivylEI3GclfqdTVPy03QH3VnlkBzR4Q',
    appId: '1:736211392146:android:355ede61fe65a215c7b84b',
    messagingSenderId: '736211392146',
    projectId: 'fir-1-abf9c',
    storageBucket: 'fir-1-abf9c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDbs4JhhWbDvX2T2mh2P-_ukqFSis6pb3g',
    appId: '1:736211392146:ios:e0b1141b3293614dc7b84b',
    messagingSenderId: '736211392146',
    projectId: 'fir-1-abf9c',
    storageBucket: 'fir-1-abf9c.appspot.com',
    iosClientId: '736211392146-j2hre0d3utlt22ahujkop23ps7cl3bmo.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebase1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDbs4JhhWbDvX2T2mh2P-_ukqFSis6pb3g',
    appId: '1:736211392146:ios:e0b1141b3293614dc7b84b',
    messagingSenderId: '736211392146',
    projectId: 'fir-1-abf9c',
    storageBucket: 'fir-1-abf9c.appspot.com',
    iosClientId: '736211392146-j2hre0d3utlt22ahujkop23ps7cl3bmo.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebase1',
  );
}