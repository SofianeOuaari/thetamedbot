import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MalariaDiagnosis extends StatefulWidget {
  _MalariaDiagnosis createState() => _MalariaDiagnosis();
}

class _MalariaDiagnosis extends State<MalariaDiagnosis> {
  void initState() {
    super.initState();
    loadModel();
  }

  var imageURI;

  final ImagePicker _imagepicker = ImagePicker();
  String res;

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        GestureDetector(
          onTap: () {
            fetchImage();
          },
          child: Container(
            height: 500,
            margin: EdgeInsets.only(top: 50, right: 20, left: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey[300]),
            child: Center(
                child: Text("Fetch Your Image From Here",
                    style: GoogleFonts.oswald(
                        color: Colors.black,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold))),
          ),
        ),
        Center(
            child: Container(
          child: this.res == null
              ? Text("")
              : Center(child:Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Result for This Diagnosis: ",style:GoogleFonts.oswald(fontSize:15.0)),
                    Text(this.res,style: GoogleFonts.oswald(fontWeight:FontWeight.bold,fontSize: 19.0),)
                  ],
                )),
          margin: EdgeInsets.only(top: 25.0, bottom: 25.0),
        ))
      ]),
    );
  }

  void loadModel() async {
    await Tflite.loadModel(
        model: "assets/model_malaria_2.tflite", labels: "assets/labels_2.txt");
  }

  Future<void> fetchImage() async {
    final image = await _imagepicker.getImage(source: ImageSource.gallery);
    classifyImage(File(image.path));
    setState(() {
      imageURI = File(image.path);

      if (imageURI != null) {}
    });
  }

  Future<void> classifyImage(var image) async {
    print(image.path);

    if (image.path != null) {
      final List results = await Tflite.runModelOnImage(
        numResults: 1,
        path: image.path,
      );

      print(results);
      print(results[0]["label"]);
      setState((){
        this.res=results[0]["label"];
      });
    }
  }
}
