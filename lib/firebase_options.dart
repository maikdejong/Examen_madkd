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
    apiKey: 'AIzaSyAZtXdcGPRAuQ07ptSx5O1zlNIsdAKmrNQ',
    appId: '1:989703457943:web:b9a9a71ad15862be49edd2',
    messagingSenderId: '989703457943',
    projectId: 'fluttermadkd',
    authDomain: 'fluttermadkd.firebaseapp.com',
    storageBucket: 'fluttermadkd.appspot.com',
    measurementId: 'G-YR3C1XMLWY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBkUSc5IhnWCp0fhaIy3xYbn1Z2CrJTjlI',
    appId: '1:989703457943:android:d694fbfceeba76ac49edd2',
    messagingSenderId: '989703457943',
    projectId: 'fluttermadkd',
    storageBucket: 'fluttermadkd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6j8clExbiMvjEtM2oj5tWp_2XeXzy4dk',
    appId: '1:989703457943:ios:9a96c7b304d2a8e949edd2',
    messagingSenderId: '989703457943',
    projectId: 'fluttermadkd',
    storageBucket: 'fluttermadkd.appspot.com',
    iosBundleId: 'com.example.flutterMadkd',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC6j8clExbiMvjEtM2oj5tWp_2XeXzy4dk',
    appId: '1:989703457943:ios:d53a2b9b17e8502c49edd2',
    messagingSenderId: '989703457943',
    projectId: 'fluttermadkd',
    storageBucket: 'fluttermadkd.appspot.com',
    iosBundleId: 'com.example.flutterMadkd.RunnerTests',
  );
}
