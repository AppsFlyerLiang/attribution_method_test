import 'package:attributionmethodtest/utils/DeviceIdHelper.dart';
import 'package:attributionmethodtest/utils/RemoteConfigManager.dart';
import 'package:attributionmethodtest/screens/introduction_screen.dart';
import 'package:attributionmethodtest/widgets/app_background.dart';
import 'package:flutter/material.dart';
import '../widgets/center_app_bar.dart';
import '../widgets/gradient_button.dart';
import '../utils/page_route_builders.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String get _targetAppName => remoteConfig.getString("target_app_name");
  List<String> get _methods => remoteConfig.getString("test_methods").split(",");
  List<String> _methodNames;
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    DeviceIdHelper.retrieveDeviceId();
    _methodNames = _methods.map((method) => remoteConfig.getString(method+"_name")).toList();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this, value: 0.0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
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
      ScaleTransition(
        scale: _animation,
        child: ListView(
              children: <Widget>[
                CenterAppBar(),
                Container(
                  height: 200,
                  padding: EdgeInsets.only(left: 30, right: 30,),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Use this app to test the ',
                        style: TextStyle(fontSize: 18,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black87,
                                  offset: Offset(1, 1),
                                  blurRadius: 2)
                            ]),
                        children: _introText(),
                      )
                  ),
                ),
                for(Widget button in _buildButtons(context)) button,
              ],
            ),
      ),
          ],
        ),
//      ),
    );
  }

  List<TextSpan> _introText() {
    List<TextSpan> result = List<TextSpan>();
    for (String methodName in _methodNames) {
      result.add(
          TextSpan(text: "$methodName, ",
              style: TextStyle(fontWeight: FontWeight.bold))
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
        width: double.infinity,
        height: 52,
        margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        buttonText: "Test ${_methodNames[i]}",
        onPressed: () {
          Navigator.push(
              context, PlainRouteBuilder(IntroductionScreen(_methods[i]))
          );
        },
      ));
    }
    return result;
  }
}
