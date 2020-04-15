import 'package:attributionmethodtest/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class AppBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image(image: AssetImage(App.flavorGooglePlayStg == App.flavor ? "assets/images/bg_dark.jpg" : "assets/images/bg_ocean.jpg",),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,),
        ),
//        Container(
//          height: 400,
//          child: RotatedBox(
//            quarterTurns: 2,
//            child: WaveWidget(
//              config: CustomConfig(
//                gradients: [
////                  [Colors.redAccent, Colors.orangeAccent],
////                  [Colors.greenAccent, Colors.blueAccent.shade400],
////                  [Colors.deepPurpleAccent, Colors.pinkAccent],
//                  [Colors.tealAccent, Colors.deepPurpleAccent],
//                  [Colors.limeAccent, Colors.cyanAccent,],
//                  [Colors.indigoAccent, Colors.lightBlueAccent],
//                  [
//                    Colors.redAccent,
//                    Colors.redAccent,
//                    Colors.orangeAccent,
//                    Colors.yellowAccent,
//                    Colors.greenAccent,
//                    Colors.blueAccent,
//                    Colors.indigoAccent,
//                    Colors.purpleAccent,
//                    Colors.purpleAccent
//                  ],
//                ],
//                durations: [35000, 19440, 10800, 35000],
//                heightPercentages: [0.04, 0.06, 0.09, 0.10],
//                blur: MaskFilter.blur(BlurStyle.solid, 10),
//                gradientBegin: Alignment.topRight,
//                gradientEnd: Alignment.bottomLeft,
//              ),
//              waveAmplitude: 0,
//              size: Size(
//                double.infinity,
//                double.infinity,
//              ),
//            ),
//          ),
//        ),
      ],
    );
  }
}