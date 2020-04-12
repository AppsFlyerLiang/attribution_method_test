import 'package:advertising_id/advertising_id.dart';

class DeviceIdHelper {
  static String advertisingId;

  static Future<String> retrieveDeviceId() async {
    print("[DeviceIdHelper] retrieveDeviceId");
    if(advertisingId!=null) return advertisingId;
    else {
      try {
        advertisingId = await AdvertisingId.id;
        print("[DeviceIdHelper] retrieved advertiserId: $advertisingId");
      } on Exception catch(error) {
        print("[DeviceIdHelper] failed to get advertiserId: $error");
      }
    }
    return advertisingId;
  }
}