import 'dart:io';

import 'package:attributionmethodtest/screens/home_screen.dart';
import 'package:attributionmethodtest/utils/page_route_builders.dart';
import 'package:attributionmethodtest/widgets/app_background.dart';
import 'package:attributionmethodtest/widgets/center_app_bar.dart';
import 'package:attributionmethodtest/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExistingPopup extends StatefulWidget {
  final String appName;
  ExistingPopup({Key key, this.appName}) : super(key: key);

  @override
  _ExistingPopupState createState() => _ExistingPopupState();
}

class _ExistingPopupState extends State<ExistingPopup> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this, value: 0.0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);

    _controller.forward();
  }
  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBackground(),
          SafeArea(
            child: CenterAppBar(),
          ),
          Container(
            color: Colors.black54,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Card(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(30),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 21, color: Colors.black87,),
                            text: 'You already have the \n',
                            children: <TextSpan>[
                              TextSpan(text: widget.appName, style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Menlo',
                                  color: Colors.black)),
                              TextSpan(
                                  text: "  App installed on this device."),
                              TextSpan(text: '\n'),
                              TextSpan(text: '\n'),
                              TextSpan(
                                  text: 'Please uninstall it and return to this app to start an Attribution Test.'
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: GradientButton(
                              height: 50,
                              margin: EdgeInsets.fromLTRB(20, 0, 10, 30),
                              buttonText: "Continue",
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(context, PlainRouteBuilder(
                                  HomeScreen()
                                ), (route) => route==null);
                              },
                            ),
                          ),
                          Expanded(
                            child: GradientButton(
                              height: 50,
                              margin: EdgeInsets.fromLTRB(10, 0, 20, 30),
                              buttonText: "OK",
                              onPressed: () {
                                if (Platform.isAndroid)
                                  SystemNavigator.pop();
                                else
                                  exit(0);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}