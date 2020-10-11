import 'package:firebase_auth/firebase_auth.dart';
import 'package:thetamedbot/interfaces/firebase_auth_interface.dart';
import 'package:thetamedbot/models/myuser.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  MyUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return MyUser(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        emailVerified: user.emailVerified);
  }

  @override
  Stream<MyUser> get onUserStateChanged {
    return _firebaseAuth.userChanges().map(_userFromFirebase);
  }

  @override
  Future<MyUser> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential;
    userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(userCredential.user);
  }

  @override
  Future<MyUser> createUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential;
    userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(userCredential.user);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> verifyEmailSend() async {
    await _firebaseAuth.currentUser.sendEmailVerification();
  }

  @override
  Future<MyUser> currentUser() async {
    final User user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    return _userFromFirebase(null);
  }
}
