import 'package:attributionmethodtest/RemoteConfigManager.dart';
import 'package:attributionmethodtest/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'center_app_bar.dart';
import 'gradient_button.dart';
import 'app_background.dart';
import 'page_route_builders.dart';

class IntroductionScreen extends StatefulWidget {
  final String method;
  IntroductionScreen(this.method);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> with TickerProviderStateMixin  {
  String get _targetAppName => remoteConfig.getString("target_app_name");
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
          ListView(
            children: <Widget>[
              CenterAppBar(),
              ScaleTransition(
                scale: _animation,
                child: Card(
                  color: Color.fromARGB(212, 255, 255, 255),
                  margin: EdgeInsets.fromLTRB(20, 0,20,0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(30),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                            text: 'After clicking the ',
                            children: <TextSpan> [
                              TextSpan(text: "OK",style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                              TextSpan(text: " button below you will be redirected to the Google Play App to install the "),
                              TextSpan(text: _targetAppName, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,
                                  color: Colors.black)),
                              TextSpan(text: " App."),
                              TextSpan(text: '\n\n'),
                              TextSpan(text: 'After installing and launching the '),
                              TextSpan(text: _targetAppName, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,
                                  color: Colors.black)),
                              TextSpan(text: ' App. Please come back to this App for details on how to check the results of your install.'),
                            ],
                          ),
                        ),
//                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: GradientButton(
                                height: 50,
                                margin: EdgeInsets.all(20),
                                buttonText: "Cancel",
                                onPressed: () { Navigator.pop(context); },
                              ),
                            ),
                            Expanded(
                              child: GradientButton(
                                height: 50,
                                margin: EdgeInsets.all(20),
                                buttonText: "OK",
                                onPressed: () {
                                  Navigator.push(context, PlainRouteBuilder(LandingScreen(method: widget.method)));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
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
