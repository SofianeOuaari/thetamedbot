import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thetamedbot/models/myuser.dart';
import 'package:thetamedbot/pages/home_page/home_page.dart';
import 'package:thetamedbot/pages/signin_page/signin_page.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<MyUser> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      if (userSnapshot.hasData) {
        return HomePage(userSnapshot: userSnapshot);
      } else {
        return SignInPage();
      }
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
