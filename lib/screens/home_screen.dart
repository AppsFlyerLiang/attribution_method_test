import 'package:attributionmethodtest/DeviceIdHelper.dart';
import 'package:attributionmethodtest/screens/introduction_screen.dart';
import 'package:flutter/material.dart';

import '../AttributionMethod.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'gradient_button.dart';
import 'page_route_builders.dart';

class HomeScreen extends StatelessWidget {

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
                    children: <TextSpan>[
                      TextSpan(text: "Referrer",
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(text: ", "),
                      TextSpan(text: "ID Matching",
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(text: ", "),
                      TextSpan(text: "View-Through",
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(text: ", "),
                      TextSpan(text: "Fingerprinting ",
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(text: " for the "),
                      TextSpan(text: "AppsFlyer Candy Shop Training",
                        style: TextStyle(fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,),
                      ),
                      TextSpan(text: " app"),
                    ]
                )),
              ),
              _buildButton(context, AttributionMethod.Referrer),
              _buildButton(context, AttributionMethod.IdMatching),
              _buildButton(context, AttributionMethod.ViewThrough),
              _buildButton(context, AttributionMethod.FingerPrinting),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildButton(BuildContext context, AttributionMethod method) {
    return GradientButton(
      width: 40,
      height: 52,
      margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      buttonText: getAttributionMethodText(method),
      onPressed: () {
        Navigator.push(context, PlainRouteBuilder(IntroductionScreen(method)));
      },
    );
  }

  HomeScreen(){
    deviceIdHelper.retrieveDeviceId();
  }

}
