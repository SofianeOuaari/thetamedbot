import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
        
        primarySwatch: Colors.teal,//Colors.teal,
        primaryColor: Colors.teal[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(seconds: 15,navigateAfterSeconds: MainPage(),image: Image.asset("assets/logo_thetamedbot_text.png") ,backgroundColor: Color(0xffe3fdfd),photoSize: 130,),
    
    );
  }
}