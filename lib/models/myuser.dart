import 'package:flutter/foundation.dart';

@immutable
class MyUser {
  const MyUser(
      {@required this.uid,
      this.email,
      this.photoUrl,
      this.displayName,
      this.emailVerified});

  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;
  final bool emailVerified;
}
