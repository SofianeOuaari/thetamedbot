import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thetamedbot/models/myuser.dart';
import 'package:thetamedbot/pages/home_page/home_page.dart';
import 'package:thetamedbot/pages/signin_page/signin_page.dart';
import 'package:thetamedbot/pages/splash_x.dart';
import 'package:thetamedbot/services/splash_service.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget(
      {Key key, @required this.userSnapshot, @required this.splashService})
      : super(key: key);
  final AsyncSnapshot<MyUser> userSnapshot;
  final SplashService splashService;

  @override
  Widget build(BuildContext context) {
    final splash = splashService.isFirst;
    if (userSnapshot.connectionState == ConnectionState.active) {
      if (userSnapshot.hasData) {
        if (splash) {
          return HomePage(userSnapshot: userSnapshot);
        } else {
          return SplashX(
            wx: "/home",
            splashService: splashService,
            ctx: context,
          );
        }
      } else {
        if (splash) {
          return SignInPage();
        } else {
          return SplashX(
            wx: "/sin",
            splashService: splashService,
            ctx: context,
          );
        }
      }
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
