import 'dart:ffi';

import 'package:attributionmethodtest/screens/existing_popup.dart';
import 'package:attributionmethodtest/screens/home_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';

import 'utils/RemoteConfigManager.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  analytics.logAppOpen();
  RemoteConfigManager.setup().then((config) {
    String _targetAppId = config.getString("target_app_id");
    checkTargetAppExisting(_targetAppId).then((yes) {
      Widget firstScreen;
      if (yes) {
        firstScreen = ExistingPopup(
          appName: config.getString("target_app_name"),
        );
      } else {
        firstScreen = HomeScreen();
      }
      runApp(
        MaterialApp(
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          home: firstScreen,
        ),
      );
    });
  });
}

Future<bool> checkTargetAppExisting(String targetAppId) async {
  print("Check isAppEnabled($targetAppId)");
  try {
    return await AppAvailability.isAppEnabled(targetAppId);
  } on Exception catch (err) {
    // ignore error.
  }
  return false;
}