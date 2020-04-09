import 'package:attributionmethodtest/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../AttributionMethod.dart';
import 'gradient_button.dart';
import 'page_route_builders.dart';

class IntroductionScreen extends StatefulWidget {
  final AttributionMethod method;
  IntroductionScreen(this.method);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> with TickerProviderStateMixin  {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this, value: 0.0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

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
          Container(
            height: 400,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Colors.purpleAccent, Colors.pinkAccent],
                    [Colors.blueAccent, Colors.deepOrange],
                    [Colors.greenAccent, Colors.lightBlueAccent.shade400],
                    [Colors.redAccent, Colors.limeAccent],
                  ],
                  durations: [35000, 19440, 10800, 6000],
                  heightPercentages: [0.10, 0.11, 0.12, 0.13],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.topRight,
                  gradientEnd: Alignment.bottomLeft,
                ),
                waveAmplitude: 0,
                size: Size(
                  double.infinity,
                  double.infinity,
                ),

              ),
            ),
          ),

          ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(30),
                child: Center(
                  child: Text(
                    '''
AppsFlyer 
Attribution Method
Test App
                      ''',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
              ),
              ScaleTransition(
                scale: _animation,
                child: Card(
                  color: Color.fromARGB(212, 255, 255, 255),
                  margin: EdgeInsets.fromLTRB(20, 0,20,0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(30),
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                            text: 'After clicking the ',
                            children: <TextSpan> [
                              TextSpan(text: "OK",style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                              TextSpan(text: " button below you will be redirected to the Google Play App to install the "),
                              TextSpan(text: "AppsFlyer Candy Shop Training",style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,
                                  color: Colors.black)),
                              TextSpan(text: " App."),
                              TextSpan(text: '\n\n'),
                              TextSpan(text: 'After installing and launching the '),
                              TextSpan(text: 'AppsFlyer Candy Shop Training',style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,
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

  void _onButtonPressed(BuildContext context) {

  }
}
