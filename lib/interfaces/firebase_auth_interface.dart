import 'package:thetamedbot/models/myuser.dart';

abstract class AuthService {
  Future<MyUser> currentUser();
  Future<MyUser> signInWithGoogle();
  Future<void> signOut();
  Stream<MyUser> get onUserStateChanged;
  void dispose();
}