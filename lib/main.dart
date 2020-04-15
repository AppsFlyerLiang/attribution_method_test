import 'package:attributionmethodtest/screens/existing_popup.dart';
import 'package:attributionmethodtest/screens/home_screen.dart';
import 'package:attributionmethodtest/app.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

void main() {
  App.init().then((result) {
    runApp(
      MaterialApp(
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: App.analytics),
          ],
          theme: ThemeData(
              accentColor: (App.flavorGooglePlayStg == App.flavor)
                  ? Colors.redAccent
                  : Colors.indigoAccent,
              primarySwatch: (App.flavorGooglePlayStg == App.flavor)
                  ? Colors.red
                  : Colors.indigo
          ),
          home: InitResult.targetAppInstalled == result
              ? ExistingPopup(
            appName: App.remoteConfig.getString("target_app_name"),)
              : HomeScreen()
      ),
    );
  });
}

