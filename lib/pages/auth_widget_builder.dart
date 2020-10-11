import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thetamedbot/models/myuser.dart';
import 'package:thetamedbot/services/firebase_auth_service.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<MyUser>) builder;
  @override
  Widget build(BuildContext context) {
    final authService = context.watch<FirebaseAuthService>();
    return StreamBuilder<MyUser>(
      stream: authService.onUserStateChanged,
      builder: (context, snapshot) {
        final MyUser user = snapshot.data;
        return MultiProvider(
          providers: [
            Provider<MyUser>(
              create: (_) => user,
            ),
          ],
          child: builder(context, snapshot),
        );
      },
    );
  }
}
