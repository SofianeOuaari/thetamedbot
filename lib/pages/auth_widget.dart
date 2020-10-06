import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thetamedbot/models/myuser.dart';
import 'package:thetamedbot/pages/login_page/login_page.dart';
import 'home_page/home_page.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<MyUser> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      if (userSnapshot.hasData) {
        return HomePage(userSnapshot: userSnapshot);
      } else {
        return LoginPage();
      }
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
