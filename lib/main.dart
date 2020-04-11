import 'package:attributionmethodtest/screens/home_screen.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import 'RemoteConfigManager.dart';


MaterialColor appPrimaryColor = Colors.teal;
MaterialAccentColor appColorAccent = Colors.tealAccent;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      home: FutureBuilder<RemoteConfig>(
        future: RemoteConfigManager.setup(),
        builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
          return snapshot.hasData
              ? MyApp(config: snapshot.data)
              : Center(
            child: Text("Loading..."),
          );
        },
      )));
}


class MyApp extends AnimatedWidget {
  final RemoteConfig config;

  MyApp({this.config}) : super(listenable: config);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    remoteConfig = config;
    return MaterialApp(
      title: 'AppsFlyer Attribution Method Test App',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 122, 198, 235),
        backgroundColor: Colors.grey[400],
        appBarTheme: AppBarTheme(
          color: appPrimaryColor,
          elevation: 0.0,
        ),
//        buttonTheme: ButtonThemeData(
//          height: 30,
//          textTheme: ButtonTextTheme.primary,
//          shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.all(Radius.circular(30.0))
//          ),
//        ),
        primarySwatch: appPrimaryColor,
        accentColor: appColorAccent,
      ),
      home: HomeScreen(),
    );
  }
}