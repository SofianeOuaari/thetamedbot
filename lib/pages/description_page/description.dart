import "package:flutter/material.dart";
import "package:introduction_screen/introduction_screen.dart";
import 'package:thetamedbot/pages/signin_page/signup_page.dart';


class DescriptionPage extends StatefulWidget {
  _DescriptionPage createState() => _DescriptionPage();
}

class _DescriptionPage extends State<DescriptionPage> {
  void _introEnd(context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //return SignUpPage();
      return SignUpPage();
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      pages: [
        PageViewModel(decoration: PageDecoration(pageColor: Colors.white,titleTextStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
          image: Image.asset("assets/Design_1.png"),
          title: "ThetaMedBot",
          body:
              "The medical plateform of tomorrow powered with AI\n Healthcare is an important axis and the backbone of a society. In ThetaMedBot we care about being the tool that utilizes cutting-edge technologies to help physicians and doctors",
        ),
        PageViewModel(decoration: PageDecoration(pageColor: Colors.white,titleTextStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
          image: Image.asset("assets/Design_2.png"),
          title: "Multiple Deep Learning Image Recognition Model",
          body:
              "Making the diagnosis as simple as scanning a picture for quick and accurate results in real-time",
        ),
        PageViewModel(decoration: PageDecoration(pageColor: Colors.white,titleTextStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            image: Image.asset("assets/Design_3_1.png"),
            title: "Multipe Data Format",
            body:
                "Models supporting many image categories and data formats.\n \n X-Rays, Cell Images, Skin Images and Tabular format data")
      ],
      onDone: () => _introEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    ));
  }
}
