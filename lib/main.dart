import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:thetamedbot/pages/auth_widget.dart';
import 'package:thetamedbot/pages/auth_widget_builder.dart';
import 'package:thetamedbot/services/firebase_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
          title: 'ThetaMedBot',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen(
            seconds: 15,
            navigateAfterSeconds:
                AuthWidget(userSnapshot: userSnapshot) /*MainPage()*/,
            image: Image.asset("assets/logo_thetamedbot_text.png"),
            backgroundColor: Color(0xffe3fdfd),
            photoSize: 130,
          ),
        );
      }),
    );
  }
}
