import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigManager {
  static Map<String, dynamic> defaults = {
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
  static Future<RemoteConfig> setup() async {
    var remoteConfig = await RemoteConfig.instance;
    remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
    await remoteConfig.setDefaults(defaults);
    retrieve(remoteConfig);
    return remoteConfig;
  }
  static Future<RemoteConfig> retrieve(RemoteConfig remoteConfig) async {
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
}