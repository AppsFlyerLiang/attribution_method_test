import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';



enum InitResult {
  normal,
  targetAppInstalled,
}
class App {
  static final String flavorGooglePlay = "GooglePlay";
  static final String flavorGooglePlayStg = "GooglePlayStg";
  static FirebaseAnalytics analytics;
  static RemoteConfig remoteConfig;
  static String flavor = "GooglePlay";
  static AppsflyerSdk appsflyerSdk;
  static FirebaseMessaging firebaseMessage = FirebaseMessaging();

  static Future<InitResult> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    firebaseMessage.configure(
      onMessage: onFirebaseMessage,
      onBackgroundMessage: onFirebaseBackgroundMessage,
      onLaunch: onFirebaseLaunch,
      onResume: onFirebaseResume,
    );
    analytics = FirebaseAnalytics();
    analytics.logAppOpen();
    appsflyerSdk = AppsflyerSdk({
      "afDevKey": "SC6zv6Zb6N52vePBePs5Xo",
      "afAppId": "3333999930",
      "isDebug": true
    });
    appsflyerSdk.updateServerUninstallToken(await firebaseMessage.getToken());
    firebaseMessage.onTokenRefresh.listen((deviceToken) {
      print("onTokenRefresh:$deviceToken");
      appsflyerSdk.updateServerUninstallToken(deviceToken);
    });
    appsflyerSdk.initSdk(registerConversionDataCallback: true, registerOnAppOpenAttributionCallback: true);
    remoteConfig = await RemoteConfig.instance;
    await _setupRemoteConfig();
    flavor = remoteConfig.getString("flavor") ?? flavorGooglePlay;



    String _targetAppId = remoteConfig.getString("target_app_id") ?? "com.candyapp.appsflyer";
    if (await _checkTargetAppExisting(_targetAppId)) {
      return InitResult.targetAppInstalled;
    } else {
      return InitResult.normal;
    }
  }

  static Future<RemoteConfig> _setupRemoteConfig() async {
    if(null == remoteConfig) remoteConfig = await RemoteConfig.instance;
    remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
    await remoteConfig.setDefaults(_remoteConfigDefaults);
    _retrieveRemoteConfig(remoteConfig);
    return remoteConfig;
  }
  static Future<RemoteConfig> _retrieveRemoteConfig(RemoteConfig remoteConfig) async {
    print("[RemoteConfigManager] retrieve");
    try {
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      bool result = await remoteConfig.activateFetched();
      print("[RemoteConfigManager] retrieve success:$result");
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print(
          'Unable to fetch remote config. Cached or default values will be '
              'used');
    }
    return remoteConfig;
  }

  static Future<bool> _checkTargetAppExisting(String targetAppId) async {
    print("Check isAppEnabled($targetAppId)");
    try {
      return await AppAvailability.isAppEnabled(targetAppId);
    } on Exception catch (err) {
      // ignore error.
    }
    return false;
  }


  static Future<dynamic> onFirebaseMessage(Map<String, dynamic> message) async {
    print("onFirebaseMessage");
    message.forEach((key, value) {
      print("key: $key, value: $value");

    });
  }

  static Future<dynamic> onFirebaseResume(Map<String, dynamic> message) async {
    print("onFirebaseResume");
    message.forEach((key, value) {
      print("key: $key, value: $value");

    });
  }

  static Future<dynamic> onFirebaseLaunch(Map<String, dynamic> message) async {
    print("onFirebaseLaunch");
    message.forEach((key, value) {
      print("key: $key, value: $value");

    });
  }
}

Future<dynamic> onFirebaseBackgroundMessage(Map<String, dynamic> message) async {
  print("onFirebaseBackgroundMessage");
  message.forEach((key, value) {
    print("key: $key, value: $value");
  });
}

Map<String, dynamic> _remoteConfigDefaults = {
  "flavor":"GooglePlay",
  "pid":"Attribution%20Method%20Testing",
  "test_methods":"referrer,id_matching,view_through,fingerprinting",
  "target_app_id": "com.candyapp.appsflyer",
  "target_app_name": "AppsFlyer Candy Shop Training",
  "referrer_name": "Referrer",
  "referrer_name_s2s": false,
  "referrer_url": "https://app.appsflyer.com/{TARGET-APP-ID}?pid=Attribution%20Method%20Testing&c=Referrer&af_adset={RANDOM-VALUE}&af_fingerprint_attribution=false&af_dp=candyapp%3A%2F%2Freferrer-conversion-results",
  "id_matching_s2s": true,
  "id_matching_name": "ID Matching",
  "id_matching_url": "https://app.appsflyer.com/com.candyapp.appsflyer?pid=Attribution%20Method%20Testing&c=ID-Matching&af_adset={RANDOM-VALUE}&advertising_id={THE-DEVICE-ID}&af_fingerprint_attribution=false&af_dp=candyapp%3A%2F%2Fid-matching-conversion-results",
  "view_through_s2s": true,
  "view_through_name": "View-Through",
  "view_through_url": "https://impression.appsflyer.com/com.candyapp.appsflyer?pid=Attribution%20Method%20Testing&c=View-Through&af_adset={RANDOM-VALUE}&advertising_id={THE-DEVICE-ID}&af_fingerprint_attribution=false&af_dp=candyapp%3A%2F%2Fview-through-conversion-results",
  "fingerprinting_s2s": true,
  "fingerprinting_name": "Fingerprinting",
  "fingerprinting_url": "https://app.appsflyer.com/com.candyapp.appsflyer?pid=Attribution%20Method%20Testing&c=Fingerprinting&af_adset={RANDOM-VALUE}&af_dp=candyapp%3A%2F%2Ffingerprinting-conversion-results",
};
