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
    apiKey: 'AIzaSyDEEUJxFPPv7nsBSzqqRk5wo9rPKvEKfT4',
    appId: '1:12362735019:web:6df8af556a4e35e35bc6ee',
    messagingSenderId: '12362735019',
    projectId: 'reddit-clone-flutter-dca69',
    authDomain: 'reddit-clone-flutter-dca69.firebaseapp.com',
    storageBucket: 'reddit-clone-flutter-dca69.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-EnocizE8ewGUPObnPO60ZZUBd516c0g',
    appId: '1:12362735019:android:5b7e343c45a099b05bc6ee',
    messagingSenderId: '12362735019',
    projectId: 'reddit-clone-flutter-dca69',
    storageBucket: 'reddit-clone-flutter-dca69.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDBu0Nt4alwNncHfSOX93fI4XNAkvKOtCg',
    appId: '1:12362735019:ios:08e8964eda76ff875bc6ee',
    messagingSenderId: '12362735019',
    projectId: 'reddit-clone-flutter-dca69',
    storageBucket: 'reddit-clone-flutter-dca69.appspot.com',
    iosBundleId: 'com.example.redditCloneFlutter',
  );
}
