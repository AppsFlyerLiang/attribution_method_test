import 'package:advertising_id/advertising_id.dart';

class DeviceIdHelper {
  String advertisingId = "";

  Future<String> retrieveDeviceId() async {
    print("[DeviceIdHelper] retrieveDeviceId");
    AdvertisingId.id.then((deviceId) {
      print("[DeviceIdHelper] retrieved advertiserId: $deviceId");
      advertisingId = deviceId;
    }).catchError((error) {
      print("[DeviceIdHelper] failed to get advertiserId: $error");
    });
    return advertisingId;
  }
}

DeviceIdHelper deviceIdHelper = DeviceIdHelper();
