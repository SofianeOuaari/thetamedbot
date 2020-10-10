import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:thetamedbot/services/splash_service.dart';

class SplashX extends StatefulWidget {
  SplashX(
      {@required this.wx, @required this.splashService, @required this.ctx});
  final dynamic wx;
  final SplashService splashService;
  final BuildContext ctx;
  @override
  _SplashXState createState() => _SplashXState();
}

class _SplashXState extends State<SplashX> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    Timer(
        Duration(seconds: 5),
        () => SchedulerBinding.instance.addPostFrameCallback((_) async {
              if (widget.wx is String) {
                await Navigator.pushReplacementNamed(widget.ctx, widget.wx);
              } else if (widget.wx is Widget) {
                await Navigator.pushReplacement(
                    widget.ctx,
                    MaterialPageRoute(
                        builder: (BuildContext context) => widget.wx));
              } else {
                throw new ArgumentError(
                    'widget.navigateAfterSeconds must either be a String or Widget');
              }
              if (!widget.splashService.isFirst) {
                await widget.splashService.changeIsFirst(true);
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Container(
          //   decoration: BoxDecoration(color: Colors.redAccent),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                          image:
                              AssetImage("assets/logo_thetamedbot_text.png")),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
