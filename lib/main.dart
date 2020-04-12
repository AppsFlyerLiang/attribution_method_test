import 'package:attributionmethodtest/screens/home_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

import 'utils/RemoteConfigManager.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  analytics.logAppOpen();
  RemoteConfigManager.setup().then((value) {
    runApp(
      MaterialApp(
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        home: HomeScreen(),
      ),
    );
  });
//  runApp(
//    MaterialApp(
//      navigatorObservers: [
//        FirebaseAnalyticsObserver(analytics: analytics),
//      ],
//      home: FutureBuilder<RemoteConfig>(
//        future: RemoteConfigManager.setup(),
//        builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
//          if(snapshot.hasData) {
////            return Container();
//            return MyApp(config: snapshot.data,);
//          } else {
//            return Container();
//          }
//        },
//      ),
//    ),
//  );
}
var logo = AssetImage("assets/icons/launcher.png");
class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: logo,
                width: 256,
                fit: BoxFit.contain,),
              Text("Loading...", style: TextStyle(color: Colors.white70,
                  fontSize: 22,
                  fontStyle: FontStyle.normal),),
            ],
          )
      ),
    );
  }
}

class MyApp extends StatelessWidget {
//  final RemoteConfig config;

//  MyApp({this.config}) : super(listenable: config);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    remoteConfig = config;
    return MaterialApp(
      title: 'AppsFlyer Attribution Method Test App',
      theme: ThemeData(
//        scaffoldBackgroundColor: Colors.black,
//        backgroundColor: Colors.black,
      ),
      home: HomeScreen(),
    );
  }
}