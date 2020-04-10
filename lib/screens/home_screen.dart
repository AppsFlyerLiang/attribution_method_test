import 'package:attributionmethodtest/DeviceIdHelper.dart';
import 'package:attributionmethodtest/RemoteConfigManager.dart';
import 'package:attributionmethodtest/screens/introduction_screen.dart';
import 'package:flutter/material.dart';

import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'gradient_button.dart';
import 'page_route_builders.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String get _targetAppName => remoteConfig.getString("target_app_name");

  List<String> get _methods => remoteConfig.getString("test_methods").split(",");
  List<String> _methodNames;

  @override
  void initState() {
    super.initState();
    DeviceIdHelper.retrieveDeviceId();
    print(_methods);
    _methodNames = _methods.map((method) => remoteConfig.getString(method+"_name")).toList();
    print(_methodNames);
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
                  heightPercentages: [0.05, 0.07, 0.09, 0.10],
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
                height: 160,
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
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                height: 160,
                child: Text.rich(TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    text: 'Use this app to test the ',
                    children: _introText(),
                )),
              ),
              for(Widget button in _buildButtons(context)) button,
            ],
          ),
        ],
      ),
    );
  }

  List<TextSpan> _introText() {
    List<TextSpan> result = List<TextSpan>();
    for (String methodName in _methodNames) {
      result.add(
          TextSpan(text: "$methodName, ",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black))
      );
      result.add(TextSpan(text: ", "));
    }
    result.removeLast();
    result.addAll(<TextSpan>[
      TextSpan(text: " for the "),
      TextSpan(text: _targetAppName,
        style: TextStyle(fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,),
      ),
      TextSpan(text: " app"),
    ]);
    return result;
  }

  List<Widget> _buildButtons(BuildContext context) {
    List<GradientButton> result = List<GradientButton>();
    for (var i = 0; i < _methods.length && i < _methodNames.length; i++) {
      result.add(GradientButton(
        width: 40,
        height: 52,
        margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        buttonText: "Test ${_methodNames[i]}",
        onPressed: () {
          Navigator.push(
              context, PlainRouteBuilder(IntroductionScreen(_methods[i])));
        },
      ));
    }
    return result;
  }
}
