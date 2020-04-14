import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:attributionmethodtest/utils/DeviceIdHelper.dart';
import 'package:attributionmethodtest/utils/RemoteConfigManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_user_agent/flutter_user_agent.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../widgets/app_background.dart';
import '../widgets/center_app_bar.dart';
import '../widgets/gradient_button.dart';

class LandingScreen extends StatefulWidget {
  final String method;
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
  String _url;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) =>
          setState(
                () {
              if (_remainingTime < 1) {
                timer.cancel();
                onCountDownFinished();
              }
              _remainingTime = _remainingTime - 1;
            },
          ),
    );
  }

  @override
  void initState() {
    super.initState();
    setupUrl().then((value){
      print("setup URL: $value");
      _url = value;
    }).catchError((err) {
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(err.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                },
              ),
            ],
          );
        },
      );
    });
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
          AppBackground(),
          SafeArea(
            child: CenterAppBar(),
          ),
          Container(
            color: Colors.black54,
          ),
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: ScaleTransition(
                        scale: _animation,
                        child: Center(
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
                                            fontSize: 16,
                                            color: Colors.black87),
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
                                    percent: (_remainingTime != null &&
                                        _remainingTime <= _maxCount &&
                                        _remainingTime > 0)
                                        ? 1 - _remainingTime / _maxCount
                                        : 1,
                                    center: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(top: 60),
                                          child: Text(
                                            "Redirecting to \nGoogle Play in",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                        Text("0:0${_remainingTime >= _maxCount
                                            ? _maxCount
                                            : _remainingTime + 1 }",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 60,
                                                color: Colors.black)),
                                      ],
                                    ),

                                    animation: true,
                                    animationDuration: 1000,
                                    circularStrokeCap: CircularStrokeCap.round,
//                                    progressColor: Colors.indigoAccent,
                                    linearGradient: LinearGradient(
                                      colors: [
                                      Colors.lightBlueAccent,
                                      Colors.deepPurpleAccent,
                                      Colors.indigoAccent,
                                    ],),
                                    animateFromLastPercent: true,

                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: GradientButton(
                                          height: 50,
                                          margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
                                          buttonText: "Cancel",
                                          onPressed: () {
                                            Navigator.popUntil(
                                                context, (route) => route.isFirst);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ]
                            )
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> setupUrl() async {
    print("setupUrl");
    String url = remoteConfig.getString(widget.method+"_url");
    String targetAppId = remoteConfig.getString("target_app_id") ?? "com.candyapp.appsflyer";
    String pid = remoteConfig.getString("pid");
    bool isServerToServer = remoteConfig.getBool(widget.method + "_s2s");
    print("[setupUrl] get remote config of ${widget.method + "_s2s"}: $isServerToServer");
    String deviceId = await DeviceIdHelper.retrieveDeviceId();
    String trackingLink = url.replaceAll("{PID}", pid)
        .replaceAll("{TARGET-APP-ID}", targetAppId)
        .replaceAll("{RANDOM-VALUE}", Random().nextInt(1000).toString())
        .replaceAll("{THE-DEVICE-ID}", deviceId);
    if(isServerToServer){
      http.Response response = await requestClick(trackingLink);
      if(response.statusCode != 200) {
        throw HttpException("Request failed for tracking link: \n$trackingLink");
      } else {
        print("[setupUrl] response 200 ${response.body}");
      }
      trackingLink = "https://play.google.com/store/apps/details?id=$targetAppId";
    }
    return trackingLink;
  }

  void onCountDownFinished() async {
    if (await canLaunch(_url)) {
      if(await launch(_url)) {
        if (Platform.isAndroid)
          SystemNavigator.pop();
        else
          exit(0);
      }
    } else {
      throw 'Could not launch $_url';
    }
  }

  Future<http.Response> requestClick(String trackingLink) async {
    print("[setupUrl] requesting tracking link: \n$trackingLink");
    var userAgent = await FlutterUserAgent.getPropertyAsync('userAgent');
    http.Response response = await http.get(trackingLink, headers: {"user-agent" : userAgent});
    analytics.logEvent(name: "S2S_Click_Request", parameters: { "url": trackingLink, "response_code": response.statusCode, "response_body": response.body });
    return response;
  }
}