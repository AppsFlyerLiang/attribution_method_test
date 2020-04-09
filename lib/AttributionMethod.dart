import 'dart:math';

import 'DeviceIdHelper.dart';

enum AttributionMethod {
  Referrer,
  IdMatching,
  ViewThrough,
  FingerPrinting,
}
String getAttributionMethodText(AttributionMethod attributionMethod){
  switch(attributionMethod) {
    case AttributionMethod.Referrer:
      return "Referrer";
      break;
    case AttributionMethod.IdMatching:
      return "ID Matching";
      break;
    case AttributionMethod.ViewThrough:
      return "View-Through";
      break;
    case AttributionMethod.FingerPrinting:
      return "Fingerprinting";
      break;
  }
  return null;
}

String getAttributionMethodTargetUrl(AttributionMethod attributionMethod) {
  String adSet = Random().nextInt(100000000).toString();
  String deviceId = deviceIdHelper.advertisingId;
  switch(attributionMethod) {
    case AttributionMethod.Referrer:
      return "https://app.appsflyer.com/com.candyapp.appsflyer?pid=Attribution%20Method%20Testing&c=Referrer&af_adset=${adSet}&af_fingerprint_attribution=false";
      break;
    case AttributionMethod.IdMatching:
      return "https://app.appsflyer.com/com.candyapp.appsflyer?pid=Attribution%20Method%20Testing&c=ID-Matching&af_adset=${adSet}&advertising_id=${deviceId}&af_r=https%3A%2F%2Fafmasterclassadver.wixsite.com%2Fmc-setup%2Fattribution-method-testing&af_fingerprint_attribution=false ";
      break;
    case AttributionMethod.ViewThrough:
      return "https://impression.appsflyer.com/com.candyapp.appsflyer?pid=Attribution%20Method%20Testing&c=View-Through&af_adset=${adSet}&advertising_id=${deviceId}&af_fingerprint_attribution=false ";
      break;
    case AttributionMethod.FingerPrinting:
      return "https://app.appsflyer.com/com.candyapp.appsflyer?pid=Attribution%20Method%20Testing&c=Fingerprinting&af_adset=${adSet}&af_r=https%3A%2F%2Fafmasterclassadver.wixsite.com%2Fmc-setup%2Fattribution-method-testing";
      break;
  }
  return null;
}