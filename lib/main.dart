import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thetamedbot/pages/auth_widget.dart';
import 'package:thetamedbot/pages/auth_widget_builder.dart';
import 'package:thetamedbot/pages/home_page/home_page.dart';
import 'package:thetamedbot/pages/signin_page/signin_page.dart';
import 'package:thetamedbot/pages/signin_page/signup_page.dart';
import 'package:thetamedbot/services/firebase_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
      ],
      child: AuthWidgetBuilder(builder: (context, userSnapshot) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'ThetaMedBot',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AuthWidget(
            userSnapshot: userSnapshot,
          ),
          routes: <String, WidgetBuilder>{
            "/home": (context) => HomePage(userSnapshot: userSnapshot),
            "/sin": (context) => SignInPage(),
            "/sup": (context) => SignUpPage(),
          },
        );
      }),
    );
  }
}
