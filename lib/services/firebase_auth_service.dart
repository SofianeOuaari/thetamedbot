import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thetamedbot/interfaces/firebase_auth_interface.dart';
import 'package:thetamedbot/models/myuser.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  MyUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return MyUser(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoURL);
  }

  @override
  Stream<MyUser> get onUserStateChanged {
    return _firebaseAuth.userChanges().map(_userFromFirebase);
  }

  @override
  Future<MyUser> signInWithGoogle() async {
    UserCredential userCredential;

    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
    } else {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential googleAuthCredential =
          GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential =
          await _firebaseAuth.signInWithCredential(googleAuthCredential);
    }
    return _userFromFirebase(userCredential.user);
  }

  @override
  Future<MyUser> currentUser() async {
    final User user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<void> signOut() async {
    //await googleSignIn.signOut();
    return await _firebaseAuth.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
