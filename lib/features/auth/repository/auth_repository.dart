import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit_clone_flutter/core/constants/constants.dart';
import 'package:reddit_clone_flutter/core/constants/firebase_constants.dart';
import 'package:reddit_clone_flutter/core/providers/firebase_providers.dart';
import 'package:reddit_clone_flutter/models/user_model.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _firestore = firestore,
        _auth = auth,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  void signInWithGoogle() async {
    try {
      UserCredential userCredential;
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        final googleUser = await (_googleSignIn.signIn());

        final googleAuth = await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        userCredential = await _auth.signInWithCredential(credential);
      }

      final user = userCredential.user;
      if (user != null) {
        final userModel = UserModel(
          uid: user.uid,
          name: user.displayName ?? 'No Name',
          profilePic: user.photoURL ?? Constants.avatarDefault,
          banner: Constants.bannerDefault,
          isAuthenticated: true,
          karma: 0,
          awards: [],
        );
        _users.doc(user.uid).set(userModel.toMap());
      }
    } catch (e) {
      //
      print(e);
    }
  }
}
