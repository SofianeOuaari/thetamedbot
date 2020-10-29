import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thetamedbot/models/myuser.dart';
import 'package:google_fonts/google_fonts.dart';
import '../drag_drop/malaria_prediction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<MyUser> userSnapshot;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
              icon: const Icon(FontAwesomeIcons.user),
              tooltip: 'Profile',
              onPressed: () async {
                Navigator.pushNamed(context, "/acc");
              },
            ),
          ],
        ),
        body: /*Container(child: ,)*/ ListView(
          children: <Widget>[
            GestureDetector(onTap:(){
              Navigator.push(context, MaterialPageRoute(builder:(context){
                return MalariaDiagnosis();
              }));
            },child:Container(
              margin: EdgeInsets.only(
                  top: 10.0, bottom: 10.0, right: 30, left: 30.0),
              height: 210,
              width: 100,
              child: Stack(children:<Widget>[Positioned(bottom: 0,child:Center(
                child: Text("Malaria Diagnosis",
                    style: GoogleFonts.oswald(backgroundColor:Colors.white, 
                        fontWeight: FontWeight.bold, fontSize: 14.5)),
              ))]),
              decoration: BoxDecoration( image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/malaria_image.jpg")),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        blurRadius: 1.0,
                        spreadRadius: 1.0)
                  ],
                  border: Border.all(color: Colors.black, width: 3),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
            )),
            Container(
              margin: EdgeInsets.only(
                  top: 10.0, bottom: 10.0, right: 30, left: 30.0),
              height: 210,
              width: 100,
              child: Stack(children:<Widget>[Positioned(bottom: 0,child:Center(
                child: Text("Pneumothrax Diagnosis",
                    style: GoogleFonts.oswald(backgroundColor:Colors.white, 
                        fontWeight: FontWeight.bold, fontSize: 14.5)),
              ))]),
              decoration: BoxDecoration( image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/pneumothorax_image.jpg")),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        blurRadius: 1.0,
                        spreadRadius: 1.0)
                  ],
                  border: Border.all(color: Colors.black, width: 3),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
            ),
           Container(
              margin: EdgeInsets.only(
                  top: 10.0, bottom: 10.0, right: 30, left: 30.0),
              height: 210,
              width: 100,
              child: Stack(children:<Widget>[Positioned(bottom: 0,child:Center(
                child: Text("Skin Cancer Diagnosis",
                    style: GoogleFonts.oswald(backgroundColor:Colors.white, 
                        fontWeight: FontWeight.bold, fontSize: 14.5)),
              ))]),
              decoration: BoxDecoration( image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/skin_cancer_image.jpg")),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        blurRadius: 1.0,
                        spreadRadius: 1.0)
                  ],
                  border: Border.all(color: Colors.black, width: 3),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
            ),
          ],
        ));
  }
}
