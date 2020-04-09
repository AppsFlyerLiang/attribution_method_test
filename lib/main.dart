import 'package:attributionmethodtest/DeviceIdHelper.dart';
import 'package:attributionmethodtest/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
MaterialColor appPrimaryColor = Colors.teal;
MaterialAccentColor appColorAccent = Colors.tealAccent;
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppsFlyer Attribution Method Test App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[400],
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
//        primarySwatch: appPrimaryColor,
//        accentColor: appColorAccent,
      ),
      home: HomeScreen(),
    );
  }
}