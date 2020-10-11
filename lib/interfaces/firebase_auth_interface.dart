import 'package:thetamedbot/models/myuser.dart';

abstract class AuthService {
  Future<MyUser> currentUser();
  Future<MyUser> signInWithEmailAndPassword(String email, String password);
  Future<MyUser> createUserWithEmailAndPassword(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> verifyEmailSend();
  Future<void> signOut();
  Stream<MyUser> get onUserStateChanged;
}
