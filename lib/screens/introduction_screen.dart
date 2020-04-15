import 'package:attributionmethodtest/utils/RemoteConfigManager.dart';
import 'package:attributionmethodtest/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import '../app.dart';
import '../widgets/center_app_bar.dart';
import '../widgets/gradient_button.dart';
import '../widgets/app_background.dart';
import '../utils/page_route_builders.dart';

class IntroductionScreen extends StatefulWidget {
  final String method;
  IntroductionScreen(this.method);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> with TickerProviderStateMixin  {
  String get _targetAppName => App.remoteConfig.getString("target_app_name");
  AnimationController _controller;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this, value: 0.0);
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
                child: ScaleTransition(
                  scale: _animation,
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
                            text: TextSpan(
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black87),
                              text: 'After clicking the ',
                              children: <TextSpan>[
                                TextSpan(text: "OK", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                                TextSpan(
                                    text: " button "),
                                if(widget.method == "view_through")
                                  TextSpan(
                                      text: " an impression will be recorded by AppsFlyer and "),
                                TextSpan(
                                  text: "you will be redirected to the Google Play App to install the ",
                                ),
                                TextSpan(text: _targetAppName, style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black)),
                                TextSpan(text: " App."),
                                TextSpan(text: '\n\n'),
                                TextSpan(
                                    text: 'After installing and launching the '),
                                TextSpan(text: _targetAppName, style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black)),
                                TextSpan(
                                    text: ' App. Please come back to this App for details on how to check the results of your install.'),
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
                                buttonText: "Cancel",
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Expanded(
                              child: GradientButton(
                                height: 50,
                                margin: EdgeInsets.fromLTRB(10, 0, 20, 30),
                                buttonText: "OK",
                                onPressed: () {
                                  Navigator.push(context, PlainRouteBuilder(
                                      LandingScreen(method: widget.method)));
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
