import 'dart:async';

import 'package:attributionmethodtest/AttributionMethod.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LandingScreen extends StatefulWidget {
  final AttributionMethod method;
  LandingScreen({Key key, this.method}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>  with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  Timer _timer;
  int _maxCount = 5;
  int _remainingTime = 5;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) =>
          setState(
                () {
              if (_remainingTime < 1) {
                _remainingTime = _remainingTime - 1;
                timer.cancel();
                onCountDownFinished();
              } else {
                _remainingTime = _remainingTime - 1;
              }
            },
          ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 0.0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();

    startTimer();
  }
  @override
  dispose() {
    _timer.cancel();
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                  ),
                  ScaleTransition(
                      scale: _animation,
                      child: Card(
                        color: Color.fromARGB(212, 255, 255, 255),
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(30),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                    text: '''Please remember to return to this app after installing and launching the ''',
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "AppsFlyer Candy Shop Training",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black)),
                                      TextSpan(text: " App."),
                                    ],
                                  ),
                                ),
                              ),
                              CircularPercentIndicator(
                                radius: 240.0,
                                lineWidth: 16.0,
                                percent: (_remainingTime!=null && _remainingTime<=_maxCount && _remainingTime>0) ? 1-_remainingTime/_maxCount : 1,
                                center: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 60),
                                      child: Text("Redirecting to \nGoogle Play in",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                    Text("0:0${_remainingTime>=_maxCount ? _maxCount : _remainingTime+1 }", style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 60, color: Colors.black)),
                                  ],
                                ),

                                animation: true,
                                animationDuration: 1000,
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Colors.green,
                                animateFromLastPercent: true,

                              ),

                              SizedBox(
                                height: 20,
                              ),
                            ]
                        ),
                      )
                  ),
                ]
            )
          ]
      ),
    );
  }

  void onCountDownFinished() async {
    String url = getAttributionMethodTargetUrl(widget.method);
    print("[onCountDownFinished] open url:\n$url");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}